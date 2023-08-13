import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/constants.dart';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late String? email;
  late User? user;
  final ScrollController _controller = ScrollController();

  double initialScrollOffset = _controller.position.maxScrollExtent;

class ChatScreen extends StatefulWidget {
  static String id = "chat_screen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextcontroller =TextEditingController();
  
  late String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    
  }

  void getCurrentUser() {
    user = _auth.currentUser;
    email = user?.email;
    if (user != null) {
      print("================================this is the user ${user?.email}");
    } else {
      print('The user is not logged in');
    }
  }

  void getMessageStream() async {
    // Create a reference to the 'messages' collection
    CollectionReference messagesCollection = firestore.collection('messages');

    // Create a stream of snapshots for the 'messages' collection
    Stream<QuerySnapshot> messageStream = messagesCollection.snapshots();

    // Wait for the stream and listen for changes
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        shadowColor:kShadow ,
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              getMessageStream();
              // Navigator.pushNamed(context,LoginScreen.id);
            },
          ),
        ],
        title: Row(
          children: [
            Image.asset('images/logo.png',width:50,height: 50,),
            Text("Chat"),
          ],
        ),
        backgroundColor:Color.fromARGB(255, 29, 29, 29),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
              child: Container(
                
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        
                        controller: messageTextcontroller,
                        onChanged: (value) {
                          messageText = value;
                        },//kMessageTextFieldDecoration
                        decoration: Kdecoration,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send_rounded),
                      onPressed: () {
                        if(messageTextcontroller.text != null){
                        messageTextcontroller.clear();
                        // messageText+loggedInUse user?.email
                        firestore.collection("messages").add({
                          'text': messageText,
                          'sender': user?.email,
                          'time':DateTime.now(),
                        });
                        }
                      
            
                      },
                      
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MessageStream extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
  stream: firestore.collection('messages').orderBy('time',descending: true).snapshots(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      List<MessageBubble> messageBubbles = [];
      for (var messageDoc in snapshot.data!.docs) {
        final messageData = messageDoc.data()as Map<String, dynamic>?; // Explicitly cast to Map<String, dynamic>?

        if (messageData != null) {
          final messageText = messageData['text'] as String?;
          final messageSender = messageData['sender'] as String?;
          final currentUser = user?.email;
          if (currentUser == messageSender){
            //the mesasge is from loggined user
          }
          if (messageText != null && messageSender != null) {
            //final messageWidget = Text('$messageSender: $messageText',
            final messageBubble = MessageBubble(sender:messageSender,text: messageText, isMe :(currentUser == messageSender)? true:false);
            
            
            messageBubbles.add(messageBubble);
          }
        }
      }

      return Expanded(
        child: ListView(
          controller: _controller,
          
          reverse: true,
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          children: messageBubbles,
        ),
      );
    } else {
      return CircularProgressIndicator(); // Or any other widget to show the loading state
    }
  },
);
  }
}


class MessageBubble extends StatelessWidget{

  // ignore: use_key_in_widget_constructors
  const MessageBubble({ this.sender,this.text,required this.isMe});
  final String? sender;
  final String? text;
  final bool isMe ;
  @override
  Widget build(BuildContext context){
    return Padding(
      padding:EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text('$sender',style:TextStyle(fontSize: 10,color: Color.fromARGB(255, 90, 88, 88))),
          Material(
           // Color.fromARGB(255, 153, 62, 223)
            color: (isMe)? kSendercolor
            :kRecivercolor,
            elevation: 5,
            borderRadius: isMe? BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(0.0),bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0),):BorderRadius.only(topLeft: Radius.circular(0.0),topRight: Radius.circular(30.0),bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0),),
            shadowColor: kShadow,
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text(
                '$text ',
                style:isMe? TextStyle( fontSize:15.0):TextStyle(fontSize:15.0,decorationStyle:TextDecorationStyle.dashed ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}