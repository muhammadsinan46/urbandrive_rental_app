import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:urbandrive/domain/repository/chat_repo/chat_repostiory.dart';

class ChatRoomScreen extends StatefulWidget {
  ChatRoomScreen({super.key, required this.userId});

 final  String? userId;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  ChatRepository? chatRepo;

  String receiverId = "admin@urbandrive.com";

  var _messageText = TextEditingController();
  final DatabaseReference chatdb =
      FirebaseDatabase.instance.ref().child('chat_support');
  final DatabaseReference dbref = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    // final DatabaseReference chatdb =
    //     FirebaseDatabase.instance.ref().child('chat_support');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 70, 124, 162),
        elevation: 2,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios_new, color: Colors.white,)),
        title: Text("URBAN DRIVE", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height-180,
              width: MediaQuery.sizeOf(context).width,
              child: StreamBuilder(
                stream: chatdb.onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                    Map<dynamic, dynamic> map =
                        snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                    List<dynamic> messageList = map.values.toList();
            
                    messageList.forEach((chat) {
                      if (chat['datetime'] is String) {
                        chat['datetime'] = DateTime.parse(chat['datetime']);
                      }
                    });

                    messageList.sort((a, b) => b['datetime'].compareTo(a['datetime']),);

                    messageList = messageList.reversed.toList();

              messageList = messageList.reversed.toList();
                    return Container(
                      child: ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data!.snapshot.children.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [getmessages(context, messageList, index)],
                          );
                        },
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else {
                    return Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: 50,
                        width: MediaQuery.sizeOf(context).width*0.7,
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.only(left: 12),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              color: const Color.fromARGB(255, 209, 234, 255),
                            ),
                        
                            child: Row(
                              
                              children: [
                                Text("Hi there.How can we help")
                              ],
                            ),
                          ),
                    );
                  }
                },
              ),
            ),
            Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(5),
        height: 60,
        decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(30)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Expanded(
            
                child: TextField(
  
              controller: _messageText,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: "Type a message"),
            )),
            IconButton(
                onPressed: () {
                  Map<String, dynamic> data = {
                    "senderId": widget.userId,
                    "message": _messageText.text.trim(),
                    "datetime": DateTime.now().toIso8601String()
                  };
                  _sendMessage(context, data);
                },
                icon: Icon(Icons.send))
          ],
        ),
      ),
          ],
        ),
      ),

    );
  }

  Widget getmessages(
      BuildContext context, List<dynamic> messageList, int index) {
    var alignment = (messageList[index]['senderId'] == widget.userId)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(left: 12),
      alignment: alignment,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(20)),
        color: const Color.fromARGB(255, 209, 234, 255),
      ),
      constraints: BoxConstraints(
          minHeight: 50, maxWidth: MediaQuery.sizeOf(context).width * 0.7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(messageList[index]['message']),
          Padding(
            padding: const EdgeInsets.only(right:8.0, top: 16),
            child: Text(messageList[index]['datetime'].toString().substring(10,16),style: TextStyle(fontSize: 12),),
          ),
        
        ],

      ),
    );
  }

  void _sendMessage(BuildContext context, Map<String, dynamic> data) {
    dbref
        .child('chat_support')
        .push()
        .set(data)
        .whenComplete(() => _messageText.clear());
  }
}
