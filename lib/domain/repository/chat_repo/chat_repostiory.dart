import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:urbandrive/infrastructure/message_model/message_model.dart';

class ChatRepository{

final FirebaseFirestore firestore = FirebaseFirestore.instance;
sendMessage(String receiverId ,  String message)async{

final userId = FirebaseAuth.instance.currentUser!.uid;
final Timestamp timeStamp =Timestamp.now();

Message newMessage =Message(senderId: userId, receiverId: receiverId, message: message, timestamp: timeStamp);


List<String > ids= [userId, receiverId];
ids.sort();
String chatroomId = ids.join("_"); 


  await firestore.collection('chat_room').doc(chatroomId).collection('messages').add(newMessage.toMap());



}

Stream<QuerySnapshot> getMessages(String userId, String receiverId){


  List<String> ids = [userId, receiverId];

  String chatroomId = ids.join("_");

  return  firestore.collection('chat_room').doc(chatroomId).collection('messages').orderBy('timestamp', descending: true).snapshots();
}

}