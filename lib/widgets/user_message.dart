import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UserMessage extends StatelessWidget {
  const UserMessage({
    super.key,
    required this.name,
    required this.lastChat,
    required this.image,
  });

  final String name;
  final String lastChat;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(image),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          name,
                          style: GoogleFonts.notoKufiArabic(
                              color: const Color(0xff0D5DA6),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      // SizedBox(
                      //   width: 150.w,
                      // ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Text(
                              '9:00',
                              style: GoogleFonts.notoKufiArabic(
                                  color: const Color(0xff000000),
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'PM',
                              style: GoogleFonts.notoKufiArabic(
                                  color: const Color(0xff000000),
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    lastChat,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.notoKufiArabic(
                        color: const Color(0xff000000),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
