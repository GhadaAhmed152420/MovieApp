import 'package:flutter/material.dart';
import 'package:movie_app/layouts/description.dart';
import 'package:movie_app/utils/text.dart';

class TopRatedMovies extends StatelessWidget {
  const TopRatedMovies({Key? key, required this.topRated}) : super(key: key);
  final List topRated;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const modified_text(
            text: 'Top Rated Movies',
            size: 26.0,
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 270,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topRated.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Description(
                                  name: topRated[index]['title'],
                                  description: topRated[index]['overview'],
                                  bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                                      topRated[index]['backdrop_path'],
                                  posterUrl: 'https://image.tmdb.org/t/p/w500' +
                                      topRated[index]['poster_path'],
                                  vote: topRated[index]['vote_average']
                                      .toString(),
                                  launch_on: topRated[index]['release_date'])));
                    },
                    child: topRated[index]['title'] != null
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
                                              topRated[index]['poster_path']),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  child: modified_text(
                                    text: topRated[index]['title'] ??
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
