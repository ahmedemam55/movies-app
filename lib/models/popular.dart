class Popular {
  String background;
  String poster;
  String title;
  String date;
  String description;
  double rate;
  List id;

  Popular({
    required this.background,
    required this.poster,
    required this.title,
    required this.date,
    required this.description,
    required this.rate,
    required this.id,
  });

  factory Popular.fromJson(Map<String, dynamic> json) {
    return Popular(
        background: json["backdrop_path"] ?? "",
        poster: json["poster_path"] ?? "",
        title: json["title"] ?? "",
        date: json["release_date"] ?? "",
        rate: (json["vote_average"] as num?)?.toDouble() ?? 0.0,
        description: json["overview"] ?? "",
        id: json["genre_ids"] ?? []
    );
  }
}
