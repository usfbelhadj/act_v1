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
    print(json['image']);
    return Actuary(
      image: json["image"],
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















// import 'package:http/http.dart' as http;

// import '../main.dart';

// var url = "$SERVER_IP/user";

// class Actuary {
//   final String? image,
//       username,
//       publicId,
//       firstName,
//       lastName,
//       email,
//       phone,
//       moodleID;
//   final int? score;
//   final lastactive;

//   Actuary({
//     this.image,
//     this.username,
//     this.score,
//     this.lastactive,
//     this.publicId,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.phone,
//     this.moodleID,
//   });

//   Actuary fromJson(json) {
//     return Actuary(
//       image: "assets/icons/xd_file.svg",
//       username: json["username"],
//       firstName: json["first_name"],
//       lastName: json["last_name"],
//       email: json["email"],
//       lastactive: json["last_active"],
//       score: json["score"],
//       phone: json["phone"] == null ? "" : json["phone"],
//       moodleID: json["id"],
//     );
//   }

//   Future<int> deleteUser(token) async {
//     var responce = await http.delete(
//       Uri.parse("$url/${this.moodleID}"),
//       headers: {
//         "x-access-token": token,
//         'content-type': 'application/json',
//       },
//     );
//     print(responce.body);
//     if (responce.statusCode != 200) {
//       return -1;
//     }
//     return 1;
//   }
// }
