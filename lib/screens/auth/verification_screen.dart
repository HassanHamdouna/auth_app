import 'dart:async';

import 'package:app_auth/firebase/fb_auth_controller.dart';
import 'package:app_auth/models/fb_response.dart';
import 'package:app_auth/utils/context_extenssion.dart';
import 'package:app_auth/widgets/text_filed_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen(
      {Key? key, required this.verificationId, required this.yourNumber})
      : super(key: key);
  final String verificationId;
  final String yourNumber;

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;
  bool timeSendCode = false;
  String myVerificationId = '';

  String verificationCode = '';
  late TextEditingController _oneOTPControllers;
  late TextEditingController _towOTPControllers;
  late TextEditingController _threeOTPControllers;
  late TextEditingController _fourOTPControllers;
  late TextEditingController _fiveOTPControllers;
  late TextEditingController _sixOTPControllers;

  @override
  void initState() {
    super.initState();
    _oneOTPControllers = TextEditingController();
    _towOTPControllers = TextEditingController();
    _threeOTPControllers = TextEditingController();
    _fourOTPControllers = TextEditingController();
    _fiveOTPControllers = TextEditingController();
    _sixOTPControllers = TextEditingController();
    startTime();
    myVerificationId = widget.verificationId;
  }

  @override
  void dispose() {
    _oneOTPControllers.dispose();
    _towOTPControllers.dispose();
    _threeOTPControllers.dispose();
    _fourOTPControllers.dispose();
    _fiveOTPControllers.dispose();
    _sixOTPControllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (seconds == 0) {
      stopTime();
      timeSendCode = true;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: Align(
          alignment: AlignmentDirectional.topStart,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff0D5DA6),
            )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your code',
              style: GoogleFonts.notoKufiArabic(
                  color: const Color(0xff0D5DA6),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              'We have sent you a verification code message to',
              style: GoogleFonts.notoKufiArabic(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              widget.yourNumber,
              style: GoogleFonts.notoKufiArabic(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFiledOTP(controller: _oneOTPControllers),
                TextFiledOTP(controller: _towOTPControllers),
                TextFiledOTP(controller: _threeOTPControllers),
                TextFiledOTP(controller: _fourOTPControllers),
                TextFiledOTP(controller: _fiveOTPControllers),
                TextFiledOTP(controller: _sixOTPControllers),
              ],
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: timeSendCode
                        ? () {
                            if (seconds == 0) {
                              startTime();
                              timeSendCode = false;
                              phoneAuth();
                            }
                          }
                        : null,
                    child: Text(
                      'Resend the code',
                      style: GoogleFonts.notoKufiArabic(
                        color: timeSendCode ? Colors.blueAccent : Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.sp,
                      ),
                    )),
                Text('00:${seconds}',
                    style: GoogleFonts.notoKufiArabic(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 13.sp,
                    )),
              ],
            ),
            SizedBox(height: 20.h),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    minimumSize: Size(double.infinity, 48.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r))),
                onPressed: () {
                  _performOTP();
                },
                child: Text('verification',
                    style: GoogleFonts.notoKufiArabic(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startTime() {
    seconds = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTime();
          timeSendCode = true;
        }
      });
    });
  }

  void stopTime() {
    timer?.cancel();
  }

  void _performOTP() {
    if (_checkData()) {
      _login();
    }
  }

  bool _checkData() {
    if (_oneOTPControllers.text.isNotEmpty &&
        _towOTPControllers.text.isNotEmpty &&
        _threeOTPControllers.text.isNotEmpty &&
        _fourOTPControllers.text.isNotEmpty &&
        _fiveOTPControllers.text.isNotEmpty &&
        _sixOTPControllers.text.isNotEmpty) {
      return true;
    }
    context.showAwesomeDialog(message: 'empty number', error: false);
    return false;
  }

  void _login() async {
    String smsCode = _oneOTPControllers.text +
        _towOTPControllers.text +
        _threeOTPControllers.text +
        _fourOTPControllers.text +
        _fiveOTPControllers.text +
        _sixOTPControllers.text;

    FbResponse response =
        await FbAuthController().signInWithCheckOTP(myVerificationId, smsCode);
    if (response.success) {
      stopTime();
      Navigator.pushReplacementNamed(context, '/home_screen');
    }
    if (!response.success) {
      context.showAwesomeDialog(
          message: response.message, error: !response.success);
    }
  }

  void phoneAuth() {
    try {
      FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.yourNumber, //yourNumber
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            await FirebaseAuth.instance.signInWithCredential(credential);
          } catch (e) {
            print('Error signing in: ${e.toString()}');
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Error FirebaseAuthException: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          myVerificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('codeAutoRetrievalTimeout 2');
        },
      );
    } on FirebaseAuthException catch (e) {
      return context.showAwesomeDialog(message: e.toString(), error: false);
    } catch (e) {
      return context.showAwesomeDialog(message: e.toString(), error: false);
    }
  }
}
