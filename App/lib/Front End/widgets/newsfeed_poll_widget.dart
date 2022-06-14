import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:placementor/Front%20End/widgets/user_functions.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsfeedPoll extends StatefulWidget {
  final DocumentSnapshot poll;
  const NewsfeedPoll({required this.poll, Key? key}) : super(key: key);

  @override
  State<NewsfeedPoll> createState() => _NewsfeedPollState();
}

class _NewsfeedPollState extends State<NewsfeedPoll> {
  String? userRollNo;
  bool isVoted = true;
  String optionSelectedKey = '-1';

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunchUrlString(link.url)) {
      await launchUrlString(link.url);
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

  bool checkIfAlreadyVoted(Map<String, dynamic> pollOptions) {
    String result = '-1';
    pollOptions.entries.toList().forEach((e) {
      if (e.value["selectedBy"].contains(userRollNo)) {
        result = e.key;
      }
    });

    if (result != '-1') {
      optionSelectedKey = result;
    }
    return result != '-1';
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> pollData = widget.poll.data() as Map<String, dynamic>;
    Map<String, dynamic> pollOptions = pollData["options"];

    return FutureBuilder(
        future: getUserRollNo(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            userRollNo = snapshot.data.toString();
            isVoted = checkIfAlreadyVoted(pollOptions);
          }
          return !(snapshot.hasData && snapshot.data != null)
              ? Container()
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.lightGreen[50],
                  ),
                  padding: const EdgeInsets.all(15),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Poll By: ${pollData['postedBy']}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.green)),
                      ),
                      const SizedBox(height: 5),
                      SelectableLinkify(
                        text: '${pollData['content']}',
                        onOpen: _onOpen,
                        toolbarOptions:
                            const ToolbarOptions(copy: true, selectAll: true),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        linkStyle: const TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                        ),
                        options: const LinkifyOptions(
                          humanize: true,
                          excludeLastPeriod: true,
                        ),
                      ),
                      const SizedBox(height: 5),
                      ListView(
                        shrinkWrap: true,
                        children: pollOptions.entries.toList().map((e) {
                          Map<String, dynamic> pollOptionData =
                              e.value as Map<String, dynamic>;
                          return GestureDetector(
                            onTap: () {
                              if (isVoted) {
                              } else {
                                setState(() {
                                  optionSelectedKey = e.key;
                                });
                              }
                            },
                            child: Container(
                              width: 200,
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                                color: optionSelectedKey == e.key
                                    ? Colors.green
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  '${pollOptionData['optionText']}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              DateFormat('dd/MM/yyyy, hh:mm a').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(pollData['timestamp']))),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.grey)),
                          ElevatedButton(
                            onPressed: () async {
                              if (isVoted) {
                                return;
                              }
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Vote'),
                                      content: const Text(
                                          "Are you sure you want vote for the option?"),
                                      actions: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          child: ElevatedButton(
                                            child: const Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          child: ElevatedButton(
                                            child: const Text('Vote'),
                                            onPressed: () async {
                                              FirebaseFirestore.instance
                                                  .collection('Newsfeed')
                                                  .doc(widget.poll.id)
                                                  .update({
                                                'options.$optionSelectedKey.selectedBy':
                                                    FieldValue.arrayUnion(
                                                        [userRollNo])
                                              }).then((_) {
                                                Navigator.of(context).pop();
                                              });
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                Colors.green,
                                              ),
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Text(
                              isVoted ? 'Voted' : 'Vote',
                              style: const TextStyle(fontSize: 10),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                isVoted ? Colors.grey : Colors.green,
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.white,
                              ),
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


// class NewsfeedPoll extends StatefulWidget {
//   const NewsfeedPoll({Key? key}) : super(key: key);

//   @override
//   State<NewsfeedPoll> createState() => _NewsfeedPollState();
// }

// class _NewsfeedPollState extends State<NewsfeedPoll> {
//   final List<bool> _isSelected = [false, false, false];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.blue.shade100,
//       child: Column(
//         children: [
//           const SizedBox(height: 20),
//           const Text(
//             'Did you register for Wiley-mthree?',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),
//           const SizedBox(height: 20),
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 if (_isSelected.contains(true)) {
//                   for (int i = 0; i < _isSelected.length; i++) {
//                     _isSelected[i] = false;
//                   }
//                 }
//                 _isSelected[0] = !_isSelected[0];
//               });
//             },
//             child: Container(
//               width: 200,
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(20),
//                 color: _isSelected[0] ? Colors.lightBlue : Colors.white,
//               ),
//               child: const Center(
//                 child: Text(
//                   'Yes, Registered!',
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 5),
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 if (_isSelected.contains(true)) {
//                   for (int i = 0; i < _isSelected.length; i++) {
//                     _isSelected[i] = false;
//                   }
//                 }
//                 _isSelected[1] = !_isSelected[1];
//               });
//             },
//             child: Container(
//               width: 200,
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(20),
//                 color: _isSelected[1] ? Colors.lightBlue : Colors.white,
//               ),
//               child: const Center(
//                 child: Text(
//                   "I'll register now.",
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 5),
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 if (_isSelected.contains(true)) {
//                   for (int i = 0; i < _isSelected.length; i++) {
//                     _isSelected[i] = false;
//                   }
//                 }
//                 _isSelected[2] = !_isSelected[2];
//               });
//             },
//             child: Container(
//               width: 200,
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(20),
//                 color: _isSelected[2] ? Colors.lightBlue : Colors.white,
//               ),
//               child: const Center(
//                 child: Text(
//                   'No, I have other plans.',
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }