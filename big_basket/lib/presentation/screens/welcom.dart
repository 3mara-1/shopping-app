import 'package:big_basket/presentation/screens/sign_in_form.dart';
import 'package:big_basket/presentation/screens/sign_up_form.dart';
import 'package:big_basket/presentation/shared/style/common_widget_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  void _toggleLanguage() {
    if (context.locale == Locale('en', 'US')) {
      context.setLocale(Locale('ar', 'EG'));
    } else {
      context.setLocale(Locale('en', 'US'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _toggleLanguage,
            icon: Icon(Icons.language),
            tooltip: context.locale == Locale('en', 'US') ? 'العربية' : 'English',
          ),
        ],
      ),
      body: Container(
        decoration: CommonWidgetStyle.decoration(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                tr('welcom_mass'),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              Text('Big Basket',
                style: TextStyle(
                  fontSize: 38,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,

                ),
              ),
              // Image.asset("assets/images/logo.png", width: 200, height: 100),
              SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    tr('sign_in'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    // padding:EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    tr('sign_up'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}