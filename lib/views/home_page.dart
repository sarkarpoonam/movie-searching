import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviedata/views/movie_details.dart';

import '../controllers/home_controller.dart';
import '../core/my_pref.dart';
import '../model/movie.dart';
import '../theme/theme_colors.dart';
import '../widgets/image_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.put(HomeController());
  final myPref = Get.find<MyPref>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.secondaryMediumGrey,
      appBar: AppBar(
        backgroundColor: ThemeColor.white,
        title: const Text('Movie Collection',
            style: TextStyle(
                color: ThemeColor.primaryBlack, fontFamily: 'Poppins')),
        elevation: 0,
        /*actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, color: ThemeColor.primaryBlack))
          ],*/
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
            child: TextFormField(
              onFieldSubmitted: (value){
                  homeController.fetchAllMovies(value);
              },
              onChanged: (v){
                homeController.movieList.clear();
              },
              autofocus: false,
              cursorColor: context.theme.primaryColorDark,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Search movies',
                hintStyle: const TextStyle(color: ThemeColor.secondaryDarkGrey),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: context.theme.primaryColorDark,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: context.theme.primaryColorDark,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                prefixIcon: Icon(
                  color: context.theme.primaryColorDark,
                  Icons.search,
                  size: 20,
                ),
              ),
              style: const TextStyle(color: ThemeColor.white),
              textAlign: TextAlign.start,

            ),
          ),

          Flexible(
            child: Obx(
              // ignore: prefer_is_not_empty
              () => !(homeController.movieList.isEmpty)
                  ? ListView.separated(
                      itemCount: homeController.movieList.length,
                      itemBuilder: (context, index) {
                        return itemDetailsWidget(context, index);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 5,
                        );
                      },
                    )
                  : const SizedBox(height: 0),
            ),
          ),
        ],
      ),
    );
  }

  Container itemDetailsWidget(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      //width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 7,
            color: Color(0x32171717),
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 60,
          height: 60,
          child: homeController.movieList[index].poster.toString() != "null"
              ? ImageView(
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  url: homeController.movieList[index].poster,
                )
              : Center(
                  child: Text(
                    homeController.movieList[index].title.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              homeController.movieList[index].title.toString(),
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              homeController.movieList[index].year.toString(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            ),
          ],
        ),
        subtitle: Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    homeController.movieList[index].type.toString(),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ],
          ),
        ),
        isThreeLine: false,
        style: ListTileStyle.list,
        onTap: () {
          print("tapped");
          myPref.selectedImdbID.val = homeController.movieList[index].imdbID!;
          print(myPref.selectedImdbID.val);
          Get.offAll(() => MovieDetailsPage(
              movieData: homeController.movieList[index])
          );
        },
      ),
    );
  }
}
