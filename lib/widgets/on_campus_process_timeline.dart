import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ProcessTimeline extends StatelessWidget {
  final steps = [1, 2, 3, 4];
  final names = ["Application", "Online Test", "Interview", "Results"];
  final dates = ["28/11/20", "28/11/20", "28/11/20", "28/11/20"];
  final descriptions = [
    "The application is to be done from the provided URL",
    "A test is put on HackerRank platform which consists of 30 aptitude and 2 coding questions with a timeframe of 1 hour ",
    "An interiew is conducted for 1 hour which consists of technical,managerial and hr related questions",
    "Voila You got the job",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              isFirst: true,
              indicatorStyle: _indicatorStyle(0),
              afterLineStyle: _lineStyle(),
              endChild: Content(
                names: names,
                i: 0,
                descriptions: descriptions,
                dates: dates,
              ),
            ),
            for (var i = 1; i < steps.length - 1; i++)
              TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.1,
                indicatorStyle: _indicatorStyle(i),
                beforeLineStyle: _lineStyle(),
                afterLineStyle: _lineStyle(),
                endChild: Content(
                  names: names,
                  i: i,
                  descriptions: descriptions,
                  dates: dates,
                ),
              ),
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              isLast: true,
              indicatorStyle: _indicatorStyle(steps.length - 1),
              beforeLineStyle: _lineStyle(),
              endChild: Content(
                names: names,
                i: names.length - 1,
                descriptions: descriptions,
                dates: dates,
              ),
            )
          ],
        ),
      ),
    );
  }

  LineStyle _lineStyle() => const LineStyle(
        color: Color(0xFF738DED),
        thickness: 3,
      );

  IndicatorStyle _indicatorStyle(int i) {
    return IndicatorStyle(
      width: 32,
      height: 32,
      indicator: CircleAvatar(
        backgroundColor: const Color(0xFF738DED),
        child: Text(
          steps[i].toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    Key? key,
    required this.names,
    required this.i,
    required this.descriptions,
    required this.dates,
  }) : super(key: key);

  final List<String> names;
  final int i;
  final List<String> descriptions;
  final List<String> dates;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 10, top: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            names[i],
            style: const TextStyle(
              color: Color(0xff333333),
              fontFamily: "Poppins",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            dates[i],
            style: const TextStyle(
              color: Color(0xff333333),
              fontFamily: "Poppins",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            descriptions[i],
            style: const TextStyle(
              color: Color(0xff888888),
              fontFamily: "Poppins",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
