import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final ChatUser currentUser = ChatUser(
    id: "0",
    firstName: "Ridho",
    profileImage: "assets/dummy_profile.png",
  );
  List<ChatMessage> chatMessage = [];

  @override
  Widget build(BuildContext context) {
    Future getUserChat(ChatMessage message) async {
      print(message.text);
      setState(() {
        chatMessage.insert(0, message);
      });
    }

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("DiagnoCare Bot", style: AppFonts().titleFont),
        centerTitle: true,
      ),
      body: DashChat(
        currentUser: currentUser,
        onSend: (ChatMessage chatMessage) {
          getUserChat(chatMessage);
        },
        messages: chatMessage,
        messageOptions: MessageOptions(
          borderRadius: 10,
          currentUserContainerColor: AppColors.primaryColor,
          currentUserTimeTextColor: Colors.white,
          currentUserTextColor: Colors.white,
          maxWidth: MediaQuery.of(context).size.width / 1.5,
          messagePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          marginSameAuthor: EdgeInsets.only(top: 5),
          showTime: true,
        ),
        inputOptions: InputOptions(
          alwaysShowSend: true,
          inputTextStyle: AppFonts().normalBlackFont,
          textCapitalization: TextCapitalization.sentences,
          cursorStyle: CursorStyle(color: AppColors.primaryColor),
          // inputDecoration: InputDecoration(),
        ),
      ),
    );
  }
}
