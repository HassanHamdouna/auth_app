class Messages {
  late String senderId;
  late String receiverId;
  late String senderName;
  late String receiverName;
  late String content;
  late String status;
  late final Type type;
  late String timestamp;

  Messages();

  Messages.forMap(Map<String, dynamic> data) {
    senderId = data['sender_id'];
    receiverId = data['receiver_id'];
    senderName = data['sender_name'];
    receiverName = data['receiver_name'];
    content = data['content'];
    status = data['status'];
    type = data['type'] == Type.image.name ? Type.image : Type.text;
    timestamp = data['timestamp'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['sender_name'] = senderName;
    data['receiver_name'] = receiverName;
    data['content'] = content;
    data['status'] = status;
    data['type'] = type.name;
    data['timestamp'] = timestamp;
    return data;
  }
}

enum Type { text, image }
