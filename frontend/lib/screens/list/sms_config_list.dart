import 'package:flutter/material.dart';
import 'package:techfour_dms_flutter_csui/models/list/sms_config_list.dart';
import 'package:techfour_dms_flutter_csui/screens/detail/sms_config_detail.dart';
import 'package:techfour_dms_flutter_csui/widgets/common_drawer.dart';
import 'package:techfour_dms_flutter_csui/widgets/generic_list_screen.dart';
import 'package:techfour_dms_flutter_csui/services/api_service.dart';

class SmsConfigListScreen extends StatefulWidget {
  const SmsConfigListScreen({super.key});

  @override
  State<SmsConfigListScreen> createState() => _SmsConfigListScreenState();
}

class _SmsConfigListScreenState extends State<SmsConfigListScreen> {
  @override
  Widget build(BuildContext context) {
    return GenericListScreen<SmsConfig>(
      title: 'SMS Configuration',
      drawerSection: DrawerSection.smsConfig,
      apiCall: (page, limit, filters) => ApiService.instance.getSmsConfigList(
        page: page,
        limit: limit,
        search: filters,
      ),
      fromJson: SmsConfig.fromJson,
      searchableColumns: const [
        SearchableColumn(label: 'ID', filterId: 'id', width: 50),
        SearchableColumn(label: 'Env ID', filterId: 'env_id', width: 80),
        SearchableColumn(label: 'Sender Username', filterId: 'sender_username', width: 150),
        SearchableColumn(label: 'Sender', filterId: 'sender', width: 120),
        SearchableColumn(label: 'Type', filterId: 'type', width: 100),
        SearchableColumn(label: 'Status', filterId: 'status', width: 100),
        SearchableColumn(label: 'Base API URL', filterId: 'base_api_url', width: 200),
        SearchableColumn(label: 'Created At', filterId: 'created_at', width: 120),
      ],
      buildCells: _buildSmsConfigCells,
    );
  }

  List<DataCell> _buildSmsConfigCells(SmsConfig smsConfig) {
    return [
      DataCell(Text(smsConfig.id)),
      DataCell(Text(smsConfig.envId)),
      DataCell(Text(smsConfig.senderUsername)),
      DataCell(Text(smsConfig.sender)),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _getTypeColor(smsConfig.type).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            smsConfig.type,
            style: TextStyle(
              color: _getTypeColor(smsConfig.type),
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
            color: smsConfig.status == 'Active'
                ? Colors.green.withValues(alpha: 0.1)
                : Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            smsConfig.status,
            style: TextStyle(
              color: smsConfig.status == 'Active' ? Colors.green : Colors.red,
              fontSize: 12,
            ),
          ),
        ),
      ),
      DataCell(
        Tooltip(
          message: smsConfig.baseApiUrl,
          child: Text(
            smsConfig.baseApiUrl.length > 30 
                ? '${smsConfig.baseApiUrl.substring(0, 30)}...' 
                : smsConfig.baseApiUrl,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      DataCell(Text(smsConfig.createdAt)),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove_red_eye_outlined, color: Colors.grey[600]),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SmsConfigDetailPage(smsConfigId: int.parse(smsConfig.id)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ];
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'api':
        return Colors.blue;
      case 'gateway':
        return Colors.green;
      case 'bulk':
        return Colors.orange;
      case 'transactional':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}