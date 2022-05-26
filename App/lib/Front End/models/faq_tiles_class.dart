class FAQTilesClass {
  const FAQTilesClass({
    required this.question,
    required this.answer,
    required this.timestamp,
  });

  FAQTilesClass.fromJson(Map<String, Object?> json)
      : this(
          question: json['question']! as String,
          answer: json['answer']! as String,
          timestamp: json['timestamp']! as String,
        );

  final String question;
  final String answer;
  final String timestamp;

  Map<String, Object?> toJson() {
    return {
      'question': question,
      'answer': answer,
      'timestamp': timestamp,
    };
  }
}
