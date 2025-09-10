import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/screens/player/ui/player_screen.dart';
import 'package:musicapp/screens/playlist/ui/playlist_screen.dart';

import '../bloc/playerbloc/player_bloc.dart';
import '../bloc/playerbloc/player_state.dart';
import 'home/ui/home_screen.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            // 1. Agar panel open hai -> collapse karo
            if (state.panelController != null &&
                state.panelController!.isPanelOpen) {
              state.panelController!.close();
              return false;
            }

            // 2. Agar nested navigator back jaa sakta hai -> pop karo
            if (_navigatorKey.currentState!.canPop()) {
              _navigatorKey.currentState!.pop();
              return false;
            }

            // 3. Agar home par ho aur panel collapsed hai -> exit app
            return true;
          },
          child: Scaffold(
            body: Stack(
              children: [
                Navigator(
                  key: _navigatorKey,
                  onGenerateRoute: (settings) {
                    if (settings.name == '/playlist') {
                      final args = settings.arguments as Map<String, dynamic>?;
                      return MaterialPageRoute(
                        builder: (_) => PlaylistScreen(
                          playlistId: args?['playlistId'] ?? '',
                          playlistName: args?['playlistName'] ?? 'Unknown',
                        ),
                      );
                    }
                    return MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    );
                  },
                ),
                if (state.isVisible) const PlayerPanel(),
              ],
            ),
          ),
        );
      },
    );
  }
}
