import 'dart:io';

import 'package:flutter/material.dart';

int? id, idPro, idCat;
File? imageProduct;
String? getPro, getProduct0, getProduct1, getProduct2, getProduct3;
double? pricePro, priceProduct0, priceProduct1, priceProduct2, priceProduct3;
int? b, b0, b1, b2, b3;
String? token, tokenMer;
final productNameController = TextEditingController();
final productPriceController = TextEditingController();
final productDesController = TextEditingController();
final catController = TextEditingController();
String? idc;
int? currentIndex;
final productID = <int>[];
final productNames = <String>[];
final productDes = <String>[];
final productPrices = <String>[];
final productImages = <String>[];

final nameController = TextEditingController();
final phoneController = TextEditingController();
final addressController = TextEditingController();
var passController = TextEditingController();
var emailController = TextEditingController();
const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

const headingStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: kTextColor),
  );
}
