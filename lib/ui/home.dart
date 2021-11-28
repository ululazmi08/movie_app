import 'package:flutter/material.dart';
import 'package:movie_app/model/model_movie_popular.dart';
import 'package:movie_app/model/model_movie_upcoming.dart';
import 'package:movie_app/provider/provider_movie.dart';
import 'package:movie_app/ui/home_detail.dart';
import 'package:movie_app/ui/home_search.dart';
import 'package:movie_app/utils/constant.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProviderMovie(),
      child: Consumer<ProviderMovie>(
        builder: (BuildContext context, pvd, Widget? child) => Scaffold(
          key: pvd.scaffoldKey,
          backgroundColor: mainColor,
          appBar: _emptyAppBar(),
          body: pvd.loading
              ? Container(
                  child: Center(child: CircularProgressIndicator()),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Movie App',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'All of Movies are here',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    color: mainGrey,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                ),
                                color: lightGrey,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => HomeSearchPage()));
                                },
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 400,
                        child: pvd.loading
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                // physics: NeverScrollableScrollPhysics(),
                                itemCount: pvd.listMoviePopular!.length,
                                itemBuilder: (context, index) {
                                  DataMoviePopular? popular =
                                      pvd.listMoviePopular![index];
                                  return Container(
                                    // color: Colors.grey,
                                    width: 254,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            HomeDetailPage(
                                                                popular)));
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.network(
                                                  '${imageUrl}${popular.posterPath}',
                                                  height: 328,
                                                  width: 222,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 10,
                                              right: 10,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 8,
                                                    top: 6,
                                                    right: 16,
                                                    bottom: 6),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.grey
                                                      .withOpacity(0.6),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'IMBd',
                                                      style: TextStyle(
                                                        fontSize: 8,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                          size: 20,
                                                        ),
                                                        Text(
                                                          '${popular.voteAverage ?? ''}',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 10,
                                              right: 10,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 8,
                                                    top: 6,
                                                    right: 16,
                                                    bottom: 6),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'IMBd',
                                                      style: TextStyle(
                                                        fontSize: 8,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                          size: 20,
                                                        ),
                                                        Text(
                                                          '${popular.voteAverage ?? ''}',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          '${popular.originalTitle}',
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Upcoming',
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      pvd.loadingUpc
                          ? Center(child: CircularProgressIndicator())
                          : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 15,
                                childAspectRatio: 182 / 273,
                                crossAxisCount: 3,
                                children: pvd.listMovieUpcoming!.map(
                                  (DataMovieUpcoming? upcoming) {
                                    return InkWell(
                                      onTap: () {
                                        // Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeDetailUpcomingPage(upcoming)));
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          '${imageUrl}${upcoming?.posterPath}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                          ),
                    ],
                  ),
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
