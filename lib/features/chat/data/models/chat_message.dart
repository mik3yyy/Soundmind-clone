class ChatMessageDto {
  final int id;
  final int chatroomId;
  final String sender;
  final String message;
  final String timestamp;

  ChatMessageDto({
    required this.id,
    required this.chatroomId,
    required this.sender,
    required this.message,
    required this.timestamp,
  });

  factory ChatMessageDto.fromJson(Map<String, dynamic> json) {
    return ChatMessageDto(
      id: json['id'],
      chatroomId: json['chatroomId'],
      sender: json['sender'],
      message: json['message'],
      timestamp: json['timestamp'],
    );
  }
}
