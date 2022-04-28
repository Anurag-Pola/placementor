import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:placementor/Front%20End/widgets/user_functions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsfeedPost extends StatefulWidget {
  final DocumentSnapshot post;
  const NewsfeedPost({required this.post, Key? key}) : super(key: key);

  @override
  State<NewsfeedPost> createState() => _NewsfeedPostState();
}

class _NewsfeedPostState extends State<NewsfeedPost> {
  String? userRollNo;
  Map<String, dynamic>? postData;
  bool? isRead;

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Link Access Error'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Could not launch ${link.url} !'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserRollNo(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            userRollNo = snapshot.data.toString();
            postData = widget.post.data() as Map<String, dynamic>;
            isRead = (postData!['readBy'] as List).contains(userRollNo);
          }
          return !(snapshot.hasData && snapshot.data != null)
              ? Container()
              : Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15.0,
                        offset: Offset(5, 5),
                        color: Colors.black54,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(15),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Posted By: ${postData!['postedBy']}",
                          style: const TextStyle(
                              fontSize: 12, color: Colors.green)),
                      const SizedBox(height: 5),
                      SelectableLinkify(
                        text: '${postData!['content']}',
                        onOpen: _onOpen,
                        toolbarOptions:
                            const ToolbarOptions(copy: true, selectAll: true),
                        // maxLines: 10,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                        linkStyle: const TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          // fontWeight: FontWeight.bold,
                        ),
                        options: const LinkifyOptions(
                          humanize: true,
                          excludeLastPeriod: true,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              DateFormat('dd/MM/yyyy, hh:mm a').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(postData!['timestamp']))),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.grey)),
                          ElevatedButton(
                            onPressed: () {
                              if (isRead!) {
                                return;
                              }
                              FirebaseFirestore.instance
                                  .collection('Newsfeed')
                                  .doc(widget.post.id)
                                  .update({
                                'readBy': FieldValue.arrayUnion([userRollNo])
                              }).then((_) {
                                setState(() {});
                              });
                            },
                            child: Row(
                              children: [
                                Icon(isRead!
                                    ? Icons.check_circle_outline
                                    : Icons.radio_button_checked_rounded),
                                Text(
                                  isRead! ? "Read" : "Mark as Read",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  isRead! ? Colors.grey : Colors.green),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
        });
  }
}

// class NewsfeedPost extends StatelessWidget {
//   const NewsfeedPost({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(15),
//           bottomLeft: Radius.circular(15),
//           bottomRight: Radius.circular(15),
//         ),
//         boxShadow: [
//           BoxShadow(
//             blurRadius: 15.0,
//             offset: Offset(5, 5),
//             color: Colors.black54,
//           ),
//         ],
//         color: Colors.white,
//       ),
//       padding: const EdgeInsets.all(15),
//       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Dear Students,\n\nWe are delighted to kick start our Wiley-mthree Internship Recruitment Program for all Circuit branch students graduating in 2022.\n",
//             style: TextStyle(
//               fontSize: 16,
//             ),
//           ),
//           const SizedBox(height: 5),
//           GestureDetector(
//             child: const Text(
//               "Tap to register!",
//               style: TextStyle(
//                 color: Colors.blue,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onTap: () => launch("https://www.google.com/"),
//           ),
//         ],
//       ),
//     );
//   }
// }
