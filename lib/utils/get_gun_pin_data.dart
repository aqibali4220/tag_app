import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GunPin {
  String whereAreYou;
  String describeThePerson;
  String describeTheSituation;
  String doYouFeelSafe;
  String shooterPic;
  double currentLat;
  double currentLng;
  String dvToken;

  GunPin({
    this.whereAreYou = "",
    this.describeThePerson = "",
    this.describeTheSituation = "",
    this.doYouFeelSafe = "",
    this.shooterPic = "",
    this.currentLat = 0.0,
    this.currentLng = 0.0,
    this.dvToken = "",
  });

  factory GunPin.fromMap(Map<String, dynamic> map) {
    return GunPin(
      whereAreYou: map['where are you'] ?? "",
      describeThePerson: map['describe the person'] ?? "",
      describeTheSituation: map['describe the situation'] ?? "",
      doYouFeelSafe: map['do you feel safe'] ?? "",
      shooterPic: map['shooter_pic'] ?? "",
      currentLat: map['current_lat'] ?? 0.0,
      currentLng: map['current_lng'] ?? 0.0,
      dvToken: map['dv_token'] ?? "",
    );
  }
}

CollectionReference tagpins = FirebaseFirestore.instance.collection('tag_pins');


Future<List<Map<String, dynamic>>?> getPins() async {
  final querySnapshot = await tagpins.get();
  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  } else {
    return []; // No posts found for the user
  }
}
