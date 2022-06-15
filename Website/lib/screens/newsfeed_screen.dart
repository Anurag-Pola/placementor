import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:placementor_tnp/widgets/create_poll_widget.dart';

import '../widgets/create_post_widget.dart';
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
            automaticallyImplyLeading: false,
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
          floatingActionButton: SpeedDial(
            icon: Icons.add,
            activeIcon: Icons.close,
            spacing: 3,
            childPadding: const EdgeInsets.all(5),
            spaceBetweenChildren: 4,
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            heroTag: 'speed-dial-hero-tag',
            elevation: 8.0,
            children: [
              SpeedDialChild(
                  child: const Icon(Icons.post_add_rounded),
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  label: 'Create a Post',
                  onTap: () async {
                    _subscribedData?.pause();
                    await createPostWidget(context);
                    _subscribedData?.resume();
                  }),
              SpeedDialChild(
                  child: const Icon(Icons.add_chart_rounded),
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  label: 'Create a Poll',
                  onTap: () async {
                    _subscribedData?.pause();
                    await createPollWidget(context);
                    _subscribedData?.resume();
                  }),
            ],
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
                      // : !(snapshot.data!.exists)
                      //     ? const Center(child: Text("No posts yet :("))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              final feed = snapshot.data.docs[index];
                              // print("${feed.data()}");
                              return feed["type"] == "post"
                                  ? NewsfeedPost(post: feed)
                                  : NewsfeedPoll(poll: feed);
                            },
                          ),
                        ),
            ],
          ),
        );
      },
    );
  }
}
