import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InputChat extends StatelessWidget {
  InputChat({
    super.key,
    required this.controller,
    required this.onPressedSend,
    required this.onPressedImageGallery,
    required this.onPressedImageCamera,
  });

  TextEditingController? controller;
  Function()? onPressedSend;
  Function()? onPressedImageGallery;
  Function()? onPressedImageCamera;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              elevation: 5,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.start,
                      showCursor: true,
                      cursorHeight: 20,
                      cursorWidth: 2,
                      controller: controller,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: GoogleFonts.notoKufiArabic(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
                        hintStyle: GoogleFonts.cairo(fontSize: 13.sp),
                        hintMaxLines: 1,
                        hintText: 'Type Something ..',
                        filled: false,
                        border: InputBorder.none,
                        enabledBorder: buildOutlineInputBorder(),
                        focusedBorder: buildOutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onPressedImageGallery,
                    icon: const Icon(
                      Icons.image,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: onPressedImageCamera,
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: onPressedSend,
            minWidth: 0,
            shape: const CircleBorder(),
            color: Colors.green,
            padding:
                const EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
            child: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(
      {Color color = Colors.transparent}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(color: color),
    );
  }
}
