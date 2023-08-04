import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemReceivesMessage extends StatelessWidget {
  const ItemReceivesMessage({
    super.key,
    required this.contentText,
    required this.timeMessage,
  });

  final String contentText;
  final DateTime timeMessage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 5.w),
        child: Card(
          margin: const EdgeInsets.only(right: 150, left: 5),
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(5.r),
                child: Text(
                  maxLines: 3,
                  contentText,
                  style: GoogleFonts.notoKufiArabic(
                      color: const Color(0xff0F1828),
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  '${timeMessage.hour.sign + 1}:${timeMessage.minute}',
                  textAlign: TextAlign.end,
                  style: GoogleFonts.notoKufiArabic(
                      color: const Color(0xff0F1828),
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
