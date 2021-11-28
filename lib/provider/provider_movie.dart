import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/model_movie_popular.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/model_movie_upcoming.dart';
import 'package:movie_app/utils/constant.dart';

class ProviderMovie extends ChangeNotifier {
  List<DataMoviePopular>? listMoviePopular = [];
  List<DataMovieUpcoming>? listMovieUpcoming = [];
  bool loading = false;
  bool loadingUpc = false;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController cari = TextEditingController();
  List filter = [];
  String query = '';
  bool isCari = false;

  ProviderMovie() {
    getPopular();
    getUpcoming();
    cari.addListener(() {
      if (cari.text.isEmpty) {
        isCari = false;
        query = '';
        notifyListeners();
      } else {
        isCari = true;
        query = cari.text;
        searchMovie();
      }
    });
  }

  Future<void> getPopular() async {
    loading = true;
    notifyListeners();

    Response res = await http.get(
      Uri.parse(
          '${baseUrl}popular?api_key=10519cf149c9f94197de615918c46d3d'),
    );
    print('Ini data Movie Popular :\n ${res.body}');

    loading = false;
    notifyListeners();

    if(res.statusCode == 200) {
      List<DataMoviePopular>? dataMoviePopular = modelMoviePopularFromJson(res.body).results;
      listMoviePopular = dataMoviePopular!;
      notifyListeners();
    } else {
      ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text('Error'),
        ),
      );
    }
  }

  Future<void> getUpcoming() async {
    loadingUpc = true;
    notifyListeners();

    Response res = await http.get(
      Uri.parse(
          '${baseUrl}upcoming?api_key=10519cf149c9f94197de615918c46d3d&page=2'),
    );
    print('Ini data Movie Upcoming :\n ${res.body}');

    loadingUpc = false;
    notifyListeners();

    if(res.statusCode == 200) {
      List<DataMovieUpcoming>? dataListMovieUpcoming = modelMovieUpcomingFromJson(res.body).results;
      listMovieUpcoming = dataListMovieUpcoming!;
      notifyListeners();
    } else {
      ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text('Error'),
        ),
      );
    }
  }

  Future<void> searchMovie() async {
    filter = [];
    for (int i = 0; i < listMoviePopular!.length; i++) {
      var item = listMoviePopular![i];
      if (item.title!.toLowerCase().contains(query.toLowerCase())) {
        filter.add(item);
      }
      else if (item.overview!.toLowerCase().contains(query.toLowerCase())) {
        filter.add(item);
      }
      else if (item.voteAverage!.toString().contains(query.toLowerCase())) {
        filter.add(item);
      }
    }
    notifyListeners();
  }
}
