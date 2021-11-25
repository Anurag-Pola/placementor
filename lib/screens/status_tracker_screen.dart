import 'package:flutter/material.dart';
import '../widgets/expansion_panel_custom.dart' as panel;
import '../widgets/status_tracker_process_tile.dart';

class StatusTrackerScreen extends StatefulWidget {
  const StatusTrackerScreen({Key? key}) : super(key: key);

  @override
  State<StatusTrackerScreen> createState() => _StatusTrackerScreenState();
}

class _StatusTrackerScreenState extends State<StatusTrackerScreen> {
  List<String> companiesAppliedList = ["A", "B", "C", "D", "E"];
  List<bool> isOpenList = [];

  @override
  void initState() {
    isOpenList = List.generate(companiesAppliedList.length, (index) => false);
    super.initState();
  }

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
            panel.ExpansionPanelListCustom(
                dividerColor: null,
                expansionCallback: (i, isOpen) => setState(() {
                      for (int j = 0; j < companiesAppliedList.length; j++) {
                        isOpenList[j] = false;
                      }
                      isOpenList[i] = !isOpen;
                    }),
                children:
                    List.generate(companiesAppliedList.length, (index) => index)
                        .map<panel.ExpansionPanelCustom>((e) {
                  return panel.ExpansionPanelCustom(
                    backgroundColor: const Color(0xFFF7F9FC),
                    canTapOnHeader: true,
                    headerBuilder: (context, isOpen) {
                      return const TopWidget();
                    },
                    body: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        StatusTrackerProcessTimeline(),
                        const SizedBox(height: 15),
                        Container(
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.message_rounded,
                                  size: 30,
                                ),
                                // color: Colors.green,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.business_rounded,
                                  size: 30,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit_rounded,
                                  size: 30,
                                ),
                                // color: Colors.yellow,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    isExpanded: isOpenList[e],
                  );
                }).toList()),
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
    return Column(
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
