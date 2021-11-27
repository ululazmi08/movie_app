import 'package:flutter/material.dart';
import 'package:movie_app/model/model_movie_popular.dart';
import 'package:movie_app/provider/provider_movie_detail.dart';
import 'package:movie_app/utils/constant.dart';
import 'package:provider/provider.dart';

class HomeDetailPage extends StatefulWidget {
  DataMoviePopular? dataPopular;
  HomeDetailPage(this.dataPopular);

  @override
  _HomeDetailPageState createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProviderMovieDetail(widget.dataPopular),
      child: Consumer<ProviderMovieDetail>(
        builder: (BuildContext context, value, Widget? child) => Scaffold(
          backgroundColor: mainColor,
          appBar: _emptyAppBar(),
          body: value.loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(children: [
                        Image.network(
                          '${imageUrl}${value.dataMovieDetail?.backdropPath ?? ''}',
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Positioned(
                          // left: 0,
                          bottom: 0,
                          // right: 0,
                          child: Container(
                            color: Colors.black.withOpacity(0.5),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              value.dataMovieDetail?.originalTitle ?? '',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ]),
                    ),
                    Container(
                      height: 20,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: value.dataMovieDetail?.genres?.length,
                          itemBuilder: (context, index) {
                            var detail = value.dataMovieDetail?.genres?[index];
                            return Text(
                              '${detail?.name ?? ' '} | ',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        value.dataMovieDetail?.overview ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  PreferredSize _emptyAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(0.0),
      child: AppBar(
        backgroundColor: mainColor,
        brightness: Brightness.dark,
      ),
    );
  }
}
