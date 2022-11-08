class Actuary {
  final String? image, username, firstName, lastName, email, phone, publicID;
  final int? score, moodleID;
  final lastactive;

  Actuary({
    this.image,
    this.username,
    this.score,
    this.lastactive,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.moodleID,
    this.publicID,
  });

  Actuary fromJson(json) {
    return Actuary(
      image: "assets/icons/xd_file.svg",
      username: json["username"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      lastactive: json["last_active"],
      score: json["score"],
      phone: json["phone"] ?? "",
      moodleID: json["moodle_id"],
      publicID: json["public_id"],
    );
  }
}
