import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bxs.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/models/chatbot_model.dart';
import 'package:skripsi_clinicz_app/services/ai_services.dart';

class ChatBotPage extends StatefulWidget {
  final String profileImage;
  const ChatBotPage({super.key, required this.profileImage});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController userMessageController = TextEditingController();
  final ScrollController scrollPageController = ScrollController();
  final List<ChatMessage> listOfMessages = [];
  bool sendLoading = false;

  // LIST SUGESTI PERTANYAAN
  final List suggestedQuestions = [
    "Kapan harus ke dokter ?",
    "Kapan waktu yang tepat untuk medical check up ?",
    "Bagaimana cara menurunkan berat badan yang baik dan benar ?",
    "Apa yang harus dilakukan jika penyakit tak kunjung berhenti ?",
    "Apa yang menyebabkan badan terasa lemas saat bangun tidur ?",
  ];

  // METHOD UNTUK MENAMPILKAN SUGESTI PERTANYAAN
  Widget buildSuggestions() {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 10,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: suggestedQuestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestedQuestions[index];
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                // height: MediaQuery.of(context).size.width / 4,
                // width: MediaQuery.of(context).size.width / 1.7,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Text(suggestion, style: AppFonts().normalWhiteFont),
              ),
            ),
            onTap: () {
              userMessageController.text = suggestion;
              sendMessage();
            },
          );
        },
      ),
    );
  }

  // METHOD UNTUK MENGATASI PENGIRIMAN PESAN
  void sendMessage() async {
    final userInput = userMessageController.text.trim();
    if (userInput.isEmpty) return;

    // MENUTUP KEYBOARD
    FocusScope.of(context).unfocus();

    setState(() {
      listOfMessages.add(ChatMessage(message: userInput, isUser: true));
      sendLoading = true;
      userMessageController.clear();
      listOfMessages.add(
        ChatMessage(message: "", isUser: false),
      ); // Placeholder
    });

    // MELAKUKAN SCROLLING LANGSUNG KE BAGIAN BAWAH SETELAH KEYBOARD TERTUTUP
    scrollToBottom();

    final reply = await AIServices().chatBotGemini(userInput);

    setState(() {
      listOfMessages[listOfMessages.length - 1] = ChatMessage(
        message: reply,
        isUser: false,
      );
      sendLoading = false;
    });

    // MELAKUKAN SCROLLING LANGSUNG KE BAGIAN BAWAH SETELAH KEYBOARD TERTUTUP
    scrollToBottom();
  }

  // METHOD SCROLL TO BOTTOM
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

  // METHOD MESSAGE
  Widget geminiMessage(ChatMessage userMessage) {
    final isUser = userMessage.isUser;
    final avatar =
        isUser
            ? CircleAvatar(
              backgroundImage: NetworkImage(widget.profileImage),
              radius: 20,
            )
            : CircleAvatar(
              child: Iconify(Bxs.bot, size: 20),
              backgroundColor: Colors.grey[200],
              radius: 20,
            );

    final chatBubble = Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: isUser ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(15),
        child: Text(
          userMessage.message,
          style:
              isUser ? AppFonts().normalWhiteFont : AppFonts().normalBlackFont,
          textAlign: TextAlign.justify,
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.only(
        bottom: 20,
        left: isUser ? 90 : 10,
        right: isUser ? 10 : 90,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children:
            isUser
                ? [chatBubble, const SizedBox(width: 10), avatar]
                : [avatar, const SizedBox(width: 10), chatBubble],
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
            child: ListView.builder(
              controller: scrollPageController,
              itemCount: listOfMessages.length,
              itemBuilder:
                  (context, index) => geminiMessage(listOfMessages[index]),
            ),
          ),
          buildSuggestions(),
          // MESSAGE AREA
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
