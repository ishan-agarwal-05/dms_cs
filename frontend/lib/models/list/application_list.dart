class Application {
  final String id;
  final String envId;
  final String clientId;
  final String envName;
  final String code;
  final String status;
  final String retryAttempts;
  final String createdAt;
  final String modifiedAt;
  final String createdBy;
  final String modifiedBy;
  final String deleted;
  final String appApiConfig;

  Application({
    required this.id,
    required this.envId,
    required this.clientId,
    required this.envName,
    required this.code,
    required this.status,
    required this.retryAttempts,
    required this.createdAt,
    required this.modifiedAt,
    required this.createdBy,
    required this.modifiedBy,
    required this.deleted,
    required this.appApiConfig,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id']?.toString() ?? '',
      envId: json['env_id']?.toString() ?? '',
      clientId: json['client_id']?.toString() ?? '',
      envName: json['env_name']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      retryAttempts: json['retry_attempts']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      modifiedAt: json['modifiedAt']?.toString() ?? '',
      createdBy: json['createdBy']?.toString() ?? '',
      modifiedBy: json['modifiedBy']?.toString() ?? '',
      deleted: json['deleted']?.toString() ?? '',
      appApiConfig: json['app_api_config']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'env_id': envId,
      'client_id': clientId,
      'env_name': envName,
      'code': code,
      'status': status,
      'retry_attempts': retryAttempts,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'createdBy': createdBy,
      'modifiedBy': modifiedBy,
      'deleted': deleted,
      'app_api_config': appApiConfig,
    };
  }
}