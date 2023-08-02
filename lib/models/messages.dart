class Messages {
  late String senderId;
  late String receiverId;
  late String content;
  late String timestamp;

  Messages();

  Messages.forMap(Map<String, dynamic> data) {
    senderId = data['sender_id'];
    receiverId = data['receiver_id'];
    content = data['content'];
    timestamp = data['timestamp'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['content'] = content;
    data['timestamp'] = timestamp;
    return data;
  }
}
