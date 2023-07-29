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
      body: ListView(
        children: [
          ItemReceivesMessage(),
          ItemSendMessage(),
        ],
      ),
    );
  }
}
