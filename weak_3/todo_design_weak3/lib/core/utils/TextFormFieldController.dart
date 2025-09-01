import 'package:flutter/material.dart';

class Textformfieldcontroller {
  static TextEditingController loginemailcontroller = TextEditingController();
  static TextEditingController loginpasswordcontroller =
      TextEditingController();
  static TextEditingController registeremailcontroller =
      TextEditingController();
  static TextEditingController registerpasswordcontroller =
      TextEditingController();
  static TextEditingController confirmcontroller = TextEditingController();
  static TextEditingController namecontroller = TextEditingController();
  static TextEditingController endtimecontroller = TextEditingController();
  static TextEditingController groubcontroller = TextEditingController();
  static TextEditingController titlecontroller = TextEditingController();
  static TextEditingController discriptioncontroller = TextEditingController();
  static Map<String, String>? selectedGroup;
  static bool isOpen = false;
  static TextEditingController newPasswordcontroller = TextEditingController();
  static TextEditingController newConfirmPasswordcontroller =
      TextEditingController();
}
