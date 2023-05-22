
import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget {
  final String chatRoomId;
  final String currentUserEmail;
  final String otherUserEmail;
  final Map<String, dynamic> userMap;

  const ChatRoomScreen({
    required this.chatRoomId,
    required this.currentUserEmail,
    required this.otherUserEmail,
    required this.userMap,
  });

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final StreamController<bool> _typingIndicatorController =
      StreamController<bool>.broadcast();
  StreamSubscription<DocumentSnapshot>? _chatroomSubscription;

  @override
  void initState() {
    super.initState();
    _startTypingIndicatorListener();
  }

  @override
  void dispose() {
    _typingIndicatorController.close();
    _chatroomSubscription?.cancel();
    super.dispose();
  }

  Future<void> _startTypingIndicatorListener() async {
    _chatroomSubscription = _firestore
        .collection('chatroom')
        .doc(widget.chatRoomId)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      final isTyping = snapshot.get('isTyping') as bool? ?? false;
      _typingIndicatorController.add(isTyping);
    });
  }

  Future<void> _sendTypingStatus(bool isTyping) async {
    await _firestore
        .collection('chatroom')
        .doc(widget.chatRoomId)
        .update({'isTyping': isTyping});
  }

  Future<String?> uploadImage(File imageFile) async {
    String filename = Uuid().v1();
    var ref =
        FirebaseStorage.instance.ref().child('images').child("$filename.jpg");

    var uploadTask = ref.putFile(imageFile);
    var snapshot = await uploadTask.whenComplete(() {});
    String imageUrl = await snapshot.ref.getDownloadURL();

    return imageUrl;
  }

  Future getImages() async {
    ImagePicker _picker = ImagePicker();
    await _picker
        .pickImage(source: ImageSource.gallery)
        .then((XFile? pickedFile) async {
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        String? imageUrl = await uploadImage(imageFile);
        onSendMessage('', imageUrl);
      }
    });
  }

  void onSendMessage(String message, [String? imageUrl]) async {
    if (message.isNotEmpty || imageUrl != null) {
      Map<String, dynamic> messageData = {
        'sendBy': _auth.currentUser?.displayName,
        'message': message,
        'imageUrl': imageUrl,
        'time': FieldValue.serverTimestamp(),
      };

      await _firestore
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .add(messageData);

      _messageController.clear();
    } else {
      print('Enter some Text');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot>(
          stream: _firestore
              .collection("users")
              .doc(widget.userMap['uid'])
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Container(
                child: Column(
                  children: [
                    Text(widget.userMap['name']),
                    Text(
                      snapshot.data!['status'],
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height / 1.25,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('chatroom')
                    .doc(widget.chatRoomId)
                    .collection('chats')
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    final messages = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message =
                            messages[index].data() as Map<String, dynamic>;
                        final isCurrentUser =
                            message['sendBy'] == _auth.currentUser?.displayName;
                        // final timestamp = message['time'] as Timestamp;
                        final timestamp =
                            (message['time'] as Timestamp?)?.toDate() ??
                                DateTime.now();

                        return MessageBubble(
                          message: message['message'],
                          isCurrentUser: isCurrentUser,
                          timestamp: timestamp,
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
       
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: getImages,
                            icon: Icon(Icons.photo),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                hintText: 'Type a message...',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      onSendMessage(_messageController.text);
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final DateTime timestamp;

  const MessageBubble({
    required this.message,
    required this.isCurrentUser,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                  fontSize: 16,
                  color: isCurrentUser ? Colors.white : Colors.black),
            ),
            SizedBox(height: 4),
            Text(
              '${timestamp.hour}:${timestamp.minute}',
              style: TextStyle(
                  fontSize: 12,
                  color: isCurrentUser ? Colors.white70 : Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
