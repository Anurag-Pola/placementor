import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../widgets/resource_class.dart';

final firebaseInstance = FirebaseFirestore.instance
    .collection('Resources')
    .withConverter<ResourceClass>(
      fromFirestore: (snapshot, _) => ResourceClass.fromJson(snapshot.data()!),
      toFirestore: (resource, _) => resource.toJson(),
    );

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<ResourceClass>>(
      future: firebaseInstance.get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Text('Something went wrong');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        var options = snapshot.data!.docs.map((doc) => doc.data()).toList();
        print(options);
        return Scaffold(
          backgroundColor: const Color(0xFFF7F9FC),
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: SizedBox(
                  height: 40,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Resources",
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
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => ResourceTile(
                    resource: options[index],
                  ),
                  itemCount: options.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ResourceTile extends StatelessWidget {
  const ResourceTile({required this.resource, Key? key}) : super(key: key);
  final ResourceClass resource;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3f000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 5,
        ),
        child: ListTile(
          leading: const Icon(
            Icons.file_copy_rounded,
          ),
          title: Text(
            resource.title,
            style: const TextStyle(
              color: Color(0xff18191e),
              fontSize: 16,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            resource.description,
            style: const TextStyle(
              color: Color(0xff18191e),
              fontSize: 16,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: () async {
            final url = resource.link;
            if (await canLaunchUrlString(url)) {
              await launchUrlString(url);
            }
          },
        ),
      ),
    );
  }
}
