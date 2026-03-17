import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/core/config/constants.dart';
import 'package:movies_app/models/popular.dart';

class Apimanger {
  static List<Map<String, dynamic>> searchresult = [];
  static List<Map<String, dynamic>> morlist = [];
  static const _popular =
      "https://${Constants.basUrl}/3/movie/popular?api_key=${Constants.apiKey}";
  static const _newReleases =
      "https://${Constants.basUrl}/3/movie/upcoming?api_key=${Constants.apiKey}";
  static const _recomended =
      "https://${Constants.basUrl}/3/movie/top_rated?api_key=${Constants.apiKey}";

  Future<List<Popular>> getPopular() async {
    final response = await http.get(
      Uri.parse(_popular),
    );
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((popular) => Popular.fromJson(popular)).toList();
    } else {
      throw Exception("somthing happened");
    }
  }

  Future<List<Popular>> getNewReleases() async {
    final response = await http.get(
      Uri.parse(_newReleases),
    );
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((popular) => Popular.fromJson(popular)).toList();
    } else {
      throw Exception("somthing happened");
    }
  }

  Future<List<Popular>> getReconended() async {
    final response = await http.get(
      Uri.parse(_recomended),
    );
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((popular) => Popular.fromJson(popular)).toList();
    } else {
      throw Exception("somthing happened");
    }
  }

  Future getMoreLikeThis(List id) async {
    String id1 = "${id.first},${id.lastOrNull}";
    final searchurl =
        "https://api.themoviedb.org/3/movie/$id1/similar?api_key=ab1f280e922b6b691e6dc48ebcc93693";
    final searchresponse = await http.get(Uri.parse(searchurl));
    if (searchresponse.statusCode == 200) {
      var tempdata = jsonDecode(searchresponse.body);
      var searchjson = tempdata['results'];
      for (var i = 0; i < searchjson.length; i++) {
        if (searchjson[i]['poster_path'] != null &&
            searchjson[i]['title'] != null &&
            searchjson[i]['release_date'] != null &&
            searchjson[i]['genre_ids'] != null &&
            searchjson[i]['vote_average'] != null) {
          morlist.add({
            'poster_path': searchjson[i]['poster_path'],
            'title': searchjson[i]['title'],
            'release_date': searchjson[i]['release_date'],
            'genre_ids': searchjson[i]['genre_ids'],
            'vote_average': searchjson[i]['vote_average'],
          });

          if (searchresult.length > 20) {
            searchresult.removeRange(20, searchresult.length);
          }
        }
      }
    }
  }

  Future<void> getSearch(textval) async {
    final searchurl =
        'https://api.themoviedb.org/3/search/multi?api_key=ab1f280e922b6b691e6dc48ebcc93693&query&query=$textval';
    final searchresponse = await http.get(Uri.parse(searchurl));
    if (searchresponse.statusCode == 200) {
      var tempdata = jsonDecode(searchresponse.body);
      var searchjson = tempdata['results'];
      for (var i = 0; i < searchjson.length; i++) {
        if (searchjson[i]['poster_path'] != null &&
            searchjson[i]['title'] != null &&
            searchjson[i]['release_date'] != null) {
          searchresult.add({
            'poster_path': searchjson[i]['poster_path'],
            'title': searchjson[i]['title'],
            'release_date': searchjson[i]['release_date'],
          });

          if (searchresult.length > 20) {
            searchresult.removeRange(20, searchresult.length);
          }
        }
      }
    }
  }
}
