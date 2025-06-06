class ApiLog {
  final String id;
  final String envId;
  final String apiName;
  final String url;
  final String method;
  final String status;
  final String ip;
  final String createdDate;
  final String createdAt;
  final String modifiedAt;

  ApiLog({
    required this.id,
    required this.envId,
    required this.apiName,
    required this.url,
    required this.method,
    required this.status,
    required this.ip,
    required this.createdDate,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory ApiLog.fromJson(Map<String, dynamic> json) {
    return ApiLog(
      id: json['id']?.toString() ?? '',
      envId: json['env_id']?.toString() ?? '',
      apiName: json['api_name']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
      method: json['method']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      ip: json['ip']?.toString() ?? '',
      createdDate: json['created_date']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      modifiedAt: json['modifiedAt']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'env_id': envId,
      'api_name': apiName,
      'url': url,
      'method': method,
      'status': status,
      'ip': ip,
      'created_date': createdDate,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
    };
  }
}