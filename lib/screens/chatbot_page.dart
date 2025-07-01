import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/models/chatbot_model.dart';
import 'package:skripsi_clinicz_app/services/ai_services.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController userMessageController = TextEditingController();
  final ScrollController scrollPageController = ScrollController();
  final List<ChatMessage> listOfMessages = [];
  bool sendLoading = false;

  void sendMessage() async {
    final userInput = userMessageController.text.trim();
    if (userInput.isEmpty) return;

    // Tutup keyboard
    FocusScope.of(context).unfocus();

    setState(() {
      listOfMessages.add(ChatMessage(message: userInput, isUser: true));
      sendLoading = true;
      userMessageController.clear();
      listOfMessages.add(
        ChatMessage(message: "", isUser: false),
      ); // Placeholder
    });

    // Scroll ke bawah setelah user mengirim
    scrollToBottom();

    final reply = await AIServices().chatBotGemini(userInput);

    setState(() {
      listOfMessages[listOfMessages.length - 1] = ChatMessage(
        message: reply,
        isUser: false,
      );
      sendLoading = false;
    });

    // Scroll ke bawah setelah balasan bot masuk
    scrollToBottom();
  }

  void scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (scrollPageController.hasClients) {
        scrollPageController.animateTo(
          scrollPageController.position.maxScrollExtent,
          duration: Duration(seconds: 1),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget buildMessage(ChatMessage userMessage) {
    if (!userMessage.isUser &&
        userMessage.message.trim().isEmpty &&
        sendLoading) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: MediaQuery.of(context).size.width / 10,
          width: MediaQuery.of(context).size.width / 6,
          decoration: BoxDecoration(
            color: AppColors.thirdColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: LottieBuilder.asset("assets/lottie_chatbot_loading.json"),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment:
            userMessage.isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color:
                userMessage.isUser
                    ? AppColors.primaryColor
                    : AppColors.thirdColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              userMessage.message,
              style:
                  userMessage.isUser
                      ? AppFonts().normalWhiteFont
                      : AppFonts().normalBlackFont,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text("DiagnoCare Bot", style: AppFonts().titleFont),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                controller: scrollPageController,
                itemCount: listOfMessages.length,
                itemBuilder:
                    (context, index) => buildMessage(listOfMessages[index]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: userMessageController,
                      cursorColor: AppColors.thirdColor,
                      textCapitalization: TextCapitalization.sentences,
                      style: AppFonts().normalWhiteFont,
                      decoration: InputDecoration(
                        hintText: "Ketik pesan...",
                        hintStyle: AppFonts().normalWhiteFont,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    color: AppColors.bgColor,
                    icon: Icon(Icons.send),
                    onPressed: sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
