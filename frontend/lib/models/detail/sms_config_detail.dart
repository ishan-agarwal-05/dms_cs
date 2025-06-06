class SmsConfigD {
  final String id;
  final String envId;
  final String senderUsername;
  final String senderPassword;
  final String sender;
  final String licenseCode;
  final String authToken;
  final String baseApiUrl;
  final String type;
  final String status;
  final String createdAt;
  final String modifiedAt;
  final String createdBy;
  final String modifiedBy;
  final String deleted;

  SmsConfigD({
    required this.id,
    required this.envId,
    required this.senderUsername,
    required this.senderPassword,
    required this.sender,
    required this.licenseCode,
    required this.authToken,
    required this.baseApiUrl,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.modifiedAt,
    required this.createdBy,
    required this.modifiedBy,
    required this.deleted,
  });

  factory SmsConfigD.fromJson(Map<String, dynamic> json) {
    return SmsConfigD(
      id: json['id']?.toString() ?? '',
      envId: json['env_id']?.toString() ?? '',
      senderUsername: json['sender_username']?.toString() ?? '',
      senderPassword: json['sender_password']?.toString() ?? '',
      sender: json['sender']?.toString() ?? '',
      licenseCode: json['license_code']?.toString() ?? '',
      authToken: json['auth_token']?.toString() ?? '',
      baseApiUrl: json['base_api_url']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
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
      'sender_username': senderUsername,
      'sender_password': senderPassword,
      'sender': sender,
      'license_code': licenseCode,
      'auth_token': authToken,
      'base_api_url': baseApiUrl,
      'type': type,
      'status': status,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'createdBy': createdBy,
      'modifiedBy': modifiedBy,
      'deleted': deleted,
    };
  }
}