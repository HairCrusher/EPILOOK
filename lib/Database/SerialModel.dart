import 'dart:convert';

Serial serialFromJson(String str) => Serial.fromMap(json.decode(str));

String serialToJson(Serial data) => json.encode(data.toMap());

class Serial {
  int id;
  String title;
  String desc;
  String poster;
  int season;
  int episode;
  bool fav;

  Serial({
    this.id,
    this.title,
    this.desc,
    this.poster,
    this.season,
    this.episode,
    this.fav,
  });

  factory Serial.fromMap(Map<String, dynamic> json) => new Serial(
    id: json["id"],
    title: json["title"],
    desc: json["desc"],
    poster: json["poster"],
    season: json["season"],
    episode: json["episode"],
    fav: json["fav"] == 1,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "desc": desc,
    "poster": poster,
    "season": season,
    "episode": episode,
    "fav": fav,
  };

}
