class Course {
  int? id;
  String? name, imgUrl;
  double? progress;
  Course({id, name, progress, imgUrl}) {
    this.id = id;
    this.name = name;
    this.progress = progress;
    try {
      this.imgUrl =
          imgUrl[0]["fileurl"] + "?token=8c61d498de82991806a358b26e559c9d";
    } catch (e) {
      this.imgUrl =
          "https://cosmonaut-storage.s3-us-west-1.amazonaws.com/placeholder-cover.png";
    }
  }

  Course fromJson(json) {
    return Course(
      id: json["id"],
      name: json["fullname"],
      progress: json["progress"],
      imgUrl: json["overviewfiles"],
    );
  }
}
