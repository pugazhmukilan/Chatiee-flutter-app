import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';

void main() async {
  

  // Check login status before running the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  bool isLoggedIn = await checkLoginStatus();

  

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(Chatiee(isLoggedIn)));
  runApp(Chatiee(isLoggedIn));
}

class Chatiee extends StatelessWidget {
  final bool isLoggedIn;

  Chatiee(this.isLoggedIn);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: isLoggedIn ? ChatScreen.id : WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
      },
    );
  }
}

Future<bool> checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedEmail = prefs.getString('email');
  String? storedPassword = prefs.getString('password');

  if (storedEmail != null && storedPassword != null) {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: storedEmail,
        password: storedPassword,
      );
      return true; // User is already logged in
    } catch (e) {
      print("Auto login failed: $e");
      return false; // User is not logged in or auto login failed
    }
  } else {
    return false; // User is not logged in
  }
}
