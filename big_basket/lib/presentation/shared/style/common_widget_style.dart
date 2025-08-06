import 'package:flutter/material.dart';
class CommonWidgetStyle {
static BoxDecoration decoration(){
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.teal.shade100, // Light Teal
        Colors.pink.shade100, // Light Pink
        Colors.teal.shade200, // Teal
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}

 static InputDecoration fieldStyle([String? labltext, String? hinttext]) {
   return InputDecoration(
      labelText: labltext,
      hintText: hinttext,
      //  alignLabelWithHint: true,
      //  floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize:15

      ),
      labelStyle: TextStyle(
        color: Colors.grey,
        fontSize: 15 
      ),
      floatingLabelStyle: TextStyle(
        color: Colors.teal, 
        fontSize: 20,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.grey, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Colors.teal, 
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
      
      // حواف الحقل عند وجود خطأ مع التركيز عليه
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.red, width: 2.0),
      ),
    );
  }


}