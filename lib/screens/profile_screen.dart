import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 21),
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/tnp_coordinators_image.png'),
                  radius: 44,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'Anurag Pola',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'IT',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 11,
          ),
          const ProfileItem(
            icon: Icon(Icons.sticky_note_2_rounded),
            text: "To-Do",
            pageRoute: "toDoListPage",
          ),
          const ProfileItem(
            icon: Icon(Icons.perm_contact_calendar_rounded),
            text: "T&P Coordinators",
            pageRoute: "tnpCoordinatorsPage",
          ),
          const ProfileItem(
            icon: Icon(Icons.remove_red_eye_rounded),
            text: "Status Tracker",
            pageRoute: "statusTrackerPage",
          ),
          const ProfileItem(
            icon: Icon(Icons.star_rounded),
            text: "Off-Campus Form",
            pageRoute: "OffCampusFormPage",
          ),
          const ProfileItem(
            icon: Icon(Icons.chat_bubble_rounded),
            text: "Raise a Ticket",
            pageRoute: "RaiseTicketPage",
          ),
          const ProfileItem(
            icon: Icon(Icons.logout_rounded),
            text: "Log Out",
            pageRoute: "OffCampusFormPage",
          ),
        ],
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final Icon icon;
  final String text;
  final String pageRoute;

  const ProfileItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.pageRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/' + pageRoute);
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
