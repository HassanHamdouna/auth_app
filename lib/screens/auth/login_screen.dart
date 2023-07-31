import 'package:app_auth/firebase/fb_auth_controller.dart';
import 'package:app_auth/firebase/fb_store_controller.dart';
import 'package:app_auth/models/fb_response.dart';
import 'package:app_auth/models/users.dart';
import 'package:app_auth/utils/context_extenssion.dart';
import 'package:app_auth/widgets/button_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Auth App',
            style: GoogleFonts.poppins(
                fontSize: 22.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black)),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('images/logo_icon.png', width: 150, height: 200),
              const SizedBox(
                height: 20,
              ),
              Text("Welcome to FlutterFirebase",
                  style: GoogleFonts.poppins(
                      fontSize: 22, fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 30,
              ),
              ButtonLogin(
                  color: Colors.blueAccent,
                  title: 'facebook',
                  image: 'facebook',
                  onPressed: () async {
                    FbResponse response =
                        await FbAuthController().signInWithFacebook();
                    if (response.success) {
                      FbStoreController().create(users);
                      Navigator.pushNamed(context, '/message_screen');
                    }
                    if (!response.success) {
                      print('response.message${response.message}');
                      context.showAwesomeDialog(
                          message: response.message, error: !response.success);
                    }
                  }),
              ButtonLogin(
                  color: Colors.white54,
                  title: 'Google',
                  image: 'google',
                  onPressed: () async {
                    FbResponse response =
                        await FbAuthController().signInWithGoogle();

                    if (response.success) {
                      // Navigator.pushNamed(context, '/message_screen');
                      FbStoreController().create(users);
                    }
                    if (!response.success) {
                      print('response.message${response.message}');
                      context.showAwesomeDialog(
                          message: response.message, error: !response.success);
                    }
                  }),
              ButtonLogin(
                  color: Colors.black26,
                  title: 'Twitter',
                  image: 'twitter',
                  onPressed: () {}),
              ButtonLogin(
                  color: Colors.black,
                  title: 'phone',
                  image: 'phone',
                  onPressed: () {
                    Navigator.pushNamed(context, '/register_phone_screen');
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Users get users {
    Users users = Users();
    users.id = FbAuthController().currentUser.uid;
    users.name = FbAuthController().currentUser.displayName ?? '';
    users.password = FbAuthController().currentUser.phoneNumber ?? '';
    users.email = FbAuthController().currentUser.email;
    users.phone = FbAuthController().currentUser.phoneNumber ?? '';
    users.image = FbAuthController().currentUser.photoURL ?? '';
    return users;
  }
}
