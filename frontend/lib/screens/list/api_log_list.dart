import 'package:flutter/material.dart';
import 'package:techfour_dms_flutter_csui/models/list/api_log_list.dart';
import 'package:techfour_dms_flutter_csui/screens/detail/api_log_detail.dart';
import 'package:techfour_dms_flutter_csui/widgets/common_drawer.dart';
import 'package:techfour_dms_flutter_csui/widgets/generic_list_screen.dart';
import 'package:techfour_dms_flutter_csui/services/api_service.dart';

class ApiLogListScreen extends StatefulWidget {
  const ApiLogListScreen({super.key});

  @override
  State<ApiLogListScreen> createState() => _ApiLogListScreenState();
}

class _ApiLogListScreenState extends State<ApiLogListScreen> {
  @override
  Widget build(BuildContext context) {
    return GenericListScreen<ApiLog>(
      title: 'API Logs',
      drawerSection: DrawerSection.apiLog,
      apiCall: (page, limit, filters) => ApiService.instance.getApiLogsList(
        page: page,
        limit: limit,
        search: filters,
      ),
      fromJson: ApiLog.fromJson,
      searchableColumns: const [
        SearchableColumn(label: 'ID', filterId: 'id', width: 50),
        SearchableColumn(label: 'Env ID', filterId: 'env_id', width: 80),
        SearchableColumn(label: 'API Name', filterId: 'api_name', width: 150),
        SearchableColumn(label: 'URL', filterId: 'url', width: 200),
        SearchableColumn(label: 'Method', filterId: 'method', width: 80),
        SearchableColumn(label: 'Status', filterId: 'status', width: 80),
        SearchableColumn(label: 'IP', filterId: 'ip', width: 120),
        SearchableColumn(label: 'Created At', filterId: 'created_at', width: 120),
      ],
      buildCells: _buildApiLogCells,
    );
  }

  List<DataCell> _buildApiLogCells(ApiLog apiLog) {
    return [
      DataCell(Text(apiLog.id)),
      DataCell(Text(apiLog.envId)),
      DataCell(Text(apiLog.apiName)),
      DataCell(
        Tooltip(
          message: apiLog.url,
          child: Text(
            apiLog.url.length > 30 ? '${apiLog.url.substring(0, 30)}...' : apiLog.url,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _getMethodColor(apiLog.method).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            apiLog.method,
            style: TextStyle(
              color: _getMethodColor(apiLog.method),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(apiLog.status).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            apiLog.status,
            style: TextStyle(
              color: _getStatusColor(apiLog.status),
              fontSize: 12,
            ),
          ),
        ),
      ),
      DataCell(Text(apiLog.ip)),
      DataCell(Text(apiLog.createdAt)),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove_red_eye_outlined, color: Colors.grey[600]),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ApiLogDetailPage(apiLogId: int.parse(apiLog.id)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ];
  }

  Color _getMethodColor(String method) {
    switch (method.toUpperCase()) {
      case 'GET':
        return Colors.green;
      case 'POST':
        return Colors.blue;
      case 'PUT':
        return Colors.orange;
      case 'DELETE':
        return Colors.red;
      case 'PATCH':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    if (status.startsWith('2')) {
      return Colors.green; // 2xx success
    } else if (status.startsWith('3')) {
      return Colors.blue; // 3xx redirection
    } else if (status.startsWith('4')) {
      return Colors.orange; // 4xx client error
    } else if (status.startsWith('5')) {
      return Colors.red; // 5xx server error
    } else {
      return Colors.grey;
    }
  }
}