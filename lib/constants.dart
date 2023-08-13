import 'package:flutter/material.dart';
const kBackgroundcolor = Color.fromARGB(255, 19, 0, 40);
const kShadow = const Color.fromARGB(255, 153, 62, 223);
const kSendButtonTextStyle = TextStyle(
  color: Color.fromARGB(200, 201, 14, 248),
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kSendercolor = Color.fromARGB(255, 153, 62, 223);
const kRecivercolor = Color.fromARGB(255, 0, 0, 0);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    
    top: BorderSide(color: Color.fromARGB(200, 201, 14, 248), width: 2.0,),
  ),
);

const Kdecoration=InputDecoration(
        hintText: 'Enter the Text',hintStyle: TextStyle(color: Color.fromARGB(139, 204, 204, 204)),
        contentPadding:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kIntitalcolourvalue, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color:  kFinalcolourvalue, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      );
const  Color kIntitalcolourvalue=Color.fromARGB(200, 201, 14, 248);
const Color kFinalcolourvalue=Color.fromARGB(226, 215, 53, 255);

class button extends StatelessWidget {
  final String name;
  final Color colour;
 //function varibale
  final void Function() onpressed;
  
  button({
    required this.name,
    required this.onpressed,
    required this.colour,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 10.0,
        shadowColor: Color.fromARGB(255, 85, 6, 99),
        child: MaterialButton(
          onPressed: onpressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            '$name',
          ),
        ),
      ),
    );
  }
}

