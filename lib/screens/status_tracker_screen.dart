import 'package:flutter/material.dart';
import '../widgets/slimy_card.dart';
import '../widgets/status_tracker_process_tile.dart';

class StatusTrackerScreen extends StatelessWidget {
  const StatusTrackerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF7F9FC),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: [
            SlimyCard(
              color: Colors.lightBlue.shade100,
              // color: Colors.red,
              width: MediaQuery.of(context).size.width - 40,
              topCardHeight: 200,
              bottomCardHeight: 350,
              borderRadius: 15,
              topCardWidget: const TopWidget(),
              bottomCardWidget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StatusTrackerProcessTimeline(),
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.message_rounded,
                            size: 40,
                          ),
                          color: Colors.green,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.business_rounded,
                            size: 40,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit_rounded,
                            size: 40,
                          ),
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              slimeEnabled: true,
            ),
          ],
        ),
      ),
    );
  }
}

class TopWidget extends StatelessWidget {
  const TopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const FlutterLogo(size: 40),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Senior Product Designer",
                    style: TextStyle(
                      color: Color(0xff18191e),
                      fontSize: 16,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3),
                  Opacity(
                    opacity: 0.80,
                    child: Text(
                      "Google",
                      style: TextStyle(
                        color: Color(0xff18191e),
                        fontSize: 12,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: const [
              Chip(
                name: "Next Up : Interview - 28/11/2021",
              ),
            ],
          ),
        ],
      ),
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
        vertical: 15,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5,
      ),
    );
  }
}

class Chip extends StatelessWidget {
  final String name;

  const Chip({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
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
          name,
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: Color(0xff18191e),
            fontSize: 12,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
