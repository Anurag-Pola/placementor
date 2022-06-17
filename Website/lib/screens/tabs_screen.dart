import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:placementor_tnp/models/custom_user.dart';

class TabsScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _adminsCollection =
      FirebaseFirestore.instance.collection('Admins');

  CustomAdminUser? admin;
  final Map<dynamic, dynamic> _tabsRouteMap = {
    'Companies': '/companies',
    'Tickets': '/tickets',
    'Newsfeed': '/newsfeed',
    'Resources': '/resources',
    'Off Campus Opportunities': '/off-campus-opportunities',
    'T&P Coordinators': '/admins-page',
    'Students': '/students-page'
  };
  Future<bool> getAdminDetailsFetched() async {
    admin = (await _adminsCollection
            .doc(_auth.currentUser!.uid)
            .withConverter<CustomAdminUser>(
              fromFirestore: (snapshot, _) =>
                  CustomAdminUser.fromJSON(snapshot.data()!),
              toFirestore: (coordinator, _) => coordinator.toJson(),
            )
            .get())
        .data();
    return true;
  }

  TabsScreen({Key? key}) : super(key: key);
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.grey.shade50,
          elevation: 0,
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SizedBox(
              height: 40,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Admin Menu Board",
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
        body: Center(
          child: SizedBox(
            width: 2 * width / 3,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3f000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(
                    10,
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 25,
                  ),
                  child: FutureBuilder(
                      future: getAdminDetailsFetched(),
                      builder: (context, snapshot) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              padding: EdgeInsets.only(left: 30, right: 20),
                              child: Image.asset(
                                'assets/images/admin_user.png',
                                scale: 1.5,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    child: Text(
                                      (admin != null && admin!.name != null)
                                          ? admin!.name!
                                          : 'Name',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Chip(
                                      name: (admin != null &&
                                              admin!.department != null)
                                          ? admin!.department!.toUpperCase()
                                          : 'DEPT',
                                    ),
                                    SizedBox(width: 20),
                                    Chip(
                                      name: (admin != null &&
                                              admin!.employeeId != null)
                                          ? admin!.employeeId!.toUpperCase()
                                          : 'EMP ID',
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    (admin != null && admin!.email != null)
                                        ? admin!.email!
                                        : 'Email',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    (admin != null && admin!.phone != null)
                                        ? admin!.phone!
                                        : 'Phone',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: width / 15),
                    child: ListView(
                      children: [
                        ..._tabsRouteMap.entries
                            .map((routeMapEntry) => ListTile(
                                title: Text(routeMapEntry.key),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, routeMapEntry.value);
                                }))
                            .toList(),
                        ListTile(
                            title: const Text("Log Out"),
                            onTap: () async {
                              await auth.signOut();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/', (route) => false);
                            }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class Chip extends StatelessWidget {
  final String? name;

  const Chip({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color(0xfff4f6fc),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Opacity(
        opacity: 0.80,
        child: Text(
          name ?? "",
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: Color(0xff18191e),
            fontSize: 14,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
