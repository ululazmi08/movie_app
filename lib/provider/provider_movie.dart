import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/model_movie_popular.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/utils/constant.dart';

class ProviderMovie extends ChangeNotifier {
  List<DataMoviePopular> listMoviePopular = [];
  bool loading = false;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  ProviderMovie() {
    getPopular();
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
}
