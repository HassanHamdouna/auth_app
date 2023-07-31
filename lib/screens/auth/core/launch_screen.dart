import 'package:app_auth/firebase/fb_auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        String rote =
            FbAuthController().loggedIn ? "/message_screen" : "/login_screen";
        return Navigator.pushReplacementNamed(context, rote);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          const Color(0xffFFFFFF),
          const Color(0xff000000).withOpacity(0.5),
        ])),
        child: Text('Auth App',
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 30.sp)),
      ),
    );
  }
}
