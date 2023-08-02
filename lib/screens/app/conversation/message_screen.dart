import 'package:app_auth/firebase/fb_auth_controller.dart';
import 'package:app_auth/firebase/fb_store_controller.dart';
import 'package:app_auth/models/users.dart';
import 'package:app_auth/screens/app/conversation/chat_screen.dart';
import 'package:app_auth/widgets/app_circular_progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  bool isTextSearchEmpty = true;
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
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  FbAuthController().signOut();
                  Navigator.pushReplacementNamed(context, '/login_screen');
                });
              },
              icon: Icon(
                Icons.login_sharp,
                color: Colors.white,
              ))
        ],
        title: Text('Message',
            style: GoogleFonts.notoKufiArabic(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            )),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff0D5DA6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchApp(
                controller: _searchTextController,
                onChanged: (vaule) {
                  setState(() {
                    isTextSearchEmpty = _searchTextController.text.isEmpty;
                  });
                },
                hintText: 'Search for messages',
                onPressed: () {
                  setState(() {});
                }),
            isTextSearchEmpty
                ? Expanded(
                    child: StreamBuilder<QuerySnapshot<Users>>(
                      stream: FbStoreController().read(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const AppCircularProgress();
                        } else if (snapshot.data!.docs.isNotEmpty &&
                            snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                              users: getUsers(
                                                  snapshot.data!.docs[index])),
                                        ));
                                  },
                                  child: UserMessage(
                                    name: snapshot.data!.docs[index]
                                            .data()
                                            .name ??
                                        '',
                                    image: snapshot.data!.docs[index]
                                            .data()
                                            .image ??
                                        'https://lh3.googleusercontent.com/a/default-user=s40-c',
                                  ));
                            },
                          );
                        } else {
                          return const Center(
                            child: Text(
                              'NO Users',
                            ),
                          );
                        }
                      },
                    ),
                  )
                : Expanded(
                    child: StreamBuilder<QuerySnapshot<Users>>(
                      stream: FbStoreController()
                          .search(_searchTextController.text),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const AppCircularProgress();
                        } else if (snapshot.data!.docs.isNotEmpty &&
                            snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                              users: getUsers(
                                                  snapshot.data!.docs[index])),
                                        ));
                                  },
                                  child: UserMessage(
                                    name: snapshot.data!.docs[index]
                                            .data()
                                            .name ??
                                        '',
                                    image: snapshot.data!.docs[index]
                                            .data()
                                            .image ??
                                        'https://lh3.googleusercontent.com/a/default-user=s40-c',
                                  ));
                            },
                          );
                        } else {
                          return const Center(
                            child: Text(
                              'NO Users',
                            ),
                          );
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Users getUsers(QueryDocumentSnapshot<Users> queryNote) {
    Users users = Users();
    users.id = queryNote.id;
    users.name = queryNote.data().name;
    users.image = queryNote.data().image;
    return users;
  }
}
