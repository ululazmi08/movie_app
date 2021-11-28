import 'package:flutter/material.dart';
import 'package:movie_app/model/model_movie_popular.dart';
import 'package:movie_app/provider/provider_movie.dart';
import 'package:movie_app/ui/home_detail.dart';
import 'package:movie_app/utils/constant.dart';
import 'package:provider/provider.dart';

class HomeSearchPage extends StatefulWidget {
  const HomeSearchPage({Key? key}) : super(key: key);

  @override
  _HomeSearchPageState createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends State<HomeSearchPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProviderMovie(),
      child: Consumer<ProviderMovie>(
        builder: (BuildContext context, value, Widget? child) => Scaffold(
          backgroundColor: mainColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 80,
            backgroundColor: mainColor,
            brightness: Brightness.dark,
            title: TextFormField(
              controller: value.cari,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: mainGrey,
                ),
                fillColor: lightGrey,
                filled: true,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(),
                ),
              ),
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
                color: mainGrey,
              ),
            ),
          ),
          body: value.loading
              ? Center(child: CircularProgressIndicator())
              : value.isCari == false
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: value.listMoviePopular!.length,
                              itemBuilder: (context, index) {
                                DataMoviePopular? popular =
                                    value.listMoviePopular![index];
                                return Container(
                                  height: 295,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeDetailPage(popular)));
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              '${imageUrl}${popular.posterPath}',
                                              fit: BoxFit.cover,
                                              height: 273,
                                              width: 182,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                popular.title ?? '',
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
                                                    popular.voteAverage!
                                                        .toStringAsFixed(1),
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
                                                popular.overview ?? '',
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
                                  ),
                                );
                              }),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, bottom: 10),
                            child: Text(
                              'Search Result (${value.filter.length})',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                color: mainGrey,
                              ),
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: value.filter.length,
                              itemBuilder: (context, index) {
                                DataMoviePopular? datafilter =
                                    value.filter[index];
                                return Container(
                                  height: 295,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeDetailPage(datafilter)));
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              '${imageUrl}${datafilter!.posterPath}',
                                              fit: BoxFit.cover,
                                              height: 273,
                                              width: 182,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                datafilter.title ?? '',
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
                                                    datafilter.voteAverage!
                                                        .toStringAsFixed(1),
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
                                                datafilter.overview ?? '',
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
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
