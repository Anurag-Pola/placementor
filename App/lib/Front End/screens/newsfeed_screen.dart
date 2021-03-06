import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/newsfeed_poll_widget.dart';
import '../widgets/newsfeed_post_widget.dart';

class NewsfeedScreen extends StatefulWidget {
  const NewsfeedScreen({Key? key}) : super(key: key);

  @override
  State<NewsfeedScreen> createState() => _NewsfeedScreenState();
}

class _NewsfeedScreenState extends State<NewsfeedScreen> {
  StreamController? _controller;
  StreamSubscription<QuerySnapshot>? _subscribedData;

  @override
  void initState() {
    _controller = StreamController<QuerySnapshot>();

    _subscribedData = FirebaseFirestore.instance
        .collection("Newsfeed")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .listen((data) {
      _controller?.add(data);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _controller!.stream,
        builder: (context, AsyncSnapshot snapshot) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Colors.blue.shade100,
              elevation: 0,
              title: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: SizedBox(
                  height: 40,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "T&P NewsFeed",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.blue.shade100,
            body: Column(
              children: [
                !snapshot.hasData && !snapshot.hasError
                    ? const Center(child: CircularProgressIndicator())
                    : snapshot.hasError
                        ? Center(
                            child: SelectableText("Error : ${snapshot.error}",
                                style: const TextStyle(color: Colors.red)))
                        : Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  final feed = snapshot.data.docs[index];
                                  // print("${feed.data()}");
                                  return feed["type"] == "post"
                                      ? NewsfeedPost(post: feed)
                                      : NewsfeedPoll(poll: feed);
                                }),
                          ),
              ],
            ),
          );
        });
  }
}


// class NewsfeedScreen extends StatelessWidget {
//   const NewsfeedScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F9FC),
//       body: Column(
//         children: [
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//             child: SizedBox(
//               height: 40,
//               child: Align(
//                 alignment: Alignment.center,
//                 child: Text(
//                   "T&P NewsFeed",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 30,
//                     fontFamily: "Poppins",
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               children: const [
//                 NewsfeedPost(),
//                 NewsfeedPoll(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
