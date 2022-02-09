import 'package:flutter/material.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:movie_app/utils/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Description extends StatefulWidget {
  final String name, description, bannerUrl, posterUrl, vote, launch_on;
  const Description(
      {Key? key,
      required this.name,
      required this.description,
      required this.bannerUrl,
      required this.posterUrl,
      required this.vote,
      required this.launch_on})
      : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  bool isFavourite = false;
  SharedPreferences? sharedPreferences;

  void saveFavourites(bool favourites) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences?.setBool('isFavourite', favourites);
  }

  void getFavourites() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      isFavourite = sharedPreferences?.getBool('isFavourite') ?? false;
    });
  }

  @override
  void initState() {
    createDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < movies.length; i++) {
      if (widget.name == movies[i]["title"]) {
        getFavourites();
      }
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: CircleAvatar(
              radius: 15.0,
              child: isFavourite
                  ? const Icon(Icons.favorite, color: Colors.red)
                  : const Icon(Icons.favorite_border, color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                isFavourite = !isFavourite;
              });
              saveFavourites(isFavourite);
              insertIntoDB(
                poster: widget.posterUrl,
                title: widget.name,
              ).then((value) {
                getDataFromDB(db).then((value) {
                  setState(() {
                    movies = value;
                  });
                });
              });
            },
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 250.0,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        widget.bannerUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 10.0,
                      child: modified_text(
                        text: ' ⭐ Average Rating - ' + widget.vote,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: modified_text(
                text: widget.name != null ? widget.name : 'Not Loaded',
                size: 24.0,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: modified_text(
                text: 'Releasing On - ' + widget.launch_on,
                size: 14.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  height: 200,
                  width: 100,
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Image.network(widget.posterUrl),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: modified_text(
                      text: widget.description,
                      size: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
