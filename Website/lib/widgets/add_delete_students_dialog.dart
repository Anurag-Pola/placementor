import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/custom_user.dart';
import 'manage_users_functions.dart';

Future<dynamic> addDeleteStudentsDailog(
    BuildContext context,
    CollectionReference metadataCollectionRef,
    CollectionReference studentDataCollectionRef,
    String action) async {
  QuerySnapshot metadataQuerySnapshot = await metadataCollectionRef.get();
  List<Map<String, dynamic>> actionSummary = [];

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunchUrlString(link.url)) {
      await launchUrlString(link.url);
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
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

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child:
                    Text("${action == "create" ? "Add" : "Delete"} Students"),
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
          content: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding:
                const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "${action == "create" ? "Adding" : "Deleting"} Students from the Google Sheet :",
                    style: const TextStyle(fontSize: 14, color: Colors.green)),
                const SizedBox(
                  height: 20,
                ),
                SelectableLinkify(
                  text: metadataQuerySnapshot.docs
                      .firstWhere((element) => element.id == "SheetsUrl")
                      .get(action == "create" ? "createUsers" : "deleteUsers")
                      .toString(),
                  onOpen: _onOpen,
                  toolbarOptions:
                      const ToolbarOptions(copy: true, selectAll: true),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  linkStyle: const TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    decoration: TextDecoration.none,
                  ),
                  options: const LinkifyOptions(
                    humanize: true,
                    excludeLastPeriod: true,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25, bottom: 25),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                  backgroundColor: MaterialStateProperty.all(
                      action == "create" ? Colors.green : Colors.red),
                ),
                onPressed: () async {
                  if (actionSummary.isEmpty) {
                    Map<String, dynamic> actionResponseMap = action == "create"
                        ? await registerStudentWithEmailPassword(
                            metadataQuerySnapshot, studentDataCollectionRef)
                        : await deleteStudentWithEmail(
                            metadataQuerySnapshot, studentDataCollectionRef);
                    Navigator.of(context).pop(actionResponseMap);
                  }
                },
                icon: Icon(
                    action == "create"
                        ? Icons.group_add
                        : Icons.group_remove_rounded,
                    size: 25),
                label: Text(action == "create" ? "Create" : "Delete",
                    style: const TextStyle(fontSize: 16)),
              ),
            ),
          ],
        );
      });
}

Future<dynamic> showActionSummaryDialog(
    BuildContext context, List<dynamic> actionSummary) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Text("Action Summary"),
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
          content: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
              child: SingleChildScrollView(
                child: Table(
                    border: TableBorder.all(color: Colors.black),
                    children: [
                      TableRow(
                          children: [
                        "Student Name",
                        "Student Email",
                        "Action Status",
                        "More Info"
                      ]
                              .map((e) => TableCell(
                                      child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Text(e,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )))
                              .toList()),
                      ...actionSummary
                          .map((e) => TableRow(
                                children: [
                                  TableCell(
                                      child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                          (e["user"] as CustomStudentUser)
                                              .name!,
                                          style: const TextStyle(fontSize: 12)),
                                    ),
                                  )),
                                  TableCell(
                                      child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                          (e["user"] as CustomStudentUser)
                                              .email,
                                          style: const TextStyle(fontSize: 12)),
                                    ),
                                  )),
                                  TableCell(
                                      child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(e["status"],
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: e["status"] == "SUCCESS"
                                                  ? Colors.green
                                                  : Colors.red)),
                                    ),
                                  )),
                                  e["status"] == "SUCCESS"
                                      ? const TableCell(child: SizedBox())
                                      : TableCell(
                                          child: Center(
                                          child: IconButton(
                                            icon: const Icon(
                                                Icons.info_outline_rounded),
                                            onPressed: () async {
                                              await showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      title: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "ERROR",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          IconButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            icon: const Icon(Icons
                                                                .close_rounded),
                                                            color: Colors.red,
                                                            iconSize: 20,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            splashRadius: 15,
                                                          ),
                                                        ],
                                                      ),
                                                      content: Text(e["body"]
                                                          .toString()));
                                                },
                                              );
                                            },
                                          ),
                                        )),
                                ],
                              ))
                          .toList()
                    ]),
              )),
        );
      });
}
