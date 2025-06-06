class CommQueue {
  final String id;
  final String envId;
  final String commId;
  final String refId;
  final String module;
  final String senderId;
  final String type;
  final String subject;
  final String to;
  final String cc;
  final String status;
  final String attempts;
  final String attemptsLeft;
  final String createdAt;
  final String modifiedAt;

  CommQueue({
    required this.id,
    required this.envId,
    required this.commId,
    required this.refId,
    required this.module,
    required this.senderId,
    required this.type,
    required this.subject,
    required this.to,
    required this.cc,
    required this.status,
    required this.attempts,
    required this.attemptsLeft,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory CommQueue.fromJson(Map<String, dynamic> json) {
    return CommQueue(
      id: json['id']?.toString() ?? '',
      envId: json['env_id']?.toString() ?? '',
      commId: json['comm_id']?.toString() ?? '',
      refId: json['ref_id']?.toString() ?? '',
      module: json['module']?.toString() ?? '',
      senderId: json['sender_id']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      subject: json['subject']?.toString() ?? '',
      to: json['to']?.toString() ?? '',
      cc: json['cc']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      attempts: json['attempts']?.toString() ?? '',
      attemptsLeft: json['attempts_left']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      modifiedAt: json['modifiedAt']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'env_id': envId,
      'comm_id': commId,
      'ref_id': refId,
      'module': module,
      'sender_id': senderId,
      'type': type,
      'subject': subject,
      'to': to,
      'cc': cc,
      'status': status,
      'attempts': attempts,
      'attempts_left': attemptsLeft,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
    };
  }
}