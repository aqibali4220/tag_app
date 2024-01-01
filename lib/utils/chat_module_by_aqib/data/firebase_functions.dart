
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


CollectionReference posts = FirebaseFirestore.instance.collection('posts');
CollectionReference users = FirebaseFirestore.instance.collection('users');

CollectionReference chatroom =
FirebaseFirestore.instance.collection('chat_room');



Future<List<Map<String, dynamic>>> getUserDataByEmail({String? email}) async {
  final querySnapshot = await users.where('email', isEqualTo: email).get();
  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  } else {
    return [];
  }


}
Future<List<DocumentSnapshot>> fetchChats() async {
  QuerySnapshot querySnapshot = await chatroom.get();
  return querySnapshot.docs;
}



