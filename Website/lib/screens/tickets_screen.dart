import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  final Stream<QuerySnapshot> _ticketsStream = FirebaseFirestore.instance
      .collection('Tickets')
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
                  "Tickets",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                              child: ListTile(
                                title: Text(data['title']),
                                subtitle: Text(data['description']),
                                trailing: ElevatedButton(
                                  child: const Text("Resolved"),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Are you sure?"),
                                            content: const Text(
                                                "This ticket will be deleted permanently as it is resolved!"),
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
                                                      .collection('Tickets')
                                                      .doc(document.id)
                                                      .delete();
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                ),
                              ),
                              clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
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
