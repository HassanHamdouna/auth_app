import 'package:app_auth/firebase/fb_auth_controller.dart';
import 'package:app_auth/models/fb_response.dart';
import 'package:app_auth/utils/context_extenssion.dart';
import 'package:app_auth/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPhoneScreen extends StatefulWidget {
  const RegisterPhoneScreen({super.key});

  @override
  State<RegisterPhoneScreen> createState() => _RegisterPhoneScreenState();
}

class _RegisterPhoneScreenState extends State<RegisterPhoneScreen> {
  bool _obscure = true;

  late TextEditingController _phoneTextController;
  late TextEditingController _nameTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    super.initState();
    _phoneTextController = TextEditingController();
    _nameTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneTextController.dispose();
    _nameTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        leadingWidth: 80,
        backgroundColor: Colors.transparent,
        title: Text('Register phone',
            style: GoogleFonts.poppins(
                fontSize: 22.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black)),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('images/logo_icon.png', width: 150, height: 200),
                const SizedBox(
                  height: 10,
                ),
                Text("Phone Login",
                    style: GoogleFonts.poppins(
                        fontSize: 22, fontWeight: FontWeight.w500)),
                const SizedBox(
                  height: 30,
                ),
                AppTextField(
                    hint: '+9321013213',
                    prefixIcon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    controller: _phoneTextController),
                SizedBox(
                  height: 20.h,
                ),
                AppTextField(
                    hint: 'Name',
                    prefixIcon: Icons.person,
                    keyboardType: TextInputType.name,
                    controller: _nameTextController),
                SizedBox(
                  height: 20.h,
                ),
                AppTextField(
                  hint: 'password',
                  prefixIcon: Icons.lock,
                  obscureText: _obscure,
                  keyboardType: TextInputType.name,
                  controller: _passwordTextController,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                      icon: Icon(
                          _obscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 30,
                          color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ElevatedButton(
                    onPressed: () => performLogin(),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40)),
                    child: Text(
                      'register',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 14.sp),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void performLogin() {
    if (checkData()) {
      login();
    }
  }

  bool checkData() {
    if (_phoneTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty &&
        _phoneTextController.text.isNotEmpty) {
      return true;
    }
    const ScaffoldMessenger(
      child: SnackBar(
        content: Text('Error , enter required data !'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
    return false;
  }

  void login() async {
    FbResponse response = await FbAuthController().signInWithPhone(0);
    if (response.success) {
      Navigator.pushReplacementNamed(context, '/verification_screen');
    }
    if (!response.success) {
      print('response.message${response.message}');
      context.showAwesomeDialog(
          message: response.message, error: !response.success);
    }
  }
}
