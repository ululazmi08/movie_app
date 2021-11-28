import 'package:flutter/material.dart';
import 'package:movie_app/model/model_movie_similar.dart';
import 'package:movie_app/utils/constant.dart';

class HomeDetailSimilarPage extends StatefulWidget {
  List<DataMovieSimilar>? listMovieSimilar;
  HomeDetailSimilarPage(this.listMovieSimilar);

  @override
  _HomeDetailSimilarPageState createState() => _HomeDetailSimilarPageState();
}

class _HomeDetailSimilarPageState extends State<HomeDetailSimilarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: _emptyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Related Movies',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.listMovieSimilar!.length,
                itemBuilder: (context, index) {
                  DataMovieSimilar? datasimilar =
                      widget.listMovieSimilar![index];
                  return Container(
                    height: 295,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              '${imageUrl}${datasimilar.posterPath}',
                              fit: BoxFit.cover,
                              height: 273,
                              width: 182,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                datasimilar.title ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                    datasimilar.voteAverage!.toStringAsFixed(1),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                datasimilar.overview ?? '',
                                maxLines: 11,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  color: mainGrey,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                })
          ],
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
