import 'package:chatapp11/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import "/constants.dart";
class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";
  
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  
  
  final _auth = FirebaseAuth.instance;//for authentacting the users intop the firebase
  late String email;
  late String password;
  bool showSpinner = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundcolor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag:"logo",
                  child: Container(
                    height: 200.0,
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
              button(name:"Regrister",onpressed: ()async {
                setState(){
                  showSpinner = true;
                }
                      /*print(email);
                      print(password);*/
                      try{
                      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      
                      if(newUser != Null){
                        Navigator.pushNamed(context,ChatScreen.id);
                      }
                      setState(){
                        showSpinner = false;
                      }
                      }
                      catch(e){
                        print(e);
                      }
                    
                    },
                    colour: Color.fromARGB(255, 202, 24, 247),),
            ],
          ),
        ),
      ),
    );
  }
}
