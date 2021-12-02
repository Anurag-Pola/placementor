import 'package:flutter/material.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: ListView(
              children: const [
                ResourceTile(
                  title: "Sample Resumes",
                  icon: Icon(
                    Icons.file_copy_rounded,
                  ),
                ),
                ResourceTile(
                  title: "Sample Video Resumes",
                  icon: Icon(
                    Icons.video_camera_front_rounded,
                  ),
                ),
                ResourceTile(
                  title: "Sample Video Resumes",
                  icon: Icon(
                    Icons.video_camera_front_rounded,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ResourceTile extends StatelessWidget {
  const ResourceTile({required this.title, required this.icon, Key? key})
      : super(key: key);
  final String title;
  final Icon icon;

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
          leading: icon,
          title: Text(
            title,
            style: const TextStyle(
              color: Color(0xff18191e),
              fontSize: 16,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
