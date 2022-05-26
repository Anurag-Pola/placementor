import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class OffCampusOpportunitiesScreen extends StatefulWidget {
  const OffCampusOpportunitiesScreen({Key? key}) : super(key: key);

  @override
  State<OffCampusOpportunitiesScreen> createState() =>
      _OffCampusOpportunitiesScreenState();
}

class _OffCampusOpportunitiesScreenState
    extends State<OffCampusOpportunitiesScreen> {
  final Stream<QuerySnapshot> _ticketsStream = FirebaseFirestore.instance
      .collection('offCampusOpportunities')
      .snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _ticketsStream,
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
                const Text(
                  "Off Campus Opportunities",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot document) {
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
                                    Text(data['package'] + " LPA"),
                                  ],
                                ),
                                trailing: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () async {
                                      final url = data['url'];
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      }
                                    },
                                    child: const Icon(
                                      Icons.link_rounded,
                                      color: Colors.blue,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
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
