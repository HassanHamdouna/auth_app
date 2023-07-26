import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension ContextHelper on BuildContext {
  void showAwesomeDialog({required String message, bool error = false}) {
    AwesomeDialog(
            context: this,
            dialogType: DialogType.warning,
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2,
            ),
            width: 350,
            buttonsBorderRadius: const BorderRadius.all(
              Radius.circular(2),
            ),
            dismissOnTouchOutside: true,
            dismissOnBackKeyPress: false,
            headerAnimationLoop: false,
            animType: AnimType.bottomSlide,
            title: 'Warning',
            desc: message,
            showCloseIcon: true,
            /*btnCancelOnPress: () {},*/
            btnOkOnPress: () {},
            btnOkColor: Colors.lightBlue)
        .show();
  }
}
