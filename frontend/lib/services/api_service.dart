import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ApiService {
  static ApiService? _instance;
  static ApiService get instance => _instance ??= ApiService._();
  
  ApiService._();

  // Environment configuration
  String get baseUrl => dotenv.env['API_BASE_URL'] ?? 'http://localhost:8080';
  int get timeout => int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30000') ?? 30000;
  bool get debugMode => dotenv.env['DEBUG_MODE']?.toLowerCase() == 'true';
  String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';

  // API Endpoints
  String get authLoginEndpoint => '$baseUrl/admin/login';
  String get apiListEndpoint => '$baseUrl/admin/api/list';
  String get apiDetailsEndpoint => '$baseUrl/admin/api/details';
  String get apiApplicationMasterListEndpoint => '$baseUrl/admin/api_application_master/list';
  String get apiApplicationMasterDetailsEndpoint => '$baseUrl/admin/api_application_master/details';
  String get apiLogListEndpoint => '$baseUrl/admin/api_logs/list';
  String get apiLogDetailsEndpoint => '$baseUrl/admin/api_logs/details';
  String get applicationListEndpoint => '$baseUrl/admin/application/list';
  String get applicationDetailsEndpoint => '$baseUrl/admin/application/details';
  String get clientListEndpoint => '$baseUrl/admin/client/list';
  String get clientDetailsEndpoint => '$baseUrl/admin/client/details';
  String get commQueueListEndpoint => '$baseUrl/admin/comm_queue/list';
  String get commQueueDetailsEndpoint => '$baseUrl/admin/comm_queue/details';
  String get communicationListEndpoint => '$baseUrl/admin/communication/list';
  String get communicationDetailsEndpoint => '$baseUrl/admin/communication/details';
  String get smsConfigListEndpoint => '$baseUrl/admin/sms_config/list';
  String get smsConfigDetailsEndpoint => '$baseUrl/admin/sms_config/details';
  String get smtpConfigListEndpoint => '$baseUrl/admin/smtp_config/list';
  String get smtpConfigDetailsEndpoint => '$baseUrl/admin/smtp_config/details';
  String get usersListEndpoint => '$baseUrl/admin/users/list';
  String get userDetailsEndpoint => '$baseUrl/admin/users/details';
  String get whatsappConfigListEndpoint => '$baseUrl/admin/whatsapp_config/list';
  String get whatsappConfigDetailsEndpoint => '$baseUrl/admin/whatsapp_config/details';

  // Helper method to get auth token
  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  // Helper method to decode JWT token and get user info
  Future<Map<String, dynamic>?> getUserInfoFromToken() async {
    final token = await getAuthToken();
    if (token == null) return null;
    
    try {
      // Split JWT token (header.payload.signature)
      final parts = token.split('.');
      if (parts.length != 3) return null;
      
      // Decode the payload (second part)
      String payload = parts[1];
      
      // Add padding if needed for base64 decoding
      switch (payload.length % 4) {
        case 2:
          payload += '==';
          break;
        case 3:
          payload += '=';
          break;
      }
      
      // Decode base64
      final decoded = utf8.decode(base64Decode(payload));
      final Map<String, dynamic> claims = jsonDecode(decoded);
      
      return claims;
    } catch (e) {
      return null;
    }
  }

  // Helper method to get user first name from token
  Future<String> getUserFirstName() async {
    final userInfo = await getUserInfoFromToken();
    return userInfo?['first_name'] ?? 'User';
  }

  // Helper method to get common headers
  Future<Map<String, String>> getHeaders({bool includeAuth = true}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (includeAuth) {
      final token = await getAuthToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  // Generic GET request
  Future<http.Response> get(String endpoint, {bool includeAuth = true}) async {
    final url = endpoint.startsWith('http') ? endpoint : '$baseUrl$endpoint';
    final headers = await getHeaders(includeAuth: includeAuth);
    

    return await http.get(
      Uri.parse(url),
      headers: headers,
    ).timeout(Duration(milliseconds: timeout));
  }

  // Generic POST request
  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
    bool includeAuth = true,
  }) async {
    final url = endpoint.startsWith('http') ? endpoint : '$baseUrl$endpoint';
    final headers = await getHeaders(includeAuth: includeAuth);
    

    return await http.post(
      Uri.parse(url),
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    ).timeout(Duration(milliseconds: timeout));
  }

  // Generic PUT request
  Future<http.Response> put(
    String endpoint, {
    Map<String, dynamic>? body,
    bool includeAuth = true,
  }) async {
    final url = endpoint.startsWith('http') ? endpoint : '$baseUrl$endpoint';
    final headers = await getHeaders(includeAuth: includeAuth);
    

    return await http.put(
      Uri.parse(url),
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    ).timeout(Duration(milliseconds: timeout));
  }

  // Generic DELETE request
  Future<http.Response> delete(String endpoint, {bool includeAuth = true}) async {
    final url = endpoint.startsWith('http') ? endpoint : '$baseUrl$endpoint';
    final headers = await getHeaders(includeAuth: includeAuth);
    

    return await http.delete(
      Uri.parse(url),
      headers: headers,
    ).timeout(Duration(milliseconds: timeout));
  }

  // Specific API methods for common operations
  
  // Authentication
  Future<http.Response> login(String username, String password) async {
    return await post(
      '/admin/login',
      body: {
        'username': username,
        'password': password,
      },
      includeAuth: false,
    );
  }

  // API Methods for Communication Service

  // Users API
  Future<http.Response> getUsersList({
    int page = 1,
    int limit = 10,
    Map<String, dynamic>? search,
  }) async {
    final Map<String, dynamic> body = {
      'page': page,
      'limit': limit,
    };
    if (search != null && search.isNotEmpty) {
      body['search'] = search;
    }
    return await post('/admin/users/list', body: body);
  }

  Future<http.Response> getUserDetails(int userId) async {
    return await post('/admin/users/details', body: {'user_id': userId});
  }

  // API Management
  Future<http.Response> getApiList({
    int page = 1,
    int limit = 10,
    Map<String, dynamic>? search,
  }) async {
    final Map<String, dynamic> body = {
      'page': page,
      'limit': limit,
    };
    if (search != null && search.isNotEmpty) {
      body['search'] = search;
    }
    return await post('/admin/api/list', body: body);
  }

  Future<http.Response> getApiDetails(int apiId) async {
    return await post('/admin/api/details', body: {'api_id': apiId});
  }

  // API Application Master
  Future<http.Response> getApiApplicationMasterList({
    int page = 1,
    int limit = 10,
    Map<String, dynamic>? search,
  }) async {
    final Map<String, dynamic> body = {
      'page': page,
      'limit': limit,
    };
    if (search != null && search.isNotEmpty) {
      body['search'] = search;
    }
    return await post('/admin/api_application_master/list', body: body);
  }

  Future<http.Response> getApiApplicationMasterDetails(int apiApplicationMasterId) async {
    return await post('/admin/api_application_master/details', body: {'api_application_master_id': apiApplicationMasterId});
  }

  // API Logs
  Future<http.Response> getApiLogsList({
    int page = 1,
    int limit = 10,
    Map<String, dynamic>? search,
  }) async {
    final Map<String, dynamic> body = {
      'page': page,
      'limit': limit,
    };
    if (search != null && search.isNotEmpty) {
      body['search'] = search;
    }
    return await post('/admin/api_logs/list', body: body);
  }

  Future<http.Response> getApiLogsDetails(int apiLogId) async {
    return await post('/admin/api_logs/details', body: {'api_log_id': apiLogId});
  }

  // Application Management
  Future<http.Response> getApplicationList({
    int page = 1,
    int limit = 10,
    Map<String, dynamic>? search,
  }) async {
    final Map<String, dynamic> body = {
      'page': page,
      'limit': limit,
    };
    if (search != null && search.isNotEmpty) {
      body['search'] = search;
    }
    return await post('/admin/application/list', body: body);
  }

  Future<http.Response> getApplicationDetails(int applicationId) async {
    return await post('/admin/application/details', body: {'application_id': applicationId});
  }

  // Client Management
  Future<http.Response> getClientList({
    int page = 1,
    int limit = 10,
    Map<String, dynamic>? search,
  }) async {
    final Map<String, dynamic> body = {
      'page': page,
      'limit': limit,
    };
    if (search != null && search.isNotEmpty) {
      body['search'] = search;
    }
    return await post('/admin/client/list', body: body);
  }

  Future<http.Response> getClientDetails(int clientId) async {
    return await post('/admin/client/details', body: {'client_id': clientId});
  }

  // Communication Queue
  Future<http.Response> getCommQueueList({
    int page = 1,
    int limit = 10,
    Map<String, dynamic>? search,
  }) async {
    final Map<String, dynamic> body = {
      'page': page,
      'limit': limit,
    };
    if (search != null && search.isNotEmpty) {
      body['search'] = search;
    }
    return await post('/admin/comm_queue/list', body: body);
  }

  Future<http.Response> getCommQueueDetails(int commQueueId) async {
    return await post('/admin/comm_queue/details', body: {'comm_queue_id': commQueueId});
  }

  // Communication History
  Future<http.Response> getCommunicationList({
    int page = 1,
    int limit = 10,
    Map<String, dynamic>? search,
  }) async {
    final Map<String, dynamic> body = {
      'page': page,
      'limit': limit,
    };
    if (search != null && search.isNotEmpty) {
      body['search'] = search;
    }
    return await post('/admin/communication/list', body: body);
  }

  Future<http.Response> getCommunicationDetails(int communicationId) async {
    return await post('/admin/communication/details', body: {'communication_id': communicationId});
  }

  // SMS Configuration
  Future<http.Response> getSmsConfigList({
    int page = 1,
    int limit = 10,
    Map<String, dynamic>? search,
  }) async {
    final Map<String, dynamic> body = {
      'page': page,
      'limit': limit,
    };
    if (search != null && search.isNotEmpty) {
      body['search'] = search;
    }
    return await post('/admin/sms_config/list', body: body);
  }

  Future<http.Response> getSmsConfigDetails(int smsConfigId) async {
    return await post('/admin/sms_config/details', body: {'sms_config_id': smsConfigId});
  }

  // SMTP Configuration
  Future<http.Response> getSmtpConfigList({
    int page = 1,
    int limit = 10,
    Map<String, dynamic>? search,
  }) async {
    final Map<String, dynamic> body = {
      'page': page,
      'limit': limit,
    };
    if (search != null && search.isNotEmpty) {
      body['search'] = search;
    }
    return await post('/admin/smtp_config/list', body: body);
  }

  Future<http.Response> getSmtpConfigDetails(int smtpConfigId) async {
    return await post('/admin/smtp_config/details', body: {'smtp_config_id': smtpConfigId});
  }

  // WhatsApp Configuration
  Future<http.Response> getWhatsappConfigList({
    int page = 1,
    int limit = 10,
    Map<String, dynamic>? search,
  }) async {
    final Map<String, dynamic> body = {
      'page': page,
      'limit': limit,
    };
    if (search != null && search.isNotEmpty) {
      body['search'] = search;
    }
    return await post('/admin/whatsapp_config/list', body: body);
  }

  Future<http.Response> getWhatsappConfigDetails(int whatsappConfigId) async {
    return await post('/admin/whatsapp_config/details', body: {'whatsapp_config_id': whatsappConfigId});
  }

}