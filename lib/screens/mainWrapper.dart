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
    return WillPopScope(
      onWillPop: () async {
        // If nested navigator can pop, go back
        if (_navigatorKey.currentState != null &&
            _navigatorKey.currentState!.canPop()) {
          _navigatorKey.currentState!.pop();
          return false;
        }
        // Otherwise, exit app from home
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Navigator(
              key: _navigatorKey,
              onGenerateRoute: (settings) {
                if (settings.name == '/playlist') {
                  return MaterialPageRoute(
                    builder: (_) => const PlaylistScreen(),
                  );
                }
                return MaterialPageRoute(builder: (_) => const HomeScreen());
              },
            ),
            BlocBuilder<PlayerBloc, PlayerState>(
              builder: (context, state) {
                if (!state.isVisible) return const SizedBox.shrink();
                return PlayerPanel(); // your mini-player
              },
            ),
          ],
        ),
      ),
    );
  }
}
