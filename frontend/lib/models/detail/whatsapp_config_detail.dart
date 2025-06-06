class WhatsappConfigD {
  final String id;
  final String envId;
  final String whatsappPhoneNumberId;
  final String whatsappAccessToken;
  final String sender;
  final String whatsappVendorId;
  final String type;
  final String status;
  final String createdAt;
  final String modifiedAt;
  final String createdBy;
  final String modifiedBy;
  final String deleted;

  WhatsappConfigD({
    required this.id,
    required this.envId,
    required this.whatsappPhoneNumberId,
    required this.whatsappAccessToken,
    required this.sender,
    required this.whatsappVendorId,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.modifiedAt,
    required this.createdBy,
    required this.modifiedBy,
    required this.deleted,
  });

  factory WhatsappConfigD.fromJson(Map<String, dynamic> json) {
    return WhatsappConfigD(
      id: json['id']?.toString() ?? '',
      envId: json['env_id']?.toString() ?? '',
      whatsappPhoneNumberId: json['whatsapp_phone_number_id']?.toString() ?? '',
      whatsappAccessToken: json['whatsapp_access_token']?.toString() ?? '',
      sender: json['sender']?.toString() ?? '',
      whatsappVendorId: json['whatsapp_vendor_id']?.toString() ?? '',
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
      'whatsapp_phone_number_id': whatsappPhoneNumberId,
      'whatsapp_access_token': whatsappAccessToken,
      'sender': sender,
      'whatsapp_vendor_id': whatsappVendorId,
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