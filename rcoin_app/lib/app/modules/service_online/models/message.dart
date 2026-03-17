import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

part 'message.g.dart';

enum MessageType {
  text(1),
  picture(2),
  video(3),
  order(4);

  const MessageType(this.value);

  final int value;

  factory MessageType.fromValue(int value) {
    return MessageType.values
        .firstWhere((element) => element.value == value, orElse: () => text);
  }
}

@freezed
class Message with _$Message {
  const factory Message({
    required int id,
    required String senderAvatar,
    required String senderNickname,
    required int senderUid,
    required int toUid,
    required MessageType messageType,
    required String content,
    String? thumbnail,
    int? dialogueId,
    Duration? duration,
    required DateTime createdAt,
  }) = _Message;

  factory Message.fromJson(Map<String, Object?> json) =>
      _$MessageFromJson(json);
}

extension MessageAttr on Message {
  String summary() {
    return switch (messageType) {
      MessageType.text => content,
      MessageType.picture => '[图片]',
      MessageType.video => '[视频]',
      MessageType.order => '[订单]',
    };
  }
}
