import 'package:flutter/material.dart';
import 'package:techfour_dms_flutter_csui/models/list/comm_queue_list.dart';
import 'package:techfour_dms_flutter_csui/screens/detail/comm_queue_detail.dart';
import 'package:techfour_dms_flutter_csui/widgets/common_drawer.dart';
import 'package:techfour_dms_flutter_csui/widgets/generic_list_screen.dart';
import 'package:techfour_dms_flutter_csui/services/api_service.dart';

class CommQueueListScreen extends StatefulWidget {
  const CommQueueListScreen({super.key});

  @override
  State<CommQueueListScreen> createState() => _CommQueueListScreenState();
}

class _CommQueueListScreenState extends State<CommQueueListScreen> {
  @override
  Widget build(BuildContext context) {
    return GenericListScreen<CommQueue>(
      title: 'Communication Queue',
      drawerSection: DrawerSection.commQueue,
      apiCall: (page, limit, filters) => ApiService.instance.getCommQueueList(
        page: page,
        limit: limit,
        search: filters,
      ),
      fromJson: CommQueue.fromJson,
      searchableColumns: const [
        SearchableColumn(label: 'ID', filterId: 'id', width: 50),
        SearchableColumn(label: 'Env ID', filterId: 'env_id', width: 80),
        SearchableColumn(label: 'Comm ID', filterId: 'comm_id', width: 80),
        SearchableColumn(label: 'Ref ID', filterId: 'ref_id', width: 80),
        SearchableColumn(label: 'Module', filterId: 'module', width: 100),
        SearchableColumn(label: 'Type', filterId: 'type', width: 80),
        SearchableColumn(label: 'Subject', filterId: 'subject', width: 200),
        SearchableColumn(label: 'To', filterId: 'to', width: 150),
        SearchableColumn(label: 'Status', filterId: 'status', width: 100),
        SearchableColumn(label: 'Attempts', filterId: 'attempts', width: 80),
      ],
      buildCells: _buildCommQueueCells,
    );
  }

  List<DataCell> _buildCommQueueCells(CommQueue commQueue) {
    return [
      DataCell(Text(commQueue.id)),
      DataCell(Text(commQueue.envId)),
      DataCell(Text(commQueue.commId)),
      DataCell(Text(commQueue.refId)),
      DataCell(Text(commQueue.module)),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _getTypeColor(commQueue.type).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            commQueue.type,
            style: TextStyle(
              color: _getTypeColor(commQueue.type),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      DataCell(
        Tooltip(
          message: commQueue.subject,
          child: Text(
            commQueue.subject.length > 30 
                ? '${commQueue.subject.substring(0, 30)}...' 
                : commQueue.subject,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      DataCell(
        Tooltip(
          message: commQueue.to,
          child: Text(
            commQueue.to.length > 20 
                ? '${commQueue.to.substring(0, 20)}...' 
                : commQueue.to,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(commQueue.status).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            commQueue.status,
            style: TextStyle(
              color: _getStatusColor(commQueue.status),
              fontSize: 12,
            ),
          ),
        ),
      ),
      DataCell(
        Text(
          '${commQueue.attempts}/${int.parse(commQueue.attempts) + int.parse(commQueue.attemptsLeft)}',
          style: TextStyle(
            color: int.parse(commQueue.attemptsLeft) == 0 
                ? Colors.red 
                : Colors.grey[600],
          ),
        ),
      ),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove_red_eye_outlined, color: Colors.grey[600]),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommQueueDetailPage(commQueueId: int.parse(commQueue.id)),
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