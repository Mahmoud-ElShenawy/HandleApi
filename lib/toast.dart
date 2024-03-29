import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toast({String message, bool error = false}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: error ? Colors.red : Colors.green,
    textColor: Colors.white,
    fontSize: 15.0,
  );
}
