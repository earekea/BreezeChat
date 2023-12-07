import 'package:flutter/material.dart';
import 'package:chat_breeze/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'welcome_screen.dart';
import 'package:bubble/bubble.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;


class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();
  late String messageText;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {

                _auth.signOut();
                Navigator.popUntil(context, ModalRoute.withName(WelcomeScreen.id));
              }),
        ],
        title: Text('Breeze Chat'),
        backgroundColor: Color(0XFF006d77),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/12.jpg'),
          fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(),
              Container(
                decoration: BoxDecoration(
                ),

                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: kMessageContainerDecoration,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: messageTextController,
                                onChanged: (value) {
                                  messageText = value;


                                },
                                decoration: kMessageTextFieldDecoration,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all( 7.0),
                              child: Container( decoration: BoxDecoration(
                                color: Color(0XFF006d77),
                                borderRadius: BorderRadius.circular(50.0),

                              ),
                                child: IconButton(
                                  onPressed: () {
                                    messageTextController.clear();
                                    _firestore.collection('messages').add({
                                      'text': messageText,
                                      'sender': loggedInUser.email,
                                      'timestamp': FieldValue.serverTimestamp()

                                    });
                                  },
                                 icon: Icon(Icons.send, color: Color(0xfff4f3ee))
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

class MessagesStream extends StatelessWidget {
  const MessagesStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('timestamp',descending: false ).snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Color(0XFF006d77),
            ),
          );
        }
        final messages = snapshot.data.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          var data = message.data() as Map;

          final messageText = data['text'];
          final messageSender = data['sender'];

          final currentUser = loggedInUser.email;

          final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender);

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {required this.sender, required this.text, required this.isMe});

  final String sender;
  final String text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [

          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
            elevation: 7.0,
            color: isMe ? Color(0XFF6b9080) : Color(0xffcad2c5),
            child: Padding(
              padding:  EdgeInsets.symmetric(
                vertical: 1.5,
                horizontal: 10.0,
              ),
              child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                children: [ if (isMe==false)
                  Text( sender.substring(0, sender.indexOf('@')),
      style: TextStyle(fontSize: 15.0, color: Color(0xff457b9d)),
                    textAlign: TextAlign.left,
    ),
                      SizedBox( height: 3.0,),
                      Row(crossAxisAlignment: CrossAxisAlignment.end,
                        // textBaseline: TextBaseline.alphabetic,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 3.0,
                                  horizontal: 10.0,
                                ),
                                child: Text(
                                  text,
                                  style: TextStyle(
                                      fontSize: 19.0, color: isMe ? Colors.black : Colors.black),
                                ),

                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
