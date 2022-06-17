import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import './process_timeline_class.dart';

class ProcessTimeline extends StatelessWidget {
  const ProcessTimeline({
    Key? key,
    required this.processTimeline,
  }) : super(key: key);

  final ProcessTimelineClass processTimeline;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Opacity(
              opacity: 0.75,
              child: Text(
                "PROCESS TIMELINE",
                style: TextStyle(
                  color: Color(0xff18191e),
                  fontSize: 13,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.75,
                ),
              ),
            ),
          ),
          Expanded(
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
                      names: processTimeline.names,
                      i: 0,
                      descriptions: processTimeline.descriptions,
                      dates: processTimeline.dates,
                    ),
                  ),
                  for (var i = 1; i < processTimeline.steps.length - 1; i++)
                    TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineXY: 0.1,
                      indicatorStyle: _indicatorStyle(i),
                      beforeLineStyle: _lineStyle(),
                      afterLineStyle: _lineStyle(),
                      endChild: Content(
                        names: processTimeline.names,
                        i: i,
                        descriptions: processTimeline.descriptions,
                        dates: processTimeline.dates,
                      ),
                    ),
                  TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: 0.1,
                    isLast: true,
                    indicatorStyle:
                        _indicatorStyle(processTimeline.steps.length - 1),
                    beforeLineStyle: _lineStyle(),
                    endChild: Content(
                      names: processTimeline.names,
                      i: processTimeline.names.length - 1,
                      descriptions: processTimeline.descriptions,
                      dates: processTimeline.dates,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
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
          processTimeline.steps[i].toString(),
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

  final List names;
  final int i;
  final List descriptions;
  final List dates;

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
