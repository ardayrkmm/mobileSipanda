class SentimentModel {
  final String comment;
  final String sentiment;
  final String message;

  SentimentModel({
    required this.comment,
    required this.sentiment,
    required this.message,
  });

  // Factory method untuk parsing dari JSON
  factory SentimentModel.fromJson(Map<String, dynamic> json) {
    return SentimentModel(
      comment: json['data']['comment'],
      sentiment: json['data']['sentiment'],
      message: json['message'],
    );
  }

  // Method untuk konversi kembali ke JSON
  Map<String, dynamic> toJson() {
    return {
      'data': {
        'comment': comment,
        'sentiment': sentiment,
      },
      'message': message,
    };
  }
}
