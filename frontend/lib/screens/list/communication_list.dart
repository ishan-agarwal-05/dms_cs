import 'package:flutter/material.dart';
import 'package:techfour_dms_flutter_csui/models/list/communication_list.dart';
import 'package:techfour_dms_flutter_csui/screens/detail/communication_detail.dart';
import 'package:techfour_dms_flutter_csui/widgets/common_drawer.dart';
import 'package:techfour_dms_flutter_csui/widgets/generic_list_screen.dart';
import 'package:techfour_dms_flutter_csui/services/api_service.dart';

class CommunicationListScreen extends StatefulWidget {
  const CommunicationListScreen({super.key});

  @override
  State<CommunicationListScreen> createState() => _CommunicationListScreenState();
}

class _CommunicationListScreenState extends State<CommunicationListScreen> {
  @override
  Widget build(BuildContext context) {
    return GenericListScreen<Communication>(
      title: 'Communication',
      drawerSection: DrawerSection.communication,
      apiCall: (page, limit, filters) => ApiService.instance.getCommunicationList(
        page: page,
        limit: limit,
        search: filters,
      ),
      fromJson: Communication.fromJson,
      searchableColumns: const [
        SearchableColumn(label: 'ID', filterId: 'id', width: 50),
        SearchableColumn(label: 'Env ID', filterId: 'env_id', width: 80),
        SearchableColumn(label: 'Ref ID', filterId: 'ref_id', width: 80),
        SearchableColumn(label: 'Module', filterId: 'module', width: 100),
        SearchableColumn(label: 'Type', filterId: 'type', width: 80),
        SearchableColumn(label: 'Subject', filterId: 'subject', width: 200),
        SearchableColumn(label: 'To', filterId: 'to', width: 150),
        SearchableColumn(label: 'Status', filterId: 'status', width: 100),
        SearchableColumn(label: 'Created At', filterId: 'createdAt', width: 120),
      ],
      buildCells: _buildCommunicationCells,
    );
  }

  List<DataCell> _buildCommunicationCells(Communication communication) {
    return [
      DataCell(Text(communication.id)),
      DataCell(Text(communication.envId)),
      DataCell(Text(communication.refId)),
      DataCell(Text(communication.module)),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _getTypeColor(communication.type).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            communication.type,
            style: TextStyle(
              color: _getTypeColor(communication.type),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      DataCell(
        Tooltip(
          message: communication.subject,
          child: Text(
            communication.subject.length > 30 
                ? '${communication.subject.substring(0, 30)}...' 
                : communication.subject,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      DataCell(
        Tooltip(
          message: communication.to,
          child: Text(
            communication.to.length > 20 
                ? '${communication.to.substring(0, 20)}...' 
                : communication.to,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(communication.status).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            communication.status,
            style: TextStyle(
              color: _getStatusColor(communication.status),
              fontSize: 12,
            ),
          ),
        ),
      ),
      DataCell(Text(communication.createdAt)),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove_red_eye_outlined, color: Colors.grey[600]),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommunicationDetailPage(communicationId: int.parse(communication.id)),
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
      case 'email':
        return Colors.blue;
      case 'sms':
        return Colors.green;
      case 'whatsapp':
        return Colors.teal;
      case 'push':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'sent':
      case 'delivered':
        return Colors.green;
      case 'failed':
      case 'error':
        return Colors.red;
      case 'processing':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}