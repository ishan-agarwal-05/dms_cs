class ApiApplicationMasterD {
  final String id;
  final String envId;
  final String envName;
  final String type;
  final String status;
  final String createdAt;
  final String modifiedAt;
  final String createdBy;
  final String modifiedBy;
  final String deleted;

  ApiApplicationMasterD({
    required this.id,
    required this.envId,
    required this.envName,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.modifiedAt,
    required this.createdBy,
    required this.modifiedBy,
    required this.deleted,
  });

  factory ApiApplicationMasterD.fromJson(Map<String, dynamic> json) {
    return ApiApplicationMasterD(
      id: json['id']?.toString() ?? '',
      envId: json['env_id']?.toString() ?? '',
      envName: json['env_name']?.toString() ?? '',
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
      'env_name': envName,
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