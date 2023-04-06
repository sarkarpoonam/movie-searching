import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/moviedetails_controller.dart';
import '../model/movie.dart';
import '../theme/theme_colors.dart';
import '../widgets/detail_widget.dart';
import '../widgets/image_view.dart';
import 'home_page.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movieData;
  const MovieDetailsPage({ Key? key,  required this.movieData}) : super(key: key);
  @override
  State<MovieDetailsPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailsPage> {
  final MovieDetailController movieDetailPageController = Get.put(MovieDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.splashColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.offAll(() => const HomePage()),
        ),
      ),
      body: movieDetailPageController.obx(
      (state)=> Container(
        color: ThemeColor.primaryGrey,
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                boxShadow: const [
          BoxShadow(
          blurRadius: 7,
          color: ThemeColor.secondaryDarkGrey,
          offset: Offset(0, 3),
        ),
          ],
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  colorFilter:
                  ColorFilter.mode(Colors.grey.shade300, BlendMode.screen),
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.movieData.poster.toString()),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.8,
                  ),
                  Positioned.fill(
                    bottom: 40,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.movieData.poster.toString()),
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        height: MediaQuery.of(context).size.height / 2.7,
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: 10,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          widget.movieData.title.toString(),
                          textAlign: TextAlign.center,
                          style:
                          const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 2.0,
                ),
                child: Text(
                  movieDetailPageController.moviedetail?.imdbRating != null?
                  (movieDetailPageController.moviedetail?.imdbRating).toString(): "",
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: ThemeColor.secondaryDarkGrey),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MovieDetailWidget(
                  detail: 'Length',
                  value: movieDetailPageController.moviedetail?.runTime != null?
                  (movieDetailPageController.moviedetail?.runTime).toString(): "",
                ),
                MovieDetailWidget(
                  detail: 'Language',
                  value:  movieDetailPageController.moviedetail?.language != null?
                    (movieDetailPageController.moviedetail?.language).toString().split(',')[0]: "",
                ),
                MovieDetailWidget(
                  detail: 'Year',
                  value: movieDetailPageController.moviedetail?.year != null?
                  (movieDetailPageController.moviedetail?.year).toString() : "",
                ),
                MovieDetailWidget(
                  detail: 'Country',
                  value: movieDetailPageController.moviedetail?.country != null?
                  (movieDetailPageController.moviedetail?.country).toString().split(',')[0] : "",
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 15),
              child: Text(
                'Storyline',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
              child: Text( movieDetailPageController.moviedetail?.plot != null?
              (movieDetailPageController.moviedetail?.plot).toString():""),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 15),
              child: Text(
                'Genre',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
              child: Text(movieDetailPageController.moviedetail?.genre != null?
              (movieDetailPageController.moviedetail?.genre).toString():""),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
              child: Text(
                'Ratings',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('IMDB : '),
                  Text(movieDetailPageController.moviedetail?.imdbRating == 'N/A'
                      ? 'No Information'
                      : (movieDetailPageController.moviedetail?.imdbRating).toString()),
                  Text(' ( ${movieDetailPageController.moviedetail?.imdbVotes} )'),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 15),
              child: Text(
                'Cast',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
              child: Text(movieDetailPageController.moviedetail?.actors != null?
              (movieDetailPageController.moviedetail?.actors).toString():""),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 15),
              child: Text(
                'Director',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
              child: Text(movieDetailPageController.moviedetail?.director != null?
              (movieDetailPageController.moviedetail?.director).toString():""),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 15),
              child: Text(
                'Writer',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
              child: Text(movieDetailPageController.moviedetail?.writer != null?
              (movieDetailPageController.moviedetail?.writer).toString():""),
            ),

            const SizedBox(
              height: 8,
            )
          ],
        ),
      ),
        onLoading: CircularProgressIndicator(),
      ),
    );
  }


}