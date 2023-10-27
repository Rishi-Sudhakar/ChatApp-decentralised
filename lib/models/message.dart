class Message {
  final String text;
  final String sender;
  final DateTime timestamp;

  Message({
    required this.text,
    required this.sender,
    required this.timestamp,
  });

  factory Message.fromMap(Map<String, dynamic> data, String documentId) {
    final String text = data['text'] ?? '';
    final String sender = data['sender'] ?? '';
    final DateTime timestamp = (data['timestamp'] as Timestamp).toDate();

    return Message(
      text: text,
      sender: sender,
      timestamp: timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'sender': sender,
      'timestamp': timestamp,
    };
  }
}
