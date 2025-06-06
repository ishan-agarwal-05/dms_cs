class Api {
  final String id;
  final String appApi;
  final String status;
  final String createdAt;
  final String modifiedAt;
  final String createdBy;
  final String modifiedBy;
  final String deleted;

  Api({
    required this.id,
    required this.appApi,
    required this.status,
    required this.createdAt,
    required this.modifiedAt,
    required this.createdBy,
    required this.modifiedBy,
    required this.deleted,
  });

  factory Api.fromJson(Map<String, dynamic> json) {
    return Api(
      id: json['id']?.toString() ?? '',
      appApi: json['app_api']?.toString() ?? '',
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
      'app_api': appApi,
      'status': status,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'createdBy': createdBy,
      'modifiedBy': modifiedBy,
      'deleted': deleted,
    };
  }
}