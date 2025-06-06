class ClientD {
  final String id;
  final String clientName;
  final String status;
  final String createdAt;
  final String modifiedAt;
  final String createdBy;
  final String modifiedBy;
  final String deleted;

  ClientD({
    required this.id,
    required this.clientName,
    required this.status,
    required this.createdAt,
    required this.modifiedAt,
    required this.createdBy,
    required this.modifiedBy,
    required this.deleted,
  });

  factory ClientD.fromJson(Map<String, dynamic> json) {
    return ClientD(
      id: json['id']?.toString() ?? '',
      clientName: json['client_name']?.toString() ?? '',
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
      'client_name': clientName,
      'status': status,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'createdBy': createdBy,
      'modifiedBy': modifiedBy,
      'deleted': deleted,
    };
  }
}