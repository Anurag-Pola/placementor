import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
                  "My Profile",
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
            margin: const EdgeInsets.only(
              bottom: 10,
              left: 10,
              right: 10,
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 21),
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/tnp_coordinators_image.png'),
                    radius: 44,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Anurag Pola',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '18071A1266',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 11,
          ),
          ProfileItem(
            icon: const Icon(Icons.sticky_note_2_rounded),
            text: "To-Do",
            action: () {
              Navigator.pushNamed(context, '/' + "toDoListPage");
            },
          ),
          ProfileItem(
            icon: const Icon(Icons.perm_contact_calendar_rounded),
            text: "T&P Coordinators",
            action: () {
              Navigator.pushNamed(context, '/' + "tnpCoordinatorsPage");
            },
          ),
          ProfileItem(
            icon: const Icon(Icons.remove_red_eye_rounded),
            text: "Status Tracker",
            action: () {
              Navigator.pushNamed(context, '/' + "statusTrackerPage");
            },
          ),
          ProfileItem(
            icon: const Icon(Icons.star_rounded),
            text: "Off-Campus Form",
            action: () {
              Navigator.pushNamed(context, '/' + "OffCampusFormPage");
            },
          ),
          ProfileItem(
            icon: const Icon(Icons.chat_bubble_rounded),
            text: "Raise a Ticket",
            action: () {
              Navigator.pushNamed(context, '/' + "RaiseTicketPage");
            },
          ),
          ProfileItem(
            icon: const Icon(Icons.logout_rounded),
            text: "Log Out",
            action: () {
              Navigator.popAndPushNamed(context, '/' + "loginPage");
            },
          ),
        ],
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final Icon icon;
  final String text;
  final Function action;

  const ProfileItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        action();
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
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffeeeeee),
                ),
                child: icon,
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
