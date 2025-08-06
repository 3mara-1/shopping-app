import 'package:big_basket/presentation/screens/home.dart';
import 'package:big_basket/presentation/screens/welcom.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    
    
    
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translation',
      fallbackLocale: Locale('en', 'US'),
      child: BigBasket(isLoggedIn: isLoggedIn)
    ),
    
    
    );
}

class BigBasket extends StatelessWidget {

  final bool isLoggedIn;
  const BigBasket({super.key, required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
        primarySwatch: Colors.teal,
        fontFamily: 'Suwannaphum',
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white
          )
        )
      ),
      
      home: isLoggedIn ? ShoppingHomeScreen() : Welcome(),

    );
  }
}