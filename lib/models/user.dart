class User {
  final String uid;
  final String displayName;

  User({
    required this.uid,
    required this.displayName,
  });

  factory User.fromMap(Map<String, dynamic> data, String documentId) {
    final String uid = documentId;
    final String displayName = data['displayName'] ?? '';

    return User(
      uid: uid,
      displayName: displayName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
    };
  }
}
