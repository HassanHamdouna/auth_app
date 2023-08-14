import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonLogin extends StatelessWidget {
  ButtonLogin({
    super.key,
    required this.color,
    required this.title,
    required this.imageIcon,
    required this.colorIcon,
    required this.onPressed,
  });

  Color color;
  Color colorIcon;
  IconData? imageIcon;
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
                   FaIcon(imageIcon,color: colorIcon,size: 30),
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
