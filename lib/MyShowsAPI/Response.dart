import 'dart:convert';

import 'package:flutter_app/Database/SerialModel.dart';

ApiResponse apiResponseFromJson(String str) => ApiResponse.fromMap(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toMap());

class ApiResponse {
  String jsonrpc;
  List<Result> result;
  String id;

  ApiResponse({
    this.jsonrpc,
    this.result,
    this.id,
  });

  factory ApiResponse.fromMap(Map<String, dynamic> json) => new ApiResponse(
    jsonrpc: json["jsonrpc"],
    result: new List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "jsonrpc": jsonrpc,
    "result": new List<dynamic>.from(result.map((x) => x.toMap())),
    "id": id,
  };
}

class Result {
  int id;
  String title;
  String titleOriginal;
  String description;
  int totalSeasons;
  String status;
  String country;
  String started;
  String ended;
  int year;
  int kinopoiskId;
  int tvrageId;
  int imdbId;
  int watching;
  int voted;
  double rating;
  int runtime;
  String image;
  List<int> genreIds;
  Network network;
  dynamic episodes;

  Result({
    this.id,
    this.title,
    this.titleOriginal,
    this.description,
    this.totalSeasons,
    this.status,
    this.country,
    this.started,
    this.ended,
    this.year,
    this.kinopoiskId,
    this.tvrageId,
    this.imdbId,
    this.watching,
    this.voted,
    this.rating,
    this.runtime,
    this.image,
    this.genreIds,
    this.network,
    this.episodes,
  });

  factory Result.fromMap(Map<String, dynamic> json) => new Result(
    id: json["id"],
    title: json["title"],
    titleOriginal: json["titleOriginal"],
    description: json["description"],
    totalSeasons: json["totalSeasons"],
    status: json["status"],
    country: json["country"],
    started: json["started"],
    ended: json["ended"],
    year: json["year"],
    kinopoiskId: json["kinopoiskId"],
    tvrageId: json["tvrageId"],
    imdbId: json["imdbId"],
    watching: json["watching"],
    voted: json["voted"],
    rating: json["rating"].toDouble(),
    runtime: json["runtime"],
    image: json["image"],
    genreIds: new List<int>.from(json["genreIds"].map((x) => x)),
    network: Network.fromMap(json["network"]),
    episodes: json["episodes"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "titleOriginal": titleOriginal,
    "description": description,
    "totalSeasons": totalSeasons,
    "status": status,
    "country": country,
    "started": started,
    "ended": ended,
    "year": year,
    "kinopoiskId": kinopoiskId,
    "tvrageId": tvrageId,
    "imdbId": imdbId,
    "watching": watching,
    "voted": voted,
    "rating": rating,
    "runtime": runtime,
    "image": image,
    "genreIds": new List<dynamic>.from(genreIds.map((x) => x)),
    "network": network.toMap(),
    "episodes": episodes,
  };

  Serial toSerial() {
    return Serial(
      title: title,
      desc: description,
      poster: image,
      season: 1,
      episode: 1,
      fav: false
    );
  }
}

class Network {
  int id;
  String title;
  String country;

  Network({
    this.id,
    this.title,
    this.country,
  });

  factory Network.fromMap(Map<String, dynamic> json) => new Network(
    id: json["id"],
    title: json["title"],
    country: json["country"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "country": country,
  };
}
