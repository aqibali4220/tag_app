import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatController extends GetxController {
  var containerHeight = 45.0.obs;
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  CollectionReference chatroom =
      FirebaseFirestore.instance.collection('chat_room');

  onSendMessage(
      {String? chatRoomId,
      String? senderUid,
      String? receiverUid,
      Map<String, dynamic>? senderMap,
      Map<String, dynamic>? receiverMap}) async {
    messageController.clear();

    await chatroom.doc(chatRoomId).collection("new_chat").add(senderMap!);
  }

}
