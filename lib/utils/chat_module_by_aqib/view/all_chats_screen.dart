import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import '../../../widgets/progress_bar.dart';
import '../../colors.dart';

import '../../size_config.dart';
import '../../text_styles.dart';
import '../controller/chat_controller.dart';
import '../data/firebase_functions.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
ChatController  chatController=Get.find();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: const Text("Group Chat List"),
          centerTitle: true,
          // flexibleSpace: Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       stops: const [0.1, 1.0],
          //       colors: [primaryColor.withOpacity(0.6), blue],
          //       begin: Alignment.centerRight,
          //       end: Alignment.centerLeft,
          //     ),
          //   ),
          // )
      ),


      body: FutureBuilder<List<DocumentSnapshot>>(
        future: fetchChats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ProgressBar();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.isEmpty) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<DocumentSnapshot> chats = snapshot.data!;
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> chatData = chats[index].data() as Map<String, dynamic>;

                return ListTile(
                  title: Text(chatData['receiverName']),
                  subtitle: Text(chatData['message']),
                  onTap: () {
                    navigateToChatScreen(chatData);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  void navigateToChatScreen(Map<String, dynamic> chatData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          chatRoomId: chatData['chatRoomId'],
          senderUid: chatData['senderUid'],
          receiverUid: chatData['receiverUid'],
          senderName: chatData['senderName'],
          receiverName: chatData['receiverName'],
          receiverDeviceToken: chatData['receiverDeviceToken'],
        ),
      ),
    );
  }
}


