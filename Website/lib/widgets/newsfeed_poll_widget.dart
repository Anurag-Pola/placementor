import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:placementor_tnp/widgets/lengths.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsfeedPoll extends StatefulWidget {
  final DocumentSnapshot poll;
  const NewsfeedPoll({required this.poll, Key? key}) : super(key: key);

  @override
  State<NewsfeedPoll> createState() => _NewsfeedPollState();
}

class _NewsfeedPollState extends State<NewsfeedPoll> {
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

  int totalVotedCount(Map<String, dynamic> pollOptions) {
    return pollOptions.entries
        .toList()
        .map((e) => e.value['selectedBy']?.length)
        .reduce((a, b) => a + b);
  }

  List totalVotesMap(Map<String, dynamic> pollOptions) {
    List votes = [];
    pollOptions.forEach((k, v) {
      v['selectedBy'].forEach((f) {
        votes.add([f, v['optionText']]);
      });
    });
    votes.sort((a, b) => a[0].compareTo(b[0]));
    return votes;
  }

  Future<dynamic> voterListDialog({var list, String stringType = "Default"}) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Text("Voters' List"),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close_rounded),
                  color: Colors.red,
                  iconSize: 30,
                  padding: const EdgeInsets.all(0),
                  splashRadius: 15,
                ),
              ],
            ),
            content: SizedBox(
              height: 300,
              width: 300,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        stringType == "Default"
                            ? "${list[index]}"
                            : "${list[index][0]} - ${list[index][1]}",
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> pollData = widget.poll.data() as Map<String, dynamic>;
    Map<String, dynamic> pollOptions = pollData['options'];
    int _totalVotedCount = totalVotedCount(pollOptions);
    double _width = width(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen[50],
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Poll By: ${pollData['postedBy']}",
                style: const TextStyle(fontSize: 12, color: Colors.green)),
          ),
          const SizedBox(height: 5),
          SelectableLinkify(
            text: '${pollData['content']}',
            onOpen: _onOpen,
            toolbarOptions: const ToolbarOptions(copy: true, selectAll: true),
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
              Color _color =
                  Colors.primaries[Random().nextInt(Colors.primaries.length)];
              int _selectedByCount = pollOptionData['selectedBy']?.length ?? 0;
              int _selectedByPercentage = _totalVotedCount != 0
                  ? ((_selectedByCount / _totalVotedCount) * 100).toInt()
                  : 0;
              double _coloredBarWidth =
                  _width * 0.5 * (_selectedByPercentage / 100) - 2;
              return Center(
                child: GestureDetector(
                  onTap: () {
                    if (pollOptionData['selectedBy'].length != 0) {
                      List selectedBy = pollOptionData["selectedBy"]..sort();
                      voterListDialog(list: selectedBy);
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: _width * 0.5,
                        height: 40,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(20),
                                color: _color.withOpacity(0.2),
                              ),
                              width:
                                  _coloredBarWidth > 0 ? _coloredBarWidth : 0,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: _width * 0.5,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${pollOptionData['optionText']}',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '$_selectedByPercentage% [$_selectedByCount]',
                              style: TextStyle(
                                fontSize: 12,
                                color: _color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                  style: const TextStyle(fontSize: 10, color: Colors.grey)),
              TextButton(
                child: Text("Votes Count: ${totalVotedCount(pollOptions)}",
                    style: const TextStyle(fontSize: 10, color: Colors.grey)),
                onPressed: () {
                  List votesMap = totalVotesMap(pollOptions);
                  // print(votesMap);
                  if (votesMap.isNotEmpty) {
                    voterListDialog(list: votesMap, stringType: "Map");
                  }
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete Poll'),
                          content: const Text(
                              "Are you sure you want to delete this poll?"),
                          actions: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, bottom: 10),
                              child: ElevatedButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, bottom: 10),
                              child: ElevatedButton(
                                child: const Text('Delete'),
                                onPressed: () async {
                                  await widget.poll.reference.delete();
                                  Navigator.of(context).pop();
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.red,
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(fontSize: 10),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.red,
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
  }
}

// ListView.builder(
//             shrinkWrap: true,
//             itemCount: pollOptions.length,
//             itemBuilder: (context, index) {
//               Map<String, dynamic> pollOptionData =
//                   pollOptions[index] as Map<String, dynamic>;
//               // print(pollOptionData);
//               return GestureDetector(
//                 onTap: () {
//                   if (pollOptionData['selectedBy'].length != 0) {
//                     List selectedBy = pollOptionData["selectedBy"]..sort();
//                     voterListDialog(list: selectedBy);
//                   }
//                 },
//                 child: Container(
//                   width: 200,
//                   margin:
//                       const EdgeInsets.symmetric(vertical: 5, horizontal: 200),
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(20),
//                     color: _isSelected[0] ? Colors.lightBlue : Colors.white,
//                   ),
//                   child: Center(
//                     child: Text(
//                       '${pollOptionData['optionText']}',
//                       style: const TextStyle(
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
