import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/image_path.dart';

class JamendoRepository {
  final String clientId = "cda24319";
  final String baseUrl = "https://api.jamendo.com/v3.0";

  Future<List<Map<String, dynamic>>> getPlaylists({
    String? tag,
    int limit = 10,
  }) async {
    String url =
        "$baseUrl/playlists/?client_id=$clientId&format=json&limit=$limit";
    if (tag != null) {
      url += "&tags=$tag";
    }
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final playlists = data['results'] as List;

      List<Map<String, dynamic>> result = [];

      for (var playlist in playlists) {
        String playlistId = playlist['id'].toString();
        String image = "";

        // Get the first track image
        final tracks = await getTracks(playlistId);
        if (tracks.isNotEmpty && tracks[0]['image'] != null) {
          image = tracks[0]['image'];
        }

        result.add({
          "id": playlistId,
          "name": playlist["name"] ?? "Unknown",
          "artist": playlist["user_name"] ?? "Unknown Artist",
          "image": image.isNotEmpty ? image : africangirl, // fallback
        });
      }

      return result;
    } else {
      throw Exception("Failed to fetch playlists");
    }
  }

  Future<List<Map<String, dynamic>>> getTracks(String playlistId) async {
    final url =
        "$baseUrl/tracks/?client_id=$clientId&format=json&limit=20&playlist_id=$playlistId";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List).map((track) {
        return {
          "id": track["id"].toString(),
          "name": track["name"] ?? "Unknown",
          "artist": track["artist_name"] ?? "Unknown",
          "audio": track["audio"] ?? "",
          "image": track["album_image"] ?? "",
          "duration": track["duration"]?.toString() ?? "0",
        };
      }).toList();
    } else {
      throw Exception("Failed to fetch tracks");
    }
  }
}
