import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/model_movie_detail.dart';
import 'package:movie_app/model/model_movie_popular.dart';
import 'package:movie_app/utils/constant.dart';

class ProviderMovieDetail extends ChangeNotifier {
  ModelMovieDetail? dataMovieDetail;
  bool loading = false;
  DataMoviePopular? dataPopular;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  ProviderMovieDetail(this.dataPopular) {
    getDetail();
  }

  Future<void> getDetail() async {
    loading = true;
    notifyListeners();

    Response res = await http.get(
      Uri.parse(
          '${baseUrl}${dataPopular!.id.toString()}?api_key=10519cf149c9f94197de615918c46d3d&language=en-US'),
    );
    print('Ini data Movie Detail :\n ${res.body}');

    loading = false;
    notifyListeners();

    if(res.statusCode == 200) {
      dataMovieDetail = modelMovieDetailFromJson(res.body);
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