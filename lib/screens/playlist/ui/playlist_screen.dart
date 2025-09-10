import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/constants/image_path.dart';
import 'package:musicapp/widgets/text_widget.dart';

import '../../../bloc/playlist_track/playlist_track_bloc.dart';
import '../../../bloc/playlist_track/playlist_track_event.dart';
import '../../../bloc/playlist_track/playlist_track_state.dart';
import '../../../repositories/playlistrepo/playlistrepository.dart';
import '../widget/songList_widget.dart';

class PlaylistScreen extends StatelessWidget {
  final String playlistId; // pass playlist id when opening this screen
  final String playlistName;
  const PlaylistScreen({
    super.key,
    required this.playlistId,
    required this.playlistName,
  });

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      return false;
    }

    List<Map<String, String>> mySongs = [
      {
        'image': americangirl,
        'title': 'Seedha Maut',
        'artist': 'Krishna',
        'duration': '3:45',
      },
      {
        'image': africangirl,
        'title': 'Song 2',
        'artist': 'Artist 2',
        'duration': '4:12',
      },
      {
        'image': profilPic,
        'title': 'Song 3',
        'artist': 'Artist 3',
        'duration': '3:50',
      },
      {
        'image': profilPic,
        'title': 'Song 3',
        'artist': 'Artist 3',
        'duration': '3:50',
      },
      {
        'image': profilPic,
        'title': 'Song 3',
        'artist': 'Artist 3',
        'duration': '3:50',
      },
      {
        'image': profilPic,
        'title': 'Song 3',
        'artist': 'Artist 3',
        'duration': '3:50',
      },
      {
        'image': profilPic,
        'title': 'Song 3',
        'artist': 'Artist 3',
        'duration': '3:50',
      },
      {
        'image': profilPic,
        'title': 'Song 3',
        'artist': 'Artist 3',
        'duration': '3:50',
      },
      {
        'image': profilPic,
        'title': 'Song 3',
        'artist': 'Artist 3',
        'duration': '3:50',
      },
      {
        'image': profilPic,
        'title': 'Song 3',
        'artist': 'Artist 3',
        'duration': '3:50',
      },
      {
        'image': profilPic,
        'title': 'Song 3',
        'artist': 'Artist 3',
        'duration': '3:50',
      },
      {
        'image': profilPic,
        'title': 'Song 3',
        'artist': 'Artist 3',
        'duration': '3:50',
      },
    ];
    return BlocProvider(
      create: (_) =>
          PlaylistTracksBloc(JamendoRepository())
            ..add(LoadPlaylistTracks(playlistId)),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.black,
              iconTheme: IconThemeData(
                color: Colors.white, // All icons on AppBar will be white
              ),
              pinned: true,
              expandedHeight: 300,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  double maxHeight = 300;
                  double minHeight = kToolbarHeight;
                  double currentHeight = constraints.biggest.height;

                  // Collapse percentage (0 = collapsed, 1 = expanded)
                  double percentage =
                      (currentHeight - minHeight) / (maxHeight - minHeight);
                  if (percentage > 1) percentage = 1;
                  if (percentage < 0) percentage = 0;

                  // Image scale and vertical shift
                  double scale = 0.8 + 0.2 * percentage;
                  double translateY =
                      50 * (1 - percentage); // move up as it collapses

                  return FlexibleSpaceBar(
                    centerTitle: true,
                    title: Opacity(
                      opacity: 1 - percentage, // fade in title
                      child: TextWidget(
                        title: playlistName,
                        size: 17,
                        weight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    background:
                        BlocBuilder<PlaylistTracksBloc, PlaylistTracksState>(
                          builder: (context, state) {
                            String imageUrl = americangirl; // fallback image
                            if (state is PlaylistTracksLoaded &&
                                state.tracks.isNotEmpty) {
                              imageUrl =
                                  state.tracks[0]['image'] ??
                                  americangirl; // use first track image
                            }

                            return AnimatedOpacity(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                              opacity: percentage,
                              child: Transform.translate(
                                offset: Offset(0, 50 * (1 - percentage)),
                                child: Transform.scale(
                                  scale: 0.8 + 0.2 * percentage,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 30.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        height: 250,
                                        width: 250,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                          image: DecorationImage(
                                            image: imageUrl.startsWith('http')
                                                ? NetworkImage(imageUrl)
                                                : AssetImage(imageUrl)
                                                      as ImageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white.withOpacity(
                                                0.2,
                                              ),
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              offset: Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: 'Best of Hindi Hip-Hop! Cover:Karma',
                      color: Colors.grey,
                      size: 13,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: AssetImage(americangirl),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(color: Colors.grey, width: 2),
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.add_circle_outline_outlined,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.downloading_outlined, color: Colors.grey),
                        SizedBox(width: 10),
                        Icon(Icons.more_horiz_outlined, color: Colors.grey),
                        Spacer(),
                        Icon(
                          Icons.repeat_one_sharp,
                          color: Colors.green,
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.play_circle_fill_outlined,
                          color: Colors.green,
                          size: 50,
                        ),
                      ],
                    ),

                    BlocBuilder<PlaylistTracksBloc, PlaylistTracksState>(
                      builder: (context, state) {
                        if (state is PlaylistTracksLoading) {
                          return SizedBox(
                            height: 150,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.orange,
                              ),
                            ),
                          );
                        } else if (state is PlaylistTracksLoaded) {
                          List<Map<String, dynamic>> trackList = state.tracks
                              .map((track) {
                                return {
                                  'image':
                                      track['image'] != null &&
                                          track['image']!.isNotEmpty
                                      ? track['image']!
                                      : africangirl,
                                  'title': track['name'] ?? 'Unknown',
                                  'artist': track['artist'] ?? 'Unknown Artist',
                                  'audio': track['audio'] ?? '',
                                  'duration':
                                      track['duration']?.toString() ?? '0',
                                };
                              })
                              .toList();

                          return SongList(songs: trackList);
                        } else if (state is PlaylistTracksError) {
                          return SizedBox(
                            height: 150,
                            child: Center(
                              child: Text(
                                'Failed to load tracks',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
