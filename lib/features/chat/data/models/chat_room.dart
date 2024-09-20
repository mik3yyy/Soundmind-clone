class ChatRoomDto {
  final int id;
  final String name;
  final String? lastMessage;
  final String? lastMessageTime;

  ChatRoomDto({
    required this.id,
    required this.name,
    this.lastMessage,
    this.lastMessageTime,
  });

  factory ChatRoomDto.fromJson(Map<String, dynamic> json) {
    return ChatRoomDto(
      id: json['id'],
      name: json['name'],
      lastMessage: json['lastMessage'],
      lastMessageTime: json['lastMessageTime'],
    );
  }
}
