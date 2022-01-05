import 'package:flutter/material.dart';
import 'package:movie_app/layouts/description.dart';
import 'package:movie_app/utils/text.dart';

class TV extends StatelessWidget{
  const TV({Key? key, required this.tv}) : super(key: key);
  final List tv;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const modified_text(
            text: 'Popular TV Shows',
            size: 26.0,
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 260,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tv.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Description(
                          name: tv[index]['original_name'],
                          description: tv[index]['overview'],
                          bannerUrl: 'https://image.tmdb.org/t/p/w500' + tv[index]['backdrop_path'],
                          posterUrl: 'https://image.tmdb.org/t/p/w500' + tv[index]['poster_path'],
                          vote: tv[index]['vote_average'].toString(),
                          launch_on: tv[index]['first_air_date']
                      )));
                    },
                    child: tv[index]['original_name'] != null ? Container(
                      padding: EdgeInsets.all(5.0),
                      width: 300.0,
                      child: Column(
                        children: [
                          Container(
                            width:300.0,
                            height: 200.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500' + tv[index]['backdrop_path']
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Container(
                            child: modified_text(text: tv[index]['original_name'] ?? 'Loading...', size: 14.0,),
                          ),
                        ],
                      ),
                    ):Container(),
                  );
                }),
          ),
        ],
      ),
    );
  }

}