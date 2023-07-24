import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonLogin extends StatelessWidget {
  ButtonLogin({
    super.key,
    required this.color,
    required this.title,
    required this.image,
    required this.onPressed,
  });

  Color color;
  String image;
  String title;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: color,
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    fit: BoxFit.contain,
                    'images/${image}_icon.png',
                    width: 40.w,
                    height: 40.h,
                  ),
                  Text(
                    'Sign in with $title',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.sp,
        ),
      ],
    );
  }
}
