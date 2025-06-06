import 'package:flutter/material.dart';
import 'package:techfour_dms_flutter_csui/models/list/application_list.dart';
import 'package:techfour_dms_flutter_csui/screens/detail/application_detail.dart';
import 'package:techfour_dms_flutter_csui/widgets/common_drawer.dart';
import 'package:techfour_dms_flutter_csui/widgets/generic_list_screen.dart';
import 'package:techfour_dms_flutter_csui/services/api_service.dart';

class ApplicationListScreen extends StatefulWidget {
  const ApplicationListScreen({super.key});

  @override
  State<ApplicationListScreen> createState() => _ApplicationListScreenState();
}

class _ApplicationListScreenState extends State<ApplicationListScreen> {
  @override
  Widget build(BuildContext context) {
    return GenericListScreen<Application>(
      title: 'Applications',
      drawerSection: DrawerSection.application,
      apiCall: (page, limit, filters) => ApiService.instance.getApplicationList(
        page: page,
        limit: limit,
        search: filters,
      ),
      fromJson: Application.fromJson,
      searchableColumns: const [
        SearchableColumn(label: 'ID', filterId: 'id', width: 50),
        SearchableColumn(label: 'Env ID', filterId: 'env_id', width: 80),
        SearchableColumn(label: 'Client ID', filterId: 'client_id', width: 80),
        SearchableColumn(label: 'Env Name', filterId: 'env_name', width: 150),
        SearchableColumn(label: 'Code', filterId: 'code', width: 100),
        SearchableColumn(label: 'Status', filterId: 'status', width: 100),
        SearchableColumn(label: 'Retry Attempts', filterId: 'retry_attempts', width: 100),
        SearchableColumn(label: 'Created At', filterId: 'created_at', width: 120),
      ],
      buildCells: _buildApplicationCells,
    );
  }

  List<DataCell> _buildApplicationCells(Application application) {
    return [
      DataCell(Text(application.id)),
      DataCell(Text(application.envId)),
      DataCell(Text(application.clientId)),
      DataCell(Text(application.envName)),
      DataCell(Text(application.code)),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: application.status == 'Active'
                ? Colors.green.withValues(alpha: 0.1)
                : Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            application.status,
            style: TextStyle(
              color: application.status == 'Active' ? Colors.green : Colors.red,
              fontSize: 12,
            ),
          ),
        ),
      ),
      DataCell(Text(application.retryAttempts)),
      DataCell(Text(application.createdAt)),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove_red_eye_outlined, color: Colors.grey[600]),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ApplicationDetailPage(applicationId: int.parse(application.id)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ];
  }
}