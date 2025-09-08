import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/constants/image_path.dart';
import 'package:musicapp/widgets/text_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../bloc/playerbloc/player_bloc.dart';
import '../../../bloc/playerbloc/player_event.dart';

class PlayerPanel extends StatefulWidget {
  const PlayerPanel({super.key});

  @override
  State<PlayerPanel> createState() => _PlayerPanelState();
}

class _PlayerPanelState extends State<PlayerPanel> {
  final PanelController panelController = PanelController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlayerBloc>().add(SetPanelController(panelController));
    });
  }

  Future<bool> _onWillPop() async {
    if (panelController.isPanelOpen) {
      // Step 1: Collapse the panel if open
      panelController.close();
      return false; // Do not navigate away
    } else {
      // Step 2: Panel is collapsed -> navigate to home screen
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      return false; // Prevent default back behavior
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SlidingUpPanel(
        controller: panelController,
        minHeight: 70,
        maxHeight: MediaQuery.of(context).size.height,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        panelBuilder: (scrollController) {
          return PlayerScreen(scrollController: scrollController);
        },
        collapsed: const MiniPlayer(),
      ),
    );
  }
}

/// Full Player
class PlayerScreen extends StatelessWidget {
  final ScrollController scrollController;
  const PlayerScreen({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(americangirl),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top bar
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.rotate(
                      angle: -1.57,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          context.read<PlayerBloc>().add(ClosePlayer());
                        },
                      ),
                    ),
                    Center(
                      child: TextWidget(
                        title: 'RAP 91 Hindi',
                        color: Colors.white,
                        weight: FontWeight.w600,
                      ),
                    ),
                    const Icon(Icons.more_horiz, color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 390),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(americangirl)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          title: "Seedha Maut",
                          size: 22,
                          weight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        TextWidget(
                          title: "Krishna",
                          size: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.add_circle_outline_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Slider(
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey.shade700,
                    value: 60,
                    min: 0,
                    max: 180,
                    onChanged: (value) {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "1:00",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          "3:00",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.shuffle, color: Colors.grey, size: 26),
                  const Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                    size: 40,
                  ),
                  Container(
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      size: 45,
                      color: Colors.black,
                    ),
                  ),
                  const Icon(Icons.skip_next, color: Colors.white, size: 40),
                  const Icon(Icons.repeat, color: Colors.grey, size: 26),
                ],
              ),
              const Spacer(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

/// Mini Player (collapsed version)
class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.black87,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(americangirl)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              "Seedha Maut - Krishna",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const Icon(Icons.play_arrow, color: Colors.white, size: 30),
          const SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.close, color: Colors.white, size: 30),
            onPressed: () {
              context.read<PlayerBloc>().add(HidePlayer());
            },
          ),
        ],
      ),
    );
  }
}
