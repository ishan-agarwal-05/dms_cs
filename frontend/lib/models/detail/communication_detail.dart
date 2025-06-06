class CommunicationD {
  final String id;
  final String envId;
  final String refId;
  final String module;
  final String senderId;
  final String type;
  final String subject;
  final String body;
  final String to;
  final String attachments;
  final String cc;
  final String status;
  final String createdAt;
  final String modifiedAt;

  CommunicationD({
    required this.id,
    required this.envId,
    required this.refId,
    required this.module,
    required this.senderId,
    required this.type,
    required this.subject,
    required this.body,
    required this.to,
    required this.attachments,
    required this.cc,
    required this.status,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory CommunicationD.fromJson(Map<String, dynamic> json) {
    return CommunicationD(
      id: json['id']?.toString() ?? '',
      envId: json['env_id']?.toString() ?? '',
      refId: json['ref_id']?.toString() ?? '',
      module: json['module']?.toString() ?? '',
      senderId: json['sender_id']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      subject: json['subject']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      to: json['to']?.toString() ?? '',
      attachments: json['attachments']?.toString() ?? '',
      cc: json['cc']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      modifiedAt: json['modifiedAt']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'env_id': envId,
      'ref_id': refId,
      'module': module,
      'sender_id': senderId,
      'type': type,
      'subject': subject,
      'body': body,
      'to': to,
      'attachments': attachments,
      'cc': cc,
      'status': status,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
    };
  }
}