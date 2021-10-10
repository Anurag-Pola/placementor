import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF7F9FC),
        // appBar: AppBar(
        //   backgroundColor: const Color(0xFFF7F9FC),
        //   elevation: 0,
        //   leading: IconButton(
        //     icon: const Icon(
        //       Icons.arrow_back_rounded,
        //       color: Colors.black,
        //     ),
        //     onPressed: () {},
        //   ),
        // ),
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 21),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 44,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 11,
            ),
            const ProfileItem(
                icon: Icon(Icons.sticky_note_2_rounded), text: "To-Do"),
            const ProfileItem(
                icon: Icon(Icons.perm_contact_calendar_rounded),
                text: "T&P Coordinators"),
            const ProfileItem(
                icon: Icon(Icons.remove_red_eye_rounded),
                text: "Status Tracker"),
            const ProfileItem(
                icon: Icon(Icons.star_rounded), text: "Off-Campus Form"),
            const ProfileItem(
                icon: Icon(Icons.chat_bubble_rounded), text: "Raise a Ticket"),
            const ProfileItem(
                icon: Icon(Icons.logout_rounded), text: "Log Out"),
          ],
        ));
  }
}

class ProfileItem extends StatelessWidget {
  final Icon icon;
  final String text;

  const ProfileItem({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/OffCampusFormPage');
      },
      child: Container(
        width: 374,
        height: 49,
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
        padding: const EdgeInsets.only(
          left: 24,
        ),
        margin: const EdgeInsets.only(
          top: 10,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 32,
              height: 32,
              child: Stack(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffeeeeee),
                    ),
                    child: icon,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              child: Text(
                text,
                style: const TextStyle(fontFamily: 'Poppins'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
