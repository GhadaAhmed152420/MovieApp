import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:movie_app/utils/text.dart';

class FavouriteMovies extends StatefulWidget {
  @override
  State<FavouriteMovies> createState() => _FavouriteMoviesState();
}

class _FavouriteMoviesState extends State<FavouriteMovies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const modified_text(
            text: 'Favourite Movies',
          ),
        ),
        body: movies.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu,
                size: 80.0,
                color: Colors.grey,
              ),
              Text(
                'No tasks yet, Please add some tasks',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        )
            : ListView.separated(
                itemBuilder: (context, index) =>
                    favouriteMovie(movies[index], context),
                separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 20.0,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                itemCount: movies.length));
  }

  Widget favouriteMovie(Map model, BuildContext context) => Dismissible(
    key: Key(model['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              height: 100.0,
              width: 100.0,
              child: Image.network(
                '${model['poster']}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          modified_text(
            text: '${model['title']}',
          ),
        ],
      ),
    ),
    onDismissed: (direction) {
      deleteFromDB(id: model['id']).then((value) {
        getDataFromDB(db).then((value) {
          setState(() {
            movies = value;
          });
        });
      });

    },
  );
}
