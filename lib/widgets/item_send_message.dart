import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemSendMessage extends StatelessWidget {
  const ItemSendMessage({
    super.key,
    required this.contentText,
    required this.timeMessage,
  });
  final String contentText;
  final DateTime timeMessage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 5.w),
        child: Card(
          margin: const EdgeInsets.only(right: 5, left: 150),
          color: const Color(0xff0D5DA6),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(5.r),
                child: Text(
                  contentText,
                  style: GoogleFonts.notoKufiArabic(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  '${timeMessage.hour.sign}:${timeMessage.minute}',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.notoKufiArabic(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
