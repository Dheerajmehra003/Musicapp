import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/constants/image_path.dart';
import 'package:musicapp/widgets/text_widget.dart';

import '../../../bloc/playlist/playlist_bloc.dart';
import '../../../bloc/playlist/playlist_event.dart';
import '../../../bloc/playlist/playlist_state.dart';
import '../../../repositories/playlistrepo/playlistrepository.dart';
import '../widget/horizontal_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leadingWidth: 300,
        toolbarHeight: 70,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
          child: Row(
            spacing: 5,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
                child: TextWidget(title: 'D'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(0, 0),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.black,
                ),
                child: TextWidget(title: 'All', weight: FontWeight.w400),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(0, 0),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.orange, width: 2),
                ),
                child: TextWidget(title: 'Rap', weight: FontWeight.w400),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(0, 0),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.orange, width: 2),
                ),
                child: TextWidget(title: 'Desi-Mix', weight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 9,
            children: [
              // Top Row Cards (unchanged)
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        spacing: 7,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              image: DecorationImage(
                                image: AssetImage(americangirl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          TextWidget(
                            title: 'RAP 91 Hindi',
                            color: Colors.white,
                            weight: FontWeight.w800,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        spacing: 7,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              image: DecorationImage(
                                image: AssetImage(americangirl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          TextWidget(
                            title: 'RAP 91 Hindi',
                            color: Colors.white,
                            weight: FontWeight.w800,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        spacing: 7,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              image: DecorationImage(
                                image: AssetImage(americangirl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          TextWidget(
                            title: 'RAP 91 Hindi',
                            color: Colors.white,
                            weight: FontWeight.w800,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        spacing: 7,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              image: DecorationImage(
                                image: AssetImage(americangirl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          TextWidget(
                            title: 'RAP 91 Hindi',
                            color: Colors.white,
                            weight: FontWeight.w800,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),

              // Jump Back In! Playlist (Rap)
              TextWidget(
                title: 'Jump Back In!',
                color: Colors.white,
                weight: FontWeight.w600,
                size: 20,
              ),
              BlocProvider(
                create: (_) =>
                    PlaylistBloc(JamendoRepository())
                      ..add(LoadPlaylists(tag: "rap")),
                child: BlocBuilder<PlaylistBloc, PlaylistState>(
                  builder: (context, state) {
                    if (state is PlaylistLoading) {
                      return SizedBox(
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                        ),
                      );
                    } else if (state is PlaylistLoaded) {
                      return HorizontalMusicList(
                        items: state.playlists.map((playlist) {
                          return {
                            'image':
                                playlist['image'] != null &&
                                    playlist['image'].toString().isNotEmpty
                                ? playlist['image'].toString()
                                : africangirl,
                            'id': playlist['id'],
                            'title': playlist['name'] ?? 'Unknown Artist',
                          };
                        }).toList(),
                      );
                    } else if (state is PlaylistError) {
                      return SizedBox(
                        height: 150,
                        child: Center(
                          child: TextWidget(
                            title: "Failed to load playlists",
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),

              // Made For You Playlist (Desi)
              TextWidget(
                title: 'Made For You',
                color: Colors.white,
                weight: FontWeight.w600,
                size: 20,
              ),
              BlocProvider(
                create: (_) =>
                    PlaylistBloc(JamendoRepository())
                      ..add(LoadPlaylists(tag: "desi")),
                child: BlocBuilder<PlaylistBloc, PlaylistState>(
                  builder: (context, state) {
                    if (state is PlaylistLoading) {
                      return SizedBox(
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                        ),
                      );
                    } else if (state is PlaylistLoaded) {
                      return HorizontalMusicList(
                        items: state.playlists.map((playlist) {
                          return {
                            'image':
                                playlist['image'] != null &&
                                    playlist['image'].toString().isNotEmpty
                                ? playlist['image'].toString()
                                : africangirl,
                            'id': playlist['id'],
                            'title': playlist['name'] ?? 'Unknown Artist',
                          };
                        }).toList(),
                      );
                    } else if (state is PlaylistError) {
                      return SizedBox(
                        height: 150,
                        child: Center(
                          child: TextWidget(
                            title: "Failed to load playlists",
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),

              // Based on recent listening (All)
              TextWidget(
                title: 'Based on your recent listening',
                color: Colors.white,
                weight: FontWeight.w600,
                size: 20,
              ),
              BlocProvider(
                create: (_) =>
                    PlaylistBloc(JamendoRepository())
                      ..add(LoadPlaylists()), // all playlists
                child: BlocBuilder<PlaylistBloc, PlaylistState>(
                  builder: (context, state) {
                    if (state is PlaylistLoading) {
                      return SizedBox(
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                        ),
                      );
                    } else if (state is PlaylistLoaded) {
                      return HorizontalMusicList(
                        items: state.playlists.map((playlist) {
                          return {
                            'image':
                                playlist['image'] != null &&
                                    playlist['image'].toString().isNotEmpty
                                ? playlist['image'].toString()
                                : africangirl,
                            'id': playlist['id'],
                            'title': playlist['name'] ?? 'Unknown Artist',
                          };
                        }).toList(),
                      );
                    } else if (state is PlaylistError) {
                      return SizedBox(
                        height: 150,
                        child: Center(
                          child: TextWidget(
                            title: "Failed to load playlists",
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
