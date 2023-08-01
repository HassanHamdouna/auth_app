import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchApp extends StatelessWidget {
  const SearchApp({
    super.key,
    required this.controller,
    this.onChanged,
    required this.hintText,
    required this.onPressed,
  });

  final TextEditingController controller;
  final String hintText;
  final Function() onPressed;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: TextField(
            textAlign: TextAlign.start,
            controller: controller,
            onChanged: onChanged,
            keyboardType: TextInputType.text,
            style: GoogleFonts.notoKufiArabic(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xffC2C0C0),
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: hintText,
              hintStyle: GoogleFonts.cairo(fontSize: 13.sp),
              hintMaxLines: 1,
              prefixIcon: const Icon(Icons.search_rounded),
              filled: true,
              fillColor: const Color(0xffF3F7FA),
              enabledBorder: buildOutlineInputBorder(),
              focusedBorder: buildOutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(
              right: 0.w,
            ),
            width: 42.w,
            height: 38.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: Colors.blueGrey,
            ),
            child: IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.tune),
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

OutlineInputBorder buildOutlineInputBorder({Color color = Colors.transparent}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: BorderSide(color: color),
  );
}
