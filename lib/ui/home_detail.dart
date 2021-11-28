import 'package:flutter/material.dart';
import 'package:movie_app/model/model_movie_popular.dart';
import 'package:movie_app/model/model_movie_similar.dart';
import 'package:movie_app/provider/provider_movie_detail.dart';
import 'package:movie_app/ui/home_detail_similar.dart';
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
          key: value.scaffoldKey,
          backgroundColor: mainColor,
          appBar: _emptyAppBar(),
          body: value.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 250,
                      // color: Colors.grey,
                      // width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Image.network(
                                  '${imageUrl}${value.dataMovieDetail?.backdropPath ?? ''}',
                                  fit: BoxFit.cover,
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            // left: 0,
                            bottom: 0,
                            // right: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
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
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios_rounded),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 20,
                      padding: EdgeInsets.only(left: 10),
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
                                color: Colors.white,
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        value.dataMovieDetail?.overview ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Related Movies',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HomeDetailSimilarPage(
                                          value.listMovieSimilar)));
                            },
                            child: Text(
                              'SEE MORE',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    value.loadingSimilar
                        ? Center(child: CircularProgressIndicator())
                        : Container(
                            height: 150,
                            // color: Colors.grey,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: value.listMovieSimilar!.length,
                                itemBuilder: (context, index) {
                                  DataMovieSimilar? similar =
                                      value.listMovieSimilar![index];
                                  return Container(
                                    width: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                                '${imageUrl}${similar.backdropPath}'),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            similar.originalTitle ?? "",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
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
