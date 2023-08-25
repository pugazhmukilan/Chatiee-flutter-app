import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import "/constants.dart";
import '/screens/login_screen.dart';
import '/screens/registration_screen.dart';
class WelcomeScreen extends StatefulWidget {
  static String id= "welcome_screen";
  
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>with TickerProviderStateMixin {
//single ticker is for single animation ...if we use just the tickewr then it for multi animation purpose 
  late AnimationController controller;
  late AnimationController colorController;
  late Animation animation;
  late Animation colorAnimation;
  bool _isLoggedIn= true;
  
  
  @override

  void initState(){
    super.initState();
    
    
    controller =AnimationController(
      vsync:this,//providing the ticker(what so going to act as ticker)
      duration: Duration(seconds:1), //hwo far the animatuion gonna to happen
      

    

    );

    animation= CurvedAnimation(parent:controller,curve:Curves.bounceInOut);
    controller.forward();//proceed the animation


    controller.addListener(() {//used to listen the movements of the animation ticker and use that in the various purpose
      setState(() {
        
        
      });
      
      
    });

    colorController=AnimationController(vsync: this,duration: Duration(seconds:1));
    colorAnimation=ColorTween(begin: const Color.fromARGB(255, 65, 65, 65),end:kBackgroundcolor).animate(colorController);
    colorController.forward();
    colorController.addListener(() {
      setState(() {
      
      });
    });
    //checkLoginStatus();
    //checkLoginStatus();
    }
    @override
    void dispose(){
      controller.dispose();
      super.dispose();
    }
    

    

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAnimation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

          Padding(
              //padding for making it center in the screen
              padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: "logo",
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height:animation.value*80,
                    ),
                  ),
                  AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Chatiee',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      speed: const Duration(milliseconds: 145),
                    ),
                  ],
                  
                                  ),
                
                ],
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            button(name:"Login",onpressed: () {
                    Navigator.pushNamed(context,LoginScreen.id);
                  },
                  colour: Color.fromARGB(255, 202, 24, 247),),
          
            button(name:"Register",onpressed: () {
                    Navigator.pushNamed(context,RegistrationScreen.id);
                  },
                  colour: Color.fromARGB(255, 202, 24, 247),),
            
],
        ),
      ),
  
    );
  }

}

