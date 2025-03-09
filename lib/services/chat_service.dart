import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getMessages(String chatRoomId) {
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }

  Future<void> sendMessage(String chatRoomId, String senderId, String text) async {
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add({
      'senderId': senderId,
      'text': text,
      'timestamp': DateTime.now(),
    });
  }
}