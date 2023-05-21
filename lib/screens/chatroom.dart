// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ChatRoom extends StatelessWidget {
//     final String chatRoomId;
// final Map<String, dynamic> userMap;

//   ChatRoom({required this.chatRoomId, required this.userMap});

// final TextEditingController _message = TextEditingController();
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// final FirebaseAuth _auth = FirebaseAuth.instance;

// void onSendMessage() async {
//   if (_message.text.isNotEmpty) {
//     Map<String, dynamic> message = {
//       "sendBy": _auth.currentUser?.displayName,
//       "message": _message.text,
//       "time": FieldValue.serverTimestamp(),
//     };
//     await _firestore
//         .collection('chatroom')
//         .doc(chatRoomId)
//         .collection('chats')
//         .add({});

//     _message.clear();
//   } else {
//     print("Enter some Text");
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(userMap['name']),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: size.height / 1.25,
//               width: size.width,
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: _firestore
//                     .collection('chatroom')
//                     .doc(chatRoomId)
//                     .collection('chats')
//                     .orderBy("time", descending: false)
//                     .snapshots(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.data != null) {
//                     return ListView.builder(
//                         itemCount: snapshot.data?.docs.length,
//                         itemBuilder: (context, Index) {
//                           return Text(snapshot.data?.docs[Index]['message']);
//                         });
//                   } else {
//                     return Container();
//                   }
//                 },
//               ),
//             ),
//             Container(
//               height: size.height / 10,
//               width: size.width,
//               alignment: Alignment.center,
//               child: Container(
//                 height: size.height / 12,
//                 width: size.width / 1.1,
//                 child: Row(
//                   children: [
//                     Container(
//                       height: size.height / 12,
//                       width: size.width / 1.5,
//                       child: TextField(
//                         controller: _message,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         onSendMessage();
//                       },
//                       icon: Icon(Icons.send),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class ChatRoomScreen extends StatefulWidget {
//   final String chatRoomId;
//   final String currentUserEmail;
//   final String otherUserEmail;

//   const ChatRoomScreen({
//     required this.chatRoomId,
//     required this.currentUserEmail,
//     required this.otherUserEmail,
//   });

//   @override
//   _ChatRoomScreenState createState() => _ChatRoomScreenState();
// }

// class _ChatRoomScreenState extends State<ChatRoomScreen> {
//   final TextEditingController _messageController = TextEditingController();

