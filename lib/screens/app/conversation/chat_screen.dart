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
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, this.users});
  Users? users;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? nameUserCureent;
  late ImagePicker _imagePicker;
  XFile? _filePickedImage;
  late TextEditingController _chatTextController;
  @override
  void initState() {
    super.initState();
    _chatTextController = TextEditingController();
    nameUserCureent = widget.users?.name;
    _imagePicker = ImagePicker();
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
                      reverse: false,
                      itemCount: snapshot.data!.docs.reversed.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return snapshot.data!.docs[index].data().senderId ==
                                FbAuthController().currentUser.uid
                            ? ItemSendMessage(
                                type: snapshot.data!.docs[index].data().type ==
                                        Type.text
                                    ? Type.text
                                    : Type.image,
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
                onPressedImageCamera: () => _openCamera(),
                onPressedImageGallery: () => _openGallery(),
                onPressedSend: () {
                  setState(() {
                    sendMessage();
                  });
                }),
          ],
        ),
      ),
    );
  }

  void sendMessage() {
    if (_chatTextController.text.isNotEmpty) {
      FbStoreController().sendMessage(messages);
      _chatTextController.clear();
      // _filePickedImage = null;
    }
    if (_filePickedImage != null) {
      FbStoreController().sendMessage(messages);
      _filePickedImage = null;
    }
  }

  void _openGallery() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _filePickedImage = image;
      sendMessage();
    }
  }

  void _openCamera() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _filePickedImage = image;
      sendMessage();
    }
  }

  Messages get messages {
    Messages messages = Messages();
    messages.senderName = FbAuthController().currentUser.displayName ?? 'null';
    messages.receiverName = nameUserCureent!;
    messages.senderId = FbAuthController().currentUser.uid;
    messages.receiverId = widget.users!.id!;
    messages.timestamp = DateTime.now().toString();
    messages.type = _filePickedImage == null ? Type.text : Type.image;
    messages.content = _filePickedImage == null
        ? _chatTextController.text
        : _filePickedImage!.path;
    return messages;
  }
}
