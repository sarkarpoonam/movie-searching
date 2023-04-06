import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/my_pref.dart';
import '../helper/api_helper.dart';
import '../model/movie.dart';


class MovieDetailController extends GetxController with StateMixin{

  static const String kApiKey = 'c62197fa';
  static const String _apiUrl = 'http://www.omdbapi.com/?apikey=$kApiKey';
  RxList<Movie> movieDetailsList = <Movie>[].obs;
  String? selectedImdbId;
  Movie? moviedetail;

  @override
  onInit() async {
    super.onInit();
    final myPref = Get.find<MyPref>();
    selectedImdbId = myPref.selectedImdbID.val;
    change(null, status: RxStatus.loading());
    fetchMovieDetails();
    change(null, status: RxStatus.success());
  }

  Future<Movie?> fetchMovieDetails() async{
    String finalURL = _apiUrl;
    finalURL = '$_apiUrl&i=$selectedImdbId';

    ApiHelper apikHelper = ApiHelper(finalURL);
    var data = await apikHelper.apiCall();
    bool resultsFound = data['Response'] == 'True';
    if (resultsFound) {
     // movieDetailsList.add (
      moviedetail = Movie(
          title: data['Title'] ?? 'N/A',
          year: data['Year'] ?? 'N/A',
          rated: data['Rated'] ?? 'N/A',
          released: data['Released'] ?? '',
          runTime: data['Runtime'] ?? 'N/A',
          genre: data['Genre'] ?? 'N/A',
          director: data['Director'] ?? 'N/A',
          writer: data['Writer'] ?? 'N/A',
          actors: data['Actors'] ?? 'N/A',
          plot: data['Plot'] ?? 'N/A',
          language: data['Language'] ?? 'N/A',
          country: data['Country'] ?? 'N/A',
          awards: data['Awards'] ?? 'N/A',
          //ratings: data['Ratings'] ?? 'N/A',
          metaScore: data['Metascore'] ?? 'N/A',
          imdbRating: data['imdbRating'] ?? 'N/A',
          imdbVotes: data['imdbVotes'] ?? 'N/A',
          imdbID: data['imdbID'] ?? 'N/A',
          type: data['Type'] ?? 'N/A',
          dvd: data['DVD'] ?? 'N/A',
          boxOffice: data['BoxOffice'] ?? 'N/A',
          production: data['Production'] ?? 'N/A',
          website: data['Website'] ?? 'N/A',
          response: data['Response'],
          poster: data['Poster'] == 'N/A'
              ? 'https://images.unsplash.com/photo-1485846234645-a62644f84728?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'
              : data['Poster']);
      print(moviedetail?.imdbRating);
      update();
      //) ;
    } //else
     // throw NetworkError();
    return moviedetail;
  }

}