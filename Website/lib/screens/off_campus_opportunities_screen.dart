import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OffCampusOpportunitiesScreen extends StatefulWidget {
  const OffCampusOpportunitiesScreen({Key? key}) : super(key: key);

  @override
  State<OffCampusOpportunitiesScreen> createState() =>
      _OffCampusOpportunitiesScreenState();
}

class _OffCampusOpportunitiesScreenState
    extends State<OffCampusOpportunitiesScreen> {
  final Stream<QuerySnapshot> _offCampusOpportunitiesStream = FirebaseFirestore
      .instance
      .collection('OffCampusOpportunities')
      .snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: SizedBox(
            height: 40,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Off Campus Opportunities",
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
      body: StreamBuilder<QuerySnapshot>(
          stream: _offCampusOpportunitiesStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: snapshot.data!.docs
                        .map(
                          (DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 20,
                              ),
                              child: PhysicalShape(
                                color: Colors.white,
                                elevation: 18,
                                clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(data['companyName']),
                                  subtitle: Column(
                                    children: [
                                      Text(data['roleName']),
                                      const SizedBox(height: 5),
                                      Text(data['package'].toString() + " LPA"),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text("Posted By: ${data['postedBy']}",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.green)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () async {
                                            final url = data['url'];
                                            if (await canLaunchUrlString(url)) {
                                              await launchUrlString(url);
                                            }
                                          },
                                          child: const Icon(
                                            Icons.link_rounded,
                                            color: Colors.blue,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(height: 8),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Colors.red,
                                          ),
                                        ),
                                        child: const Text("Delete"),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title:
                                                    const Text("Are you sure?"),
                                                content: const Text(
                                                    "The information will be lost forever!"),
                                                actions: [
                                                  TextButton(
                                                    child: const Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'OffCampusOpportunities')
                                                          .doc(document.id)
                                                          .delete();
                                                      Navigator.pop(context);
                                                      setState(() {});
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                        .toList()
                        .reversed
                        .toList(),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
