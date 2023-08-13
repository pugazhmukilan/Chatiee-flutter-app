import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import "/constants.dart";
import '/screens/chat_screen.dart';
class LoginScreen extends StatefulWidget {
  static String id= "login_screen";
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth= FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundcolor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag:"logo",
                child: Container(
                  height: 250.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged:(value){
                email=value;

              },
              decoration: Kdecoration.copyWith(hintText: "Enter the Email address"),
            ),
            SizedBox(
              height:10
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged:(value){
                password=value;

              },
              decoration: Kdecoration.copyWith(hintText: "Enter the Password"),
            ),
            button(name:"Login",onpressed: ()async {
              try{
                final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                // ignore: unnecessary_null_comparison
                if (user != null){
                  Navigator.pushNamed(context,ChatScreen.id);
                }
              }
              catch(e){
                print ("error");

              }
          
                
              
                    
                  },
                  colour: Color.fromARGB(255, 202, 24, 247),),
          ],
        ),
      ),
    );
  }
}
/*init color= Color.fromARGB(200, 201, 14, 248)**/
/*final color=Color.fromARGB(200, 201, 14, 248)*/
