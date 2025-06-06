import 'package:flutter/material.dart';
import 'package:techfour_dms_flutter_csui/models/list/api_list.dart';
import 'package:techfour_dms_flutter_csui/screens/detail/api_detail.dart';
import 'package:techfour_dms_flutter_csui/widgets/common_drawer.dart';
import 'package:techfour_dms_flutter_csui/widgets/generic_list_screen.dart';
import 'package:techfour_dms_flutter_csui/services/api_service.dart';

class ApiListScreen extends StatefulWidget {
  const ApiListScreen({super.key});

  @override
  State<ApiListScreen> createState() => _ApiListScreenState();
}

class _ApiListScreenState extends State<ApiListScreen> {
  @override
  Widget build(BuildContext context) {
    return GenericListScreen<Api>(
      title: 'API Management',
      drawerSection: DrawerSection.api,
      apiCall: (page, limit, filters) => ApiService.instance.getApiList(
        page: page,
        limit: limit,
        search: filters,
      ),
      fromJson: Api.fromJson,
      searchableColumns: const [
        SearchableColumn(label: 'ID', filterId: 'id', width: 50),
        SearchableColumn(label: 'App API', filterId: 'app_api', width: 150),
        SearchableColumn(label: 'Status', filterId: 'status', width: 80),
        SearchableColumn(label: 'Created At', filterId: 'createdAt', width: 120),
        SearchableColumn(label: 'Modified At', filterId: 'modifiedAt', width: 120),
        SearchableColumn(label: 'Created By', filterId: 'createdBy', width: 100),
        SearchableColumn(label: 'Modified By', filterId: 'modifiedBy', width: 100),
      ],
      buildCells: _buildApiCells,
    );
  }

  List<DataCell> _buildApiCells(Api api) {
    return [
      DataCell(Text(api.id)),
      DataCell(Text(api.appApi)),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: api.status == 'Active'
                ? Colors.green.withValues(alpha: 0.1)
                : Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            api.status,
            style: TextStyle(
              color: api.status == 'Active' ? Colors.green : Colors.red,
              fontSize: 12,
            ),
          ),
        ),
      ),
      DataCell(Text(api.createdAt)),
      DataCell(Text(api.modifiedAt)),
      DataCell(Text(api.createdBy)),
      DataCell(Text(api.modifiedBy)),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove_red_eye_outlined, color: Colors.grey[600]),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ApiDetailPage(apiId: int.parse(api.id)),
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