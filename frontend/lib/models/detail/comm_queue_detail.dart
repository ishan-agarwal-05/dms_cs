class CommQueueD {
  final String id;
  final String envId;
  final String commId;
  final String refId;
  final String module;
  final String senderId;
  final String type;
  final String subject;
  final String body;
  final String to;
  final String cc;
  final String varData;
  final String attachments;
  final String status;
  final String attempts;
  final String attemptsLeft;
  final String createdAt;
  final String modifiedAt;

  CommQueueD({
    required this.id,
    required this.envId,
    required this.commId,
    required this.refId,
    required this.module,
    required this.senderId,
    required this.type,
    required this.subject,
    required this.body,
    required this.to,
    required this.cc,
    required this.varData,
    required this.attachments,
    required this.status,
    required this.attempts,
    required this.attemptsLeft,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory CommQueueD.fromJson(Map<String, dynamic> json) {
    return CommQueueD(
      id: json['id']?.toString() ?? '',
      envId: json['env_id']?.toString() ?? '',
      commId: json['comm_id']?.toString() ?? '',
      refId: json['ref_id']?.toString() ?? '',
      module: json['module']?.toString() ?? '',
      senderId: json['sender_id']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      subject: json['subject']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      to: json['to']?.toString() ?? '',
      cc: json['cc']?.toString() ?? '',
      varData: json['var_data']?.toString() ?? '',
      attachments: json['attachments']?.toString() ?? '',
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
      'body': body,
      'to': to,
      'cc': cc,
      'var_data': varData,
      'attachments': attachments,
      'status': status,
      'attempts': attempts,
      'attempts_left': attemptsLeft,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
    };
  }
}