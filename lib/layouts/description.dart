import 'package:flutter/material.dart';
import 'package:movie_app/utils/text.dart';

class Description extends StatelessWidget {
  final String name, description,bannerUrl, posterUrl, vote, launch_on;

  const Description({Key? key, required this.name, required this.description, required this.bannerUrl, required this.posterUrl, required this.vote, required this.launch_on}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                    child: Image.network(bannerUrl,fit: BoxFit.cover,),
                  ),),
                  Positioned(
                    bottom: 10.0,
                    child:modified_text(text: ' ⭐ Average Rating - ' + vote,)
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: modified_text(text: name != null ? name : 'Not Loaded', size: 24.0,),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: modified_text(text: 'Releasing On - ' + launch_on, size: 14.0,),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children:[
                Container(
                  height: 200,
                  width: 100,
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Image.network(posterUrl),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: modified_text(text: description, size: 16.0,),
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
