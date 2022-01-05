import 'package:flutter/material.dart';
import 'package:movie_app/modules/trending.dart';
import 'package:movie_app/utils/text.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../modules/topRated.dart';
import '../modules/tv.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends  State<Home> {
  List trendingMovies = [];
  List topRatedMovies = [];
  List tv = [];

  final String apiKey = '92e141935f19f242814846a97cc1ffee';
  final readAccessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MmUxNDE5MzVmMTlmMjQyODE0ODQ2YTk3Y2MxZmZlZSIsInN1YiI6IjYxZDA4ZTQzMDI4NDIwMDA0MTE0ZGJlNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.K5fEnf85v0BAVwIuEYpMrUQJKC2NVyTT0r77aBmw7vc';


  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  loadMovies()async{
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),
    logConfig: ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ));
    Map trendingResult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topRatedResult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvResult = await tmdbWithCustomLogs.v3.tv.getPouplar();

    setState(() {
      trendingMovies = trendingResult['results'];
      topRatedMovies = topRatedResult['results'];
      tv = tvResult['results'];
    });
    print(tv);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const modified_text(text: 'Movie App ❤️',),
      ),
      body: ListView(
        children: [
          TV(tv: tv,),
          TrendingMovies(trending: trendingMovies,),
          TopRatedMovies(topRated: topRatedMovies,),
        ],
      ),
    );
  }
}