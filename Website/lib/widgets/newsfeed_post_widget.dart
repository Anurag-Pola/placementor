import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsfeedPost extends StatefulWidget {
  final DocumentSnapshot post;
  const NewsfeedPost({required this.post, Key? key}) : super(key: key);

  @override
  State<NewsfeedPost> createState() => _NewsfeedPostState();
}

class _NewsfeedPostState extends State<NewsfeedPost> {
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
    Map<String, dynamic> postData = widget.post.data() as Map<String, dynamic>;
    return Container(
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
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Posted By: ${postData['postedBy']}",
              style: const TextStyle(fontSize: 12, color: Colors.green)),
          const SizedBox(height: 5),
          SelectableLinkify(
            text: '${postData['content']}',
            onOpen: _onOpen,
            toolbarOptions: const ToolbarOptions(copy: true, selectAll: true),
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
                          int.parse(postData['timestamp']))),
                  style: const TextStyle(fontSize: 10, color: Colors.grey)),
              TextButton(
                child: Text("Seen Count: ${postData['readBy'].length}",
                    style: const TextStyle(fontSize: 10, color: Colors.grey)),
                onPressed: () {
                  if (postData['readBy'].length != 0) {
                    List seenBy = postData["readBy"]..sort();
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  child: Text('Seen By'),
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
                                  itemCount: seenBy.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      title: Text(
                                        seenBy[index],
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
                },
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete Post'),
                          content: const Text(
                              "Are you sure you want to delete this post?"),
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
                                  await widget.post.reference.delete();
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
