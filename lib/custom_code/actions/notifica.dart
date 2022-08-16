// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
import 'package:flutter_toastr/flutter_toastr.dart';

Future notifica(BuildContext context, String message) async {
  // Add your function code here!
  FlutterToastr.show(message, context,
      duration: 2,
      position: FlutterToastr.bottom,
      backgroundColor: Colors.red,
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ));
}