//   void _sendMessage() {
//     // Implement sending the message to the chat room
//     String message = _messageController.text;
//     // ...
//     // Add your implementation here
//     // ...
//     print('Sending message: $message');
//     _messageController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             CircleAvatar(
//               // Display the other user's profile icon
//               // Replace with your implementation
//               backgroundImage: AssetImage('path_to_profile_image'),
//             ),
//             const SizedBox(width: 8),
//             Text(
//               // Display the other user's name
//               // Replace with your implementation
//               'Other User Name',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               reverse: true,
//               itemCount: 0, // Replace with the actual message count
//               itemBuilder: (context, index) {
//                 // Replace with your implementation to display the messages
//                 return ListTile(
//                   title: Text('Message $index'),
//                 );
//               },
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               border: Border(
//                 top: BorderSide(color: Colors.grey),
//               ),
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: const InputDecoration(
//                       hintText: 'Type a message',
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: _sendMessage,
//                   icon: const Icon(Icons.send),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ChatRoomScreen extends StatefulWidget {
//   final String chatRoomId;
//   final String currentUserEmail;
//   final String otherUserEmail;
//   final Map<String, dynamic> userMap;

//   const ChatRoomScreen({
//     required this.chatRoomId,
//     required this.currentUserEmail,
//     required this.otherUserEmail,
//     required this.userMap,
//   });

//   @override
//   _ChatRoomScreenState createState() => _ChatRoomScreenState();
// }

// class _ChatRoomScreenState extends State<ChatRoomScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   void onSendMessage(String message) async {
//     if (message.isNotEmpty) {
//       Map<String, dynamic> messageData = {
//         'sendBy': _auth.currentUser?.displayName,
//         'message': message,
//         'time': FieldValue.serverTimestamp(),
//       };

//       await _firestore
//           .collection('chatroom')
//           .doc(widget.chatRoomId)
//           .collection('chats')
//           .add(messageData);

//       _messageController.clear();
//     } else {
//       print('Enter some Text');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//   final size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             CircleAvatar(
//                 // Display the other user's profile icon
//                 // Replace with your implementation
//                 // backgroundImage: AssetImage('path_to_profile_image'),
//                 ),
//             const SizedBox(width: 8),
//             Text(
//               // Display the other user's name
//               // Replace with your implementation
//               widget.userMap['name'],
//               style: const TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: size.height / 1.25,
//               width: size.width,
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: _firestore
//                     .collection('chatroom')
//                     .doc(widget.chatRoomId)
//                     .collection('chats')
//                     .orderBy("time", descending: false)
//                     .snapshots(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.data != null) {
//                     return ListView.builder(
//                         itemCount: snapshot.data?.docs.length,
//                         itemBuilder: (context, Index) {
//                           return Text(snapshot.data?.docs[Index]['message']);
//                         });
//                   } else {
//                     return Container();
//                   }
//                 },
//               ),
//             ),
//             Container(
//               height: size.height / 10,
//               width: size.width,
//               alignment: Alignment.center,
//               child: Container(
//                 height: size.height / 12,
//                 width: size.width / 1.1,
//                 child: Row(
//                   children: [
//                     Container(
//                       height: size.height / 12,
//                       width: size.width / 1.5,
//                       child: TextField(
//                         controller: _messageController,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         onSendMessage(_messageController.text);
//                       },
//                       icon: Icon(Icons.send),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:uuid/uuid.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ChatRoomScreen extends StatefulWidget {
//   final String chatRoomId;
//   final String currentUserEmail;
//   final String otherUserEmail;
//   final Map<String, dynamic> userMap;

//   const ChatRoomScreen({
//     required this.chatRoomId,
//     required this.currentUserEmail,
//     required this.otherUserEmail,
//     required this.userMap,
//   });

//   @override
//   _ChatRoomScreenState createState() => _ChatRoomScreenState();
// }

// class _ChatRoomScreenState extends State<ChatRoomScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

  
//   Future uploadImage(File imageFile) async {
//     String filename = Uuid().v1();
//     var ref =
//         FirebaseStorage.instance.ref().child('images').child("$filename.jpg");

//     var uploadTask = ref.putFile(imageFile);
//     var snapshot = await uploadTask.whenComplete(() {});
//     String imageUrl = await snapshot.ref.getDownloadURL();

//     // Call the method to send the message with the image URL
//     onSendMessage('', imageUrl);
//   }

//   Future getImages() async {
//     ImagePicker _picker = ImagePicker();
//     await _picker
//         .pickImage(source: ImageSource.gallery)
//         .then((XFile? pickedFile) async {
//       if (pickedFile != null) {
//         File imageFile = File(pickedFile.path);
//         await uploadImage(imageFile);
//       }
//     });
//   }

//   void onSendMessage(String message, [String? imageUrl]) async {
//     if (message.isNotEmpty || imageUrl != null) {
//       Map<String, dynamic> messageData = {
//         'sendBy': _auth.currentUser?.displayName,
//         'message': message,
//         'imageUrl': imageUrl,
//         'time': FieldValue.serverTimestamp(),
//       };

//       await _firestore
//           .collection('chatroom')
//           .doc(widget.chatRoomId)
//           .collection('chats')
//           .add(messageData);

//       _messageController.clear();
//     } else {
//       print('Enter some Text');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         // title: Text(widget.userMap['name']),
//         title: StreamBuilder<DocumentSnapshot>(
//           stream: _firestore
//               .collection("users")
//               .doc(widget.userMap['uid'])
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.data != null) {
//               return Container(
//                 child: Column(
//                   children: [
//                     Text(widget.userMap['name']),
//                     Text(
//                       snapshot.data!['status'],
//                       style: TextStyle(fontSize: 14),
//                     ),
//                   ],
//                 ),
//               );
//             } else {
//               return Container();
//             }
//           },
//         ),
       
//       ),

//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: size.height / 1.25,
//               width: size.width,
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: _firestore
//                     .collection('chatroom')
//                     .doc(widget.chatRoomId)
//                     .collection('chats')
//                     .orderBy("time", descending: false)
//                     .snapshots(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.data != null) {
//                     final messages = snapshot.data!.docs;
//                     return ListView.builder(
//                       itemCount: messages.length,
                     
//                       itemBuilder: (context, index) {
//   final message = messages[index].data() as Map<String, dynamic>;
//   final isCurrentUser = message['sendBy'] == _auth.currentUser?.displayName;

//   if (message['imageUrl'] != null) {
//     return Align(
//       alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.all(8),
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: isCurrentUser ? Colors.blue : Colors.grey[300],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           children: [
//             Image.network(
//               message['imageUrl'],
//               width: 200,
//               height: 200,
//             ),
//             if (message['message'].isNotEmpty)
//               const SizedBox(height: 8),
//               Text(
//                 message['message'],
//                 style: TextStyle(
//                   color: isCurrentUser ? Colors.white : Colors.black,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   } else {
//     return Align(
//       alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.all(8),
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: isCurrentUser ? Colors.blue : Colors.grey[300],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(
//           message['message'],
//           style: TextStyle(
//             color: isCurrentUser ? Colors.white : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// },

//                     );
//                   } else if (snapshot.hasError) {
//                     return Center(
//                       child: Text('Error: ${snapshot.error}'),
//                     );
//                   } else {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                 },
//               ),
//             ),
//             Container(
//               height: size.height / 10,
//               width: size.width,
//               alignment: Alignment.center,
//               child: Container(
//                 height: size.height / 12,
//                 width: size.width / 1.1,
//                 child: Row(
//                   children: [
//                     Container(
//                       height: size.height / 17,
//                       width: size.width / 1.3,
//                       child: TextField(
//                         controller: _messageController,
//                         decoration: InputDecoration(
//                           hintText: "Send Message",
//                           suffixIcon: IconButton(
//                             onPressed: getImages,
//                             icon: Icon(Icons.photo),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         onSendMessage(_messageController.text);
//                       },
//                       icon: Icon(Icons.send),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
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

  Future<String?> uploadImage(File imageFile) async {
    String filename = Uuid().v1();
    var ref = FirebaseStorage.instance
        .ref()
        .child('images')
        .child("$filename.jpg");

    var uploadTask = ref.putFile(imageFile);
    var snapshot = await uploadTask.whenComplete(() {});
    String imageUrl = await snapshot.ref.getDownloadURL();

    return imageUrl;
  }

  Future getImages() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((XFile? pickedFile) async {
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
        // title: Text(widget.userMap['name']),
        title: StreamBuilder<DocumentSnapshot>(
          stream: _firestore.collection("users").doc(widget.userMap['uid']).snapshots(),
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
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    final messages = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index].data() as Map<String, dynamic>;
                        final isCurrentUser = message['sendBy'] == _auth.currentUser?.displayName;

                        if (message['imageUrl'] != null) {
                          return Align(
                            alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isCurrentUser ? Colors.blue : Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Image.network(
                                    message['imageUrl'],
                                    width: 200,
                                    height: 200,
                                  ),
                                  if (message['message'].isNotEmpty) const SizedBox(height: 8),
                                  Text(
                                    message['message'],
                                    style: TextStyle(
                                      color: isCurrentUser ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Align(
                            alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isCurrentUser ? Colors.blue : Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                message['message'],
                                style: TextStyle(
                                  color: isCurrentUser ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          );
                        }
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
              height: size.height / 10,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 12,
                width: size.width / 1.1,
                child: Row(
                  children: [
                    Container(
                      height: size.height / 17,
                      width: size.width / 1.3,
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: "Send Message",
                          suffixIcon: IconButton(
                            onPressed: getImages,
                            icon: Icon(Icons.photo),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        onSendMessage(_messageController.text);
                      },
                      icon: Icon(Icons.send),
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
