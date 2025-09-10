import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart' hide PlayerState;
import 'package:musicapp/widgets/text_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../bloc/playerbloc/player_bloc.dart';
import '../../../bloc/playerbloc/player_event.dart';
import '../../../bloc/playerbloc/player_state.dart';

class PlayerPanel extends StatefulWidget {
  const PlayerPanel({super.key});

  @override
  State<PlayerPanel> createState() => _PlayerPanelState();
}

class _PlayerPanelState extends State<PlayerPanel> {
  final PanelController panelController = PanelController();
  final AudioPlayer audioPlayer = AudioPlayer(); // Audio player instance

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlayerBloc>().add(SetPanelController(panelController));
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlayerBloc, PlayerState>(
      listener: (context, state) async {
        // Play or pause audio based on state
        try {
          await audioPlayer.setUrl(state.audioUrl!);
          if (state.isPlaying) {
            audioPlayer.play();
          } else {
            audioPlayer.pause();
          }
        } catch (e) {
          print("Audio playback error: $e");
        }
      },
      child: BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, state) {
          return SlidingUpPanel(
            controller: panelController,
            minHeight: 70,
            maxHeight: MediaQuery.of(context).size.height,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            panelBuilder: (scrollController) {
              return PlayerScreen(
                scrollController: scrollController,
                state: state,
                audioPlayer: audioPlayer,
              );
            },
            collapsed: MiniPlayer(state: state, audioPlayer: audioPlayer),
          );
        },
      ),
    );
  }
}

/// Full Player
class PlayerScreen extends StatelessWidget {
  final ScrollController scrollController;
  final PlayerState state;
  final AudioPlayer audioPlayer;

  const PlayerScreen({
    super.key,
    required this.scrollController,
    required this.state,
    required this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(state.image!),
            fit: BoxFit.cover,
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
                    Expanded(
                      child: Center(
                        child: TextWidget(
                          title: state.title!,
                          color: Colors.white,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Icon(Icons.more_horiz, color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              /// Album Art and Song Info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(state.image!),

                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          title: state.title!,
                          size: 22,
                          weight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        TextWidget(
                          title: state.artist!,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.add_circle_outline_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              /// Slider
              StreamBuilder<Duration>(
                stream: audioPlayer.positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  final total = audioPlayer.duration ?? Duration(seconds: 180);
                  return Column(
                    children: [
                      Slider(
                        activeColor: Colors.white,
                        inactiveColor: Colors.grey.shade700,
                        value: position.inSeconds.toDouble().clamp(
                          0,
                          total.inSeconds.toDouble(),
                        ),
                        min: 0,
                        max: total.inSeconds.toDouble(),
                        onChanged: (value) {
                          audioPlayer.seek(Duration(seconds: value.toInt()));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${total.inMinutes}:${(total.inSeconds % 60).toString().padLeft(2, '0')}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),

              /// Playback Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.shuffle, color: Colors.grey, size: 26),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {},
                  ),
                  Container(
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        state.isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 45,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (state.isPlaying) {
                          context.read<PlayerBloc>().add(PauseSong());
                        } else {
                          context.read<PlayerBloc>().add(ResumeSong());
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.skip_next, color: Colors.white, size: 40),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.repeat, color: Colors.grey, size: 26),
                    onPressed: () {},
                  ),
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

/// Mini Player
class MiniPlayer extends StatelessWidget {
  final PlayerState state;
  final AudioPlayer audioPlayer;

  const MiniPlayer({super.key, required this.state, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          /// Album Art
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              state.image ?? '',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 50,
                width: 50,
                color: Colors.grey[800],
                child: const Icon(Icons.music_note, color: Colors.white70),
              ),
            ),
          ),
          const SizedBox(width: 12),

          /// Song Info
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.title ?? "Unknown Title",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  state.artist ?? "Unknown Artist",
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          /// Play/Pause Button
          IconButton(
            icon: Icon(
              state.isPlaying
                  ? Icons.pause_circle_filled
                  : Icons.play_circle_fill,
              color: Colors.greenAccent,
              size: 40,
            ),
            onPressed: () {
              if (state.isPlaying) {
                context.read<PlayerBloc>().add(PauseSong());
              } else {
                context.read<PlayerBloc>().add(ResumeSong());
              }
            },
          ),

          /// Close Button
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white70, size: 26),
            onPressed: () {
              context.read<PlayerBloc>().add(HidePlayer());
            },
          ),
        ],
      ),
    );
  }
}
