import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

Widget defaultButton({
  double width = double.infinity,
  double? height,
  TextStyle? style = const TextStyle(color: Colors.white, fontSize: 15),
  Color? background,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: style,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultFormField(
        {required String text,
        required TextEditingController controller,
        required TextInputType type,
        required FormFieldValidator validator,
        IconData? prefix,
        IconData? suffix,
        GestureTapCallback? onTap,
        Function? suffixPressed,
        ValueChanged? onChanged,
        ValueChanged? onSubmit,
        bool isPassword = false,
        int numOfLines = 1,
        bool t = true}) =>
    TextFormField(
      maxLines: numOfLines,
      obscureText: isPassword,
      controller: controller,
      keyboardType: type,
      onChanged: onChanged,
      validator: validator,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      enabled: t,
      decoration: InputDecoration(
          // labelText: text,
          hintText: text,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: HexColor('#706666'),
            width: 2,
          )),
          enabledBorder: const UnderlineInputBorder(),
          prefixIcon: prefix != null
              ? Icon(
                  prefix,
                )
              : null,
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: () {
                    suffixPressed!();
                  },
                  icon: Icon(suffix, color: Colors.grey))
              : null,
          border: const UnderlineInputBorder()),
    );

Widget defaultTextButton(
        {VoidCallback? onPress, required String text, TextStyle? style}) =>
    TextButton(
        onPressed: onPress,
        child: Text(
          text,
          style: style,
        ));

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void flutterToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { S, E, W }

Color chooseColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.S:
      color = Colors.green;
      break;
    case ToastStates.W:
      color = Colors.amber;
      break;
    case ToastStates.E:
      color = Colors.red;
      break;
  }
  return color;
}
