// import 'package:chatapp/methods.dart';
// import 'package:chatapp/screens/chatroom.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   Map<String, dynamic>? userMap;

//   bool isloading = false;

//   final TextEditingController _search = TextEditingController();

//   FirebaseAuth _auth = FirebaseAuth.instance;
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   String chatRoomId(String user1, String user2) {
//     if (user1[0].toLowerCase().codeUnits[0] >
//         user2.toLowerCase().codeUnits[0]) {
//       return "$user1$user2";
//     } else {
//       return "$user2$user1";
//     }
//   }

// void OnSearch() async {
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   setState(() {
//     isloading = true;
//   });
//   await _firestore
//       .collection('users')
//       .where("email", isEqualTo: _search.text)
//       .get()
//       .then((value) {
//     setState(() {
//       userMap = value.docs[0].data();
//       isloading = false;
//     });
//     print(userMap);
//   });
// }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Home Screen"),
//           actions: [
//             IconButton(
//               onPressed: () => logOut(context),
//               icon: Icon(Icons.logout),
//             ),
//           ],
//         ),
//         body: isloading
//             ? Center(
//                 child: Container(
//                   height: size.height / 20,
//                   width: size.height / 20,
//                   child: CircularProgressIndicator(),
//                 ),
//               )
//             : Column(
//                 children: [
//                   SizedBox(
//                     height: size.height / 20,
//                     // width: size.height,
//                   ),
//                   Container(
//                     height: size.height / 14,
//                     width: size.width,
//                     alignment: Alignment.center,
//                     child: Container(
//                       height: size.height / 14,
//                       width: size.width / 1.15,
//                       child: TextField(
//                         controller: _search,
//                         decoration: InputDecoration(
//                             hintText: "Search",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             )),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: size.height / 30,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       OnSearch();
//                     },
//                     child: Text("Search"),
//                   ),
//                   SizedBox(
//                     height: size.height / 50,
//                   ),
//                   userMap != null
//                       ? ListTile(
//                          onTap: () {},

//                           leading: Icon(
//                             Icons.account_box_outlined,
//                             color: Colors.black,
//                           ),
//                           title: Text(
//                             userMap!['name'],
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           subtitle: Text(
//                             userMap!['email'],
//                           ),
//                           trailing: Icon(
//                             Icons.chat,
//                             color: Colors.black,
//                           ),
//                         )
//                       : Container(),
//                 ],
//               ));
//   }

// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:chatapp/screens/chatroom.dart';
// import 'package:chatapp/methods.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   Map<String, dynamic>? userMap;
//   bool isLoading = false;
//   final TextEditingController _search = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   String chatRoomId(String user1, String user2) {
//     if (user1[0].toLowerCase().codeUnits[0] >
//         user2.toLowerCase().codeUnits[0]) {
//       return "$user1$user2";
//     } else {
//       return "$user2$user1";
//     }
//   }

//   Future<void> onSearch() async {
//     setState(() {
//       isLoading = true;
//     });

//     QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
//         .collection('users')
//         .where("email", isEqualTo: _search.text)
//         .limit(1)
//         .get();

//     if (snapshot.docs.isNotEmpty) {
//       setState(() {
//         userMap = snapshot.docs[0].data();
//         isLoading = false;
//       });
//       print(userMap);
//     } else {
//       setState(() {
//         userMap = null;
//         isLoading = false;
//       });
//       print('User not found!');
//     }
//   }

//   void onUserTap() {
//     if (userMap != null) {
//       String currentUserEmail = _auth.currentUser?.email ?? '';
//       String chatRoom = chatRoomId(currentUserEmail, userMap!['email']);
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ChatRoomScreen(
//             chatRoomId: chatRoom,
//             currentUserEmail: currentUserEmail,
//             otherUserEmail: userMap!['email'],
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home Screen"),
//         actions: [
//           IconButton(
//             onPressed: () => logOut(context),
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: isLoading
//           ? Center(
//               child: Container(
//                 height: size.height / 20,
//                 width: size.height / 20,
//                 child: const CircularProgressIndicator(),
//               ),
//             )
//           : Column(
//               children: [
//                 SizedBox(
//                   height: size.height / 20,
//                 ),
//                 Container(
//                   height: size.height / 14,
//                   width: size.width,
//                   alignment: Alignment.center,
//                   child: Container(
//                     height: size.height / 14,
//                     width: size.width / 1.15,
//                     child: TextField(
//                       controller: _search,
//                       decoration: InputDecoration(
//                         hintText: "Search",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: size.height / 30,
//                 ),
//                 ElevatedButton(
//                   onPressed: onSearch,
//                   child: const Text("Search"),
//                 ),
//                 SizedBox(
//                   height: size.height / 50,
//                 ),
//                 if (userMap != null)
//                   ListTile(
//                     onTap: onUserTap,
//                     leading: const Icon(
//                       Icons.account_box_outlined,
//                       color: Colors.black,
//                     ),
//                     title: Text(
//                       userMap!['name'],
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     subtitle: Text(
//                       userMap!['email'],
//                     ),
//                     trailing: const Icon(
//                       Icons.chat,
//                       color: Colors.black,
//                     ),
//                   ),
//               ],
//             ),
//     );
//   }
// }

// import 'package:chatapp/methods.dart';
// import 'package:flutter/material.dart';
// import 'package:chatapp/screens/chatroom.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   Map<String, dynamic>? userMap;

//   bool isLoading = false;

//   final TextEditingController _search = TextEditingController();

//   String chatRoomId(String user1, String user2) {
//     if (user1[0].toLowerCase().codeUnits[0] >
//         user2.toLowerCase().codeUnits[0]) {
//       return "$user1$user2";
//     } else {
//       return "$user2$user1";
//     }
//   }

//   void onSearch() async {
//     setState(() {
//       isLoading = true;
//     });

//     // Simulating an asynchronous search
//     await Future.delayed(Duration(seconds: 2));

//     setState(() {
//       // Simulated userMap data
//       userMap = {
//         'name': 'Other User',
//         'email': _search.text,
//       };

//       isLoading = false;
//     });
//   }

//   void openChatRoom() {
//     if (userMap != null) {
//       String roomId = chatRoomId(
//         'current_user_email',
//         userMap!['email'],
//       );

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ChatRoomScreen(
//             chatRoomId: roomId,
//             currentUserEmail: 'current_user_email',
//             otherUserEmail: userMap!['email'],
//             userMap: userMap!,
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home Screen"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               // Implement the logOut function
//               logOut(context);
//             },
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: isLoading
//           ? Center(
//               child: Container(
//                 height: size.height / 20,
//                 width: size.height / 20,
//                 child: const CircularProgressIndicator(),
//               ),
//             )
//           : Column(
//               children: [
//                 SizedBox(
//                   height: size.height / 20,
//                 ),
//                 Container(
//                   height: size.height / 14,
//                   width: size.width,
//                   alignment: Alignment.center,
//                   child: Container(
//                     height: size.height / 14,
//                     width: size.width / 1.15,
//                     child: TextField(
//                       controller: _search,
//                       decoration: const InputDecoration(
//                         hintText: "Search",
//                         border: OutlineInputBorder(
//                             // borderRadius: BorderRadius.circular(10),
//                             ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: size.height / 30,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     onSearch();
//                   },
//                   child: const Text("Search"),
//                 ),
//                 SizedBox(
//                   height: size.height / 50,
//                 ),
//                 if (userMap != null)
//                   ListTile(
//                     onTap: openChatRoom,
//                     leading: const Icon(
//                       Icons.account_box_outlined,
//                       color: Colors.black,
//                     ),
//                     title: Text(
//                       userMap!['name'],
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     subtitle: Text(
//                       userMap!['email'],
//                     ),
//                     trailing: const Icon(
//                       Icons.chat,
//                       color: Colors.black,
//                     ),
//                   ),
//               ],
//             ),
//     );
//   }
// }

// import 'package:chatapp/methods.dart';
// import 'package:flutter/material.dart';
// import 'package:chatapp/screens/chatroom.dart';

// class HomeScreen extends StatefulWidget {
//   final String currentUserEmail;

//   const HomeScreen({Key? key, required this.currentUserEmail}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   Map<String, dynamic>? userMap;

//    List<Map<String, dynamic>> chatList = [];

//   bool isLoading = false;

//   final TextEditingController _search = TextEditingController();

//   String chatRoomId(String user1, String user2) {
//     if (user1[0].toLowerCase().codeUnits[0] >
//         user2.toLowerCase().codeUnits[0]) {
//       return "$user1$user2";
//     } else {
//       return "$user2$user1";
//     }
//   }

//   void onSearch() async {
//     setState(() {
//       isLoading = true;
//     });

//     // Simulating an asynchronous search
//     await Future.delayed(Duration(seconds: 2));

//     setState(() {
//       // Simulated userMap data
//       userMap = {
//         'name': 'Other User',
//         'email': _search.text,
//       };

//       isLoading = false;
//     });
//   }

//   void openChatRoom() {
//     if (userMap != null) {
//       String roomId = chatRoomId(
//         widget.currentUserEmail,
//         userMap!['email'],
//       );

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ChatRoomScreen(
//             chatRoomId: roomId,
//             currentUserEmail: widget.currentUserEmail,
//             otherUserEmail: userMap!['email'],
//             userMap: userMap!,
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home Screen"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               // Implement the logOut function
//               logOut(context);
//             },
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: isLoading
//           ? Center(
//               child: Container(
//                 height: size.height / 20,
//                 width: size.height / 20,
//                 child: const CircularProgressIndicator(),
//               ),
//             )
//           : Column(
//               children: [
//                 SizedBox(
//                   height: size.height / 20,
//                 ),
//                 Container(
//                   height: size.height / 14,
//                   width: size.width,
//                   alignment: Alignment.center,
//                   child: Container(
//                     height: size.height / 14,
//                     width: size.width / 1.15,
//                     child: TextField(
//                       controller: _search,
//                       decoration: const InputDecoration(
//                         hintText: "Search",
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: size.height / 30,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     onSearch();
//                   },
//                   child: const Text("Search"),
//                 ),
//                 SizedBox(
//                   height: size.height / 50,
//                 ),
//                 if (userMap != null)
//                   ListTile(
//                     onTap: openChatRoom,
//                     leading: const Icon(
//                       Icons.account_box_outlined,
//                       color: Colors.black,
//                     ),
//                     title: Text(
//                       userMap!['name'],
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     subtitle: Text(
//                       userMap!['email'],
//                     ),
//                     trailing: const Icon(
//                       Icons.chat,
//                       color: Colors.black,
//                     ),
//                   ),
//               ],
//             ),
//     );
//   }
// }

import 'package:chatapp/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/screens/chatroom.dart';

class HomeScreen extends StatefulWidget {
  final String currentUserEmail;

  const HomeScreen({Key? key, required this.currentUserEmail})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  List<Map<String, dynamic>> searchResults = []; // List to store search results
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //Online
      setStatus("online");
    } else {
      //Offline
      setStatus("Offline");
    }
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  // void onSearch() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   // Simulating an asynchronous search
  //   await Future.delayed(Duration(seconds: 2));

  //   setState(() {
  //     // Simulated search result
  //     final Map<String, dynamic> userMap = {
  //       'name': 'Other User',
  //       'email': _search.text,
  //     };

  //     // Add the userMap to the beginning of the searchResults list
  //     searchResults.insert(0, userMap);

  //     isLoading = false;
  //   });
  // }

void onSearch() async {
  setState(() {
    isLoading = true;
  });

  // Simulating an asynchronous search
  await Future.delayed(Duration(seconds: 2));

  // Perform the search in the database based on the searched email
  final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
      .collection('users')
      .where('email', isEqualTo: _search.text)
      .get();

  setState(() {
    searchResults.clear();

    if (querySnapshot.size > 0) {
      // Retrieve the name from the search result and add it to the searchResults list
      final Map<String, dynamic> userMap = querySnapshot.docs[0].data();
      searchResults.insert(0, userMap);
    }

    isLoading = false;
  });
}

  void openChatRoom(Map<String, dynamic> userMap) {
    String roomId = chatRoomId(
      widget.currentUserEmail,
      userMap['email'],
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatRoomScreen(
          chatRoomId: roomId,
          currentUserEmail: widget.currentUserEmail,
          otherUserEmail: userMap['email'],
          userMap: userMap,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: () {
              // Implement the logOut function
              logOut(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: const CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: size.height / 20,
                ),
                Container(
                  height: size.height / 14,
                  width: size.width,
                  alignment: Alignment.center,
                  child: Container(
                    height: size.height / 14,
                    width: size.width / 1.15,
                    child: TextField(
                      controller: _search,
                      decoration: const InputDecoration(
                        hintText: "Search",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    onSearch();
                  },
                  child: const Text("Search"),
                ),
                SizedBox(
                  height: size.height / 50,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
  final userMap = searchResults[index];
  return ListTile(
    onTap: () => openChatRoom(userMap),
    leading: const Icon(
      Icons.account_box_outlined,
      color: Colors.black,
    ),
    title: Text(
      userMap['name'] ?? 'Name not found',
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Text(
      userMap['email'],
    ),
    trailing: const Icon(
      Icons.chat,
      color: Colors.black,
    ),
  );
},
                  ),
                ),
              ],
            ),
    );
  }
}
