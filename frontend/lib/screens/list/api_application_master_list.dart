import 'package:flutter/material.dart';
import 'package:techfour_dms_flutter_csui/models/list/api_application_master_list.dart';
import 'package:techfour_dms_flutter_csui/screens/detail/api_application_master_detail.dart';
import 'package:techfour_dms_flutter_csui/widgets/common_drawer.dart';
import 'package:techfour_dms_flutter_csui/widgets/generic_list_screen.dart';
import 'package:techfour_dms_flutter_csui/services/api_service.dart';

class ApiApplicationMasterListScreen extends StatefulWidget {
  const ApiApplicationMasterListScreen({super.key});

  @override
  State<ApiApplicationMasterListScreen> createState() => _ApiApplicationMasterListScreenState();
}

class _ApiApplicationMasterListScreenState extends State<ApiApplicationMasterListScreen> {
  @override
  Widget build(BuildContext context) {
    return GenericListScreen<ApiApplicationMaster>(
      title: 'API Application Master',
      drawerSection: DrawerSection.apiApplicationMaster,
      apiCall: (page, limit, filters) => ApiService.instance.getApiApplicationMasterList(
        page: page,
        limit: limit,
        search: filters,
      ),
      fromJson: ApiApplicationMaster.fromJson,
      searchableColumns: const [
        SearchableColumn(label: 'ID', filterId: 'id', width: 50),
        SearchableColumn(label: 'Env ID', filterId: 'env_id', width: 80),
        SearchableColumn(label: 'Env Name', filterId: 'env_name', width: 150),
        SearchableColumn(label: 'Type', filterId: 'type', width: 100),
        SearchableColumn(label: 'Status', filterId: 'status', width: 100),
        SearchableColumn(label: 'Created At', filterId: 'created_at', width: 120),
        SearchableColumn(label: 'Modified At', filterId: 'modified_at', width: 120),
      ],
      buildCells: _buildApiApplicationMasterCells,
    );
  }

  List<DataCell> _buildApiApplicationMasterCells(ApiApplicationMaster apiAppMaster) {
    return [
      DataCell(Text(apiAppMaster.id)),
      DataCell(Text(apiAppMaster.envId)),
      DataCell(Text(apiAppMaster.envName)),
      DataCell(Text(apiAppMaster.type)),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: apiAppMaster.status == 'Active'
                ? Colors.green.withValues(alpha: 0.1)
                : Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            apiAppMaster.status,
            style: TextStyle(
              color: apiAppMaster.status == 'Active' ? Colors.green : Colors.red,
              fontSize: 12,
            ),
          ),
        ),
      ),
      DataCell(Text(apiAppMaster.createdAt)),
      DataCell(Text(apiAppMaster.modifiedAt)),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove_red_eye_outlined, color: Colors.grey[600]),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ApiApplicationMasterDetailPage(apiAppMasterId: int.parse(apiAppMaster.id)),
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