import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/api_helper.dart';
import '../model/movie.dart';

class HomeController extends GetxController {

  static const String kApiKey = 'c62197fa';
  static const String _apiUrl = 'http://www.omdbapi.com/?apikey=$kApiKey';
  RxList<Movie> movieList = <Movie>[].obs;


  @override
  onInit() async {
    super.onInit();
    fetchAllMovies('Forensic');
  }

  void fetchAllMovies(String? title) async {
    print("fetch");
    //_apiUrl = '$_apiUrl&s=Batman';
    String finalURL = _apiUrl;
    finalURL = '$_apiUrl&s=$title';

    ApiHelper apikHelper = ApiHelper(finalURL);
    var data = await apikHelper.apiCall();
    bool resultsFound = data['Response'] == 'True';
    int totalResults = int.tryParse(data['totalResults']) ?? (resultsFound ? 1 : 0);

    if (resultsFound && totalResults >= 1) {
      List moviesList = data['Search'];
      for (var m in moviesList) {
        movieList.add(Movie(
            title: m['Title'],
            year: m['Year'],
            imdbID: m['imdbID'],
            type: m['Type'],
            poster: m['Poster'] == 'N/A'
                ? 'https://images.unsplash.com/photo-1485846234645-a62644f84728?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'
                : m['Poster']));
      }
     // return movieList;
    } else{

      throw NetworkError();
    }

  }

}

class NetworkError extends Error{}

