import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static void showToast(
      {required String toastMessage, required Color toastColor}) async {
    Fluttertoast.showToast(
      msg: toastMessage,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      gravity: ToastGravity.CENTER,
      backgroundColor: toastColor,
      textColor: Colors.white,
      fontSize: 20,
    );
  }
}