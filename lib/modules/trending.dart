import 'package:flutter/material.dart';
import 'package:movie_app/layouts/description.dart';
import 'package:movie_app/utils/text.dart';

class TrendingMovies extends StatelessWidget {
  const TrendingMovies({Key? key, required this.trending}) : super(key: key);
  final List trending;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const modified_text(
            text: 'Trending Movies',
            size: 26.0,
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 270,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: trending.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Description(
                                  name: trending[index]['title'],
                                  description: trending[index]['overview'],
                                  bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                                      trending[index]['backdrop_path'],
                                  posterUrl: 'https://image.tmdb.org/t/p/w500' +
                                      trending[index]['poster_path'],
                                  vote: trending[index]['vote_average']
                                      .toString(),
                                  launch_on: trending[index]['release_date'])));
                    },
                    child: trending[index]['title'] != null
                        ? Container(
                            width: 140.0,
                            child: Column(
                              children: [
                                Container(
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w500' +
                                              trending[index]['poster_path']),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  child: modified_text(
                                    text: trending[index]['title'] ??
                                        'Loading...',
                                    size: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
