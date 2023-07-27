import 'package:app_auth/firebase/fb_auth_controller.dart';
import 'package:app_auth/models/fb_response.dart';
import 'package:app_auth/utils/context_extenssion.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late List<TextEditingController> _digitControllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _digitControllers = List.generate(6, (index) => TextEditingController());
    _focusNodes = List.generate(6, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _digitControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            'OTP',
            style: GoogleFonts.poppins(
              color: const Color(0xff0D5DA6),
            ),
          ),
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
              'We have sent you a verification code message to your number ',
              style: GoogleFonts.notoKufiArabic(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              '9xxxxxxxx',
              style: GoogleFonts.notoKufiArabic(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                6,
                (index) => buildDigitTextField(index),
              ),
            ),
            SizedBox(height: 25.h),
            Align(
              alignment: AlignmentDirectional.center,
              child: Text('Resend the code',
                  style: GoogleFonts.notoKufiArabic(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                  )),
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
                  String verificationCode = '';
                  for (var controller in _digitControllers) {
                    verificationCode += controller.text;
                  }
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

  Widget buildDigitTextField(int index) {
    return SizedBox(
      width: 40.w,
      height: 40.h,
      child: TextField(
        controller: _digitControllers[index],
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black.withOpacity(0.2),
          counterText: '',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
        focusNode: _focusNodes[index],
        onChanged: (value) {
          if (value.isEmpty) {
            if (index > 0) {
              _focusNodes[index].unfocus();
              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
            }
          } else if (value.isNotEmpty && index < _focusNodes.length - 1) {
            _focusNodes[index].unfocus();
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          }
        },
        onEditingComplete: () {
          _focusNodes[index].unfocus();
        },
      ),
    );
  }

  void _performOTP() {
    if (_checkData()) {
      _login();
    }
  }

  bool _checkData() {
    if (_digitControllers.isEmpty) {
      return true;
    }
    return false;
  }

  void _login() async {
    FbResponse response =
        await FbAuthController().checkOTP('verificationId', 'smsCode');
    if (response.success) {
      Navigator.pushReplacementNamed(context, '/verification_screen');
    }
    if (!response.success) {
      print('response.message${response.message}');
      context.showAwesomeDialog(
          message: response.message, error: !response.success);
    }
    Navigator.pushReplacementNamed(context, '/home_screen');
  }
}
