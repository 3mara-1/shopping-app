import 'package:big_basket/presentation/screens/home.dart';
import 'package:big_basket/presentation/shared/dialogs/success_dialog.dart';
import 'package:big_basket/presentation/shared/style/common_widget_style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _saveLoginStatus(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    print('is logged $isLoggedIn');
  }

  void _toggleLanguage() {
    if (context.locale == Locale('en', 'US')) {
      context.setLocale(Locale('ar', 'EG'));
    } else {
      context.setLocale(Locale('en', 'US'));
    }
  }

  void _createAccount() {
    if (_formKey.currentState!.validate()) {
      _saveLoginStatus(true);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return SuccessDialog(
            message: tr('account_created_successfully'),
            onClose: () {
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => ShoppingHomeScreen(),
                  transitionDuration: Duration(milliseconds: 800),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            }
          );
        },
      );
    }
  }

  void _cancelForm() {
    Navigator.of(context).pop();
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
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        tr('create_account'),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        tr('join_big_basket'),
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _fullNameController,
                        decoration: CommonWidgetStyle.fieldStyle(
                          tr("full_name"),
                          tr("enter_your_full_name"),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr('please_enter_full_name');
                          }
                          if (value.isNotEmpty && !RegExp(r'^[A-Z\u0600-\u06FF]').hasMatch(value)) {
                            return tr('first_letter_must_be_uppercase');
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: CommonWidgetStyle.fieldStyle(
                          tr("email"),
                          tr("enter_your_email"),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr('please_enter_email');
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return tr('please_enter_valid_email');
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: CommonWidgetStyle.fieldStyle(
                          tr("password"),
                          tr("enter_your_password"),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr('please_enter_password');
                          }
                          if (value.length < 6) {
                            return tr('password_min_length');
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _confirmController,
                        decoration: CommonWidgetStyle.fieldStyle(
                          tr("confirm_password"),
                          tr("confirm_your_password"),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr('please_confirm_password');
                          }
                          if (value != _passwordController.text) {
                            return tr('passwords_not_match');
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 15,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.width * 0.14,
                              child: ElevatedButton(
                                onPressed: _createAccount,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  tr("create"),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.33,
                              height: MediaQuery.of(context).size.width * 0.14,
                              child: OutlinedButton(
                                onPressed: _cancelForm,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.teal,
                                  side: BorderSide(color: Colors.teal, width: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(tr('cancel')),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}