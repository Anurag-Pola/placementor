import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../widgets/resource_class.dart';

final firebaseInstance = FirebaseFirestore.instance
    .collection('Resources')
    .withConverter<ResourceClass>(
      fromFirestore: (snapshot, _) => ResourceClass.fromJson(snapshot.data()!),
      toFirestore: (resource, _) => resource.toJson(),
    );

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({Key? key}) : super(key: key);

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  List<ResourceClass> options = [];
  final TextStyle textStyle = const TextStyle(
    color: Color(0xff252b42),
    fontSize: 14,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w600,
  );

  final InputDecoration textFormFieldDecoration = const InputDecoration(
    errorStyle: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w100,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(
        color: Color(0xffe5e5e5),
        width: 1,
      ),
    ),
    contentPadding: EdgeInsets.all(18),
    fillColor: Color(0xfff8f8f8),
  );

  @override
  Widget build(BuildContext context) {
    List<Widget> optionsContent = [];

    return FutureBuilder<QuerySnapshot<ResourceClass>>(
      future: firebaseInstance.get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Text('Something went wrong');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        options = snapshot.data!.docs.map((doc) => doc.data()).toList();
        for (var option in options) {
          optionsContent.add(
            Option(
              resource: option,
              func: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Are you sure?"),
                    content: const Text(
                        "This will permanently delete the resource."),
                    actions: [
                      TextButton(
                        child: const Text("Cancel"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          firebaseInstance.doc(option.timestamp).delete();
                          options.remove(option);
                          Navigator.pop(context);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
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
          ),
          body: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      childAspectRatio: 1.4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemBuilder: (context, index) => optionsContent[index],
                  itemCount: optionsContent.length,
                ),
              ),
            ],
          ),
          floatingActionButton: Container(
            margin: const EdgeInsets.all(10),
            height: 50.0,
            width: 50.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x3f000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xff925ffc),
                  Color(0xff3b57ff),
                ],
              ),
            ),
            child: InkWell(
              onTap: () {
                showDialog(context: context, builder: resourcesDialog);
              },
              child: const Center(
                child: Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  AlertDialog resourcesDialog(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController =
        TextEditingController();
    final TextEditingController _linkController = TextEditingController();

    return AlertDialog(
      title: const Text("Add"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add a new Resource",
            style: textStyle,
          ),
          TextFormField(
            decoration: textFormFieldDecoration.copyWith(hintText: "Title"),
            autocorrect: true,
            controller: _titleController,
          ),
          TextFormField(
            decoration:
                textFormFieldDecoration.copyWith(hintText: "Description"),
            autocorrect: true,
            controller: _descriptionController,
          ),
          TextFormField(
            decoration: textFormFieldDecoration.copyWith(hintText: "Link"),
            autocorrect: true,
            controller: _linkController,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text(
            "Add",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          onPressed: () {
            if (_titleController.text != '' && _linkController.text != '') {
              final resource = ResourceClass.fromJson({
                "title": _titleController.text,
                "description": _descriptionController.text,
                "link": _linkController.text,
                "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
              });
              options.add(resource);

              firebaseInstance.doc(resource.timestamp).set(resource);
              _titleController.text = '';
              _descriptionController.text = '';
              _linkController.text = '';
              Navigator.pop(context);
              setState(() {});
            }
          },
        ),
        TextButton(
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

class Option extends StatelessWidget {
  const Option({
    Key? key,
    required this.resource,
    required this.func,
  }) : super(key: key);

  final ResourceClass resource;
  final Function func;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  resource.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  resource.description,
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
          // Flexible(
          //   child: ListTile(
          //     title: Text(
          //       resource.title,
          //     ),
          //     subtitle: Text(
          //       resource.description,
          //     ),
          //   ),
          // ),
          const SizedBox(width: 4),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    func();
                  },
                  child: const Icon(
                    Icons.delete_rounded,
                    color: Colors.red,
                    size: 25,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    final url = resource.link;
                    if (await canLaunchUrlString(url)) {
                      await launchUrlString(url);
                    }
                  },
                  child: const Icon(
                    Icons.link_rounded,
                    color: Colors.blue,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(4),
    );
  }
}
