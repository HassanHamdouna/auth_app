import 'package:app_auth/firebase/fb_auth_controller.dart';
import 'package:app_auth/firebase/fb_store_controller.dart';
import 'package:app_auth/models/messages.dart';
import 'package:app_auth/models/users.dart';
import 'package:app_auth/widgets/app_circular_progress.dart';
import 'package:app_auth/widgets/input_chat.dart';
import 'package:app_auth/widgets/item_receives_message.dart';
import 'package:app_auth/widgets/item_send_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, this.users});
  Users? users;
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
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage('${widget.users!.image}'),
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Text('${widget.users?.name}',
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
              child: StreamBuilder<QuerySnapshot<Messages>>(
                stream: FbStoreController().readMessages(messages),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const AppCircularProgress();
                  } else if (snapshot.data!.docs.isNotEmpty &&
                      snapshot.hasData) {
                    return ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data!.docs.reversed.length,
                      // itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        // return ItemSendMessage(
                        //   contentText:
                        //       snapshot.data!.docs[index].data().content,
                        //   timeMessage: DateTime.parse(
                        //       snapshot.data!.docs[index].data().timestamp),
                        // );
                        return snapshot.data!.docs[index].data().senderId ==
                                FbAuthController().currentUser.uid
                            ? ItemSendMessage(
                                contentText:
                                    snapshot.data!.docs[index].data().content,
                                timeMessage: DateTime.parse(snapshot
                                    .data!.docs[index]
                                    .data()
                                    .timestamp),
                              )
                            : ItemReceivesMessage(
                                contentText:
                                    snapshot.data!.docs[index].data().content,
                                timeMessage: DateTime.parse(snapshot
                                    .data!.docs[index]
                                    .data()
                                    .timestamp),
                              );
                      },
                    );
                  } else {
                    return Center(
                        child: Text(
                      'Hi 👋',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ));
                  }
                },
              ),
            ),
            InputChat(
                controller: _chatTextController,
                onPressed: () {
                  setState(() {
                    FbStoreController().sendMessage(messages);
                    _chatTextController.clear();
                  });
                }),
          ],
        ),
      ),
    );
  }

  Messages get messages {
    Messages messages = Messages();
    messages.senderId = FbAuthController().currentUser.uid;
    messages.receiverId = widget.users!.id!;
    messages.content = _chatTextController.text;
    messages.timestamp = DateTime.now().toString();
    return messages;
  }
}
