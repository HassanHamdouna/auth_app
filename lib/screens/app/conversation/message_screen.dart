import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/serach_app.dart';
import '../../../widgets/user_message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late TextEditingController _searchTextController;

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Message',
            style: GoogleFonts.notoKufiArabic(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            )),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff0D5DA6),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        children: [
          SearchApp(
              controller: _searchTextController,
              hintText: 'Search for messages',
              onPressed: () {}),
          InkWell(
              onTap: () => Navigator.pushNamed(context, '/chat_screen'),
              child: const UserMessage()),
        ],
      ),
    );
  }
}
