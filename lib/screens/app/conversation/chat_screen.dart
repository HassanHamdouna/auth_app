import 'package:app_auth/widgets/input_chat.dart';
import 'package:app_auth/widgets/item_receives_message.dart';
import 'package:app_auth/widgets/item_send_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _chatTextController;
  @override
  void initState() {
    super.initState();
    _chatTextController = TextEditingController();
  }

  @override
  void dispose() {
    _chatTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: const Color(0xff0D5DA6),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        leadingWidth: 60,
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('images/google_icon.png'),
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Text('Hassan Hamdouna',
                style: GoogleFonts.notoKufiArabic(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ItemReceivesMessage(),
                  ItemSendMessage(),
                ],
              ),
            ),
            InputChat(controller: _chatTextController, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
