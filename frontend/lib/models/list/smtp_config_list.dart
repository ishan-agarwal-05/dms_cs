class SmtpConfig {
  final String id;
  final String envId;
  final String mailHost;
  final String mailPort;
  final String senderEmail;
  final String mailUsername;
  final String mailPassword;
  final String status;
  final String createdAt;
  final String modifiedAt;
  final String createdBy;
  final String modifiedBy;
  final String deleted;

  SmtpConfig({
    required this.id,
    required this.envId,
    required this.mailHost,
    required this.mailPort,
    required this.senderEmail,
    required this.mailUsername,
    required this.mailPassword,
    required this.status,
    required this.createdAt,
    required this.modifiedAt,
    required this.createdBy,
    required this.modifiedBy,
    required this.deleted,
  });

  factory SmtpConfig.fromJson(Map<String, dynamic> json) {
    return SmtpConfig(
      id: json['id']?.toString() ?? '',
      envId: json['env_id']?.toString() ?? '',
      mailHost: json['mail_host']?.toString() ?? '',
      mailPort: json['mail_port']?.toString() ?? '',
      senderEmail: json['sender_email']?.toString() ?? '',
      mailUsername: json['mail_username']?.toString() ?? '',
      mailPassword: json['mail_password']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      modifiedAt: json['modifiedAt']?.toString() ?? '',
      createdBy: json['createdBy']?.toString() ?? '',
      modifiedBy: json['modifiedBy']?.toString() ?? '',
      deleted: json['deleted']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'env_id': envId,
      'mail_host': mailHost,
      'mail_port': mailPort,
      'sender_email': senderEmail,
      'mail_username': mailUsername,
      'mail_password': mailPassword,
      'status': status,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'createdBy': createdBy,
      'modifiedBy': modifiedBy,
      'deleted': deleted,
    };
  }
}