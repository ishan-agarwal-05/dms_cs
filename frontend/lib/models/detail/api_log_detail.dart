class ApiLogD {
  final String id;
  final String envId;
  final String apiName;
  final String url;
  final String method;
  final String requestBody;
  final String reqHeader;
  final String response;
  final String status;
  final String ip;
  final String createdDate;
  final String createdAt;
  final String modifiedAt;
  final String deleted;

  ApiLogD({
    required this.id,
    required this.envId,
    required this.apiName,
    required this.url,
    required this.method,
    required this.requestBody,
    required this.reqHeader,
    required this.response,
    required this.status,
    required this.ip,
    required this.createdDate,
    required this.createdAt,
    required this.modifiedAt,
    required this.deleted,
  });

  factory ApiLogD.fromJson(Map<String, dynamic> json) {
    return ApiLogD(
      id: json['id']?.toString() ?? '',
      envId: json['env_id']?.toString() ?? '',
      apiName: json['api_name']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
      method: json['method']?.toString() ?? '',
      requestBody: json['request_body']?.toString() ?? '',
      reqHeader: json['req_header']?.toString() ?? '',
      response: json['response']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      ip: json['ip']?.toString() ?? '',
      createdDate: json['created_date']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      modifiedAt: json['modifiedAt']?.toString() ?? '',
      deleted: json['deleted']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'env_id': envId,
      'api_name': apiName,
      'url': url,
      'method': method,
      'request_body': requestBody,
      'req_header': reqHeader,
      'response': response,
      'status': status,
      'ip': ip,
      'created_date': createdDate,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'deleted': deleted,
    };
  }
}