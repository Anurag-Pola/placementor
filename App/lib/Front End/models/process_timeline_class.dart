class ProcessTimelineClass {
  const ProcessTimelineClass({
    required this.steps,
    required this.names,
    required this.dates,
    required this.descriptions,
  });

  ProcessTimelineClass.fromJson(Map<String, Object?> json)
      : this(
          steps: (json['steps']! as List).toList(),
          names: (json['names']! as List).toList(),
          dates: (json['dates']! as List).toList(),
          descriptions: (json['descriptions']! as List).toList(),
        );

  final List steps;
  final List names;
  final List dates;
  final List descriptions;

  Map<String, Object?> toJson() {
    return {
      'steps': steps,
      'names': names,
      'dates': dates,
      'descriptions': descriptions,
    };
  }
}
