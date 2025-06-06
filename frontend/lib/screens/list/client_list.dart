import 'package:flutter/material.dart';
import 'package:techfour_dms_flutter_csui/models/list/client_list.dart';
import 'package:techfour_dms_flutter_csui/screens/detail/client_detail.dart';
import 'package:techfour_dms_flutter_csui/widgets/common_drawer.dart';
import 'package:techfour_dms_flutter_csui/widgets/generic_list_screen.dart';
import 'package:techfour_dms_flutter_csui/services/api_service.dart';

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({super.key});

  @override
  State<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  @override
  Widget build(BuildContext context) {
    return GenericListScreen<Client>(
      title: 'Clients',
      drawerSection: DrawerSection.client,
      apiCall: (page, limit, filters) => ApiService.instance.getClientList(
        page: page,
        limit: limit,
        search: filters,
      ),
      fromJson: Client.fromJson,
      searchableColumns: const [
        SearchableColumn(label: 'ID', filterId: 'id', width: 50),
        SearchableColumn(label: 'Client Name', filterId: 'client_name', width: 200),
        SearchableColumn(label: 'Status', filterId: 'status', width: 100),
        SearchableColumn(label: 'Created At', filterId: 'created_at', width: 120),
        SearchableColumn(label: 'Modified At', filterId: 'modified_at', width: 120),
        SearchableColumn(label: 'Created By', filterId: 'created_by', width: 120),
        SearchableColumn(label: 'Modified By', filterId: 'modified_by', width: 120),
      ],
      buildCells: _buildClientCells,
    );
  }

  List<DataCell> _buildClientCells(Client client) {
    return [
      DataCell(Text(client.id)),
      DataCell(Text(client.clientName)),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: client.status == 'Active'
                ? Colors.green.withValues(alpha: 0.1)
                : Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            client.status,
            style: TextStyle(
              color: client.status == 'Active' ? Colors.green : Colors.red,
              fontSize: 12,
            ),
          ),
        ),
      ),
      DataCell(Text(client.createdAt)),
      DataCell(Text(client.modifiedAt)),
      DataCell(Text(client.createdBy)),
      DataCell(Text(client.modifiedBy)),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove_red_eye_outlined, color: Colors.grey[600]),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ClientDetailPage(clientId: int.parse(client.id)),
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