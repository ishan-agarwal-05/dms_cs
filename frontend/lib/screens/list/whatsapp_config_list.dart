import 'package:flutter/material.dart';
import 'package:techfour_dms_flutter_csui/models/list/whatsapp_config_list.dart';
import 'package:techfour_dms_flutter_csui/screens/detail/whatsapp_config_detail.dart';
import 'package:techfour_dms_flutter_csui/widgets/common_drawer.dart';
import 'package:techfour_dms_flutter_csui/widgets/generic_list_screen.dart';
import 'package:techfour_dms_flutter_csui/services/api_service.dart';

class WhatsappConfigListScreen extends StatefulWidget {
  const WhatsappConfigListScreen({super.key});

  @override
  State<WhatsappConfigListScreen> createState() => _WhatsappConfigListScreenState();
}

class _WhatsappConfigListScreenState extends State<WhatsappConfigListScreen> {
  @override
  Widget build(BuildContext context) {
    return GenericListScreen<WhatsappConfig>(
      title: 'WhatsApp Configuration',
      drawerSection: DrawerSection.whatsappConfig,
      apiCall: (page, limit, filters) => ApiService.instance.getWhatsappConfigList(
        page: page,
        limit: limit,
        search: filters,
      ),
      fromJson: WhatsappConfig.fromJson,
      searchableColumns: const [
        SearchableColumn(label: 'ID', filterId: 'id', width: 50),
        SearchableColumn(label: 'Env ID', filterId: 'env_id', width: 80),
        SearchableColumn(label: 'Phone Number ID', filterId: 'whatsapp_phone_number_id', width: 150),
        SearchableColumn(label: 'Sender', filterId: 'sender', width: 120),
        SearchableColumn(label: 'Vendor ID', filterId: 'whatsapp_vendor_id', width: 120),
        SearchableColumn(label: 'Type', filterId: 'type', width: 100),
        SearchableColumn(label: 'Status', filterId: 'status', width: 100),
        SearchableColumn(label: 'Created At', filterId: 'created_at', width: 120),
      ],
      buildCells: _buildWhatsappConfigCells,
    );
  }

  List<DataCell> _buildWhatsappConfigCells(WhatsappConfig whatsappConfig) {
    return [
      DataCell(Text(whatsappConfig.id)),
      DataCell(Text(whatsappConfig.envId)),
      DataCell(Text(whatsappConfig.whatsappPhoneNumberId)),
      DataCell(Text(whatsappConfig.sender)),
      DataCell(Text(whatsappConfig.whatsappVendorId)),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _getTypeColor(whatsappConfig.type).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            whatsappConfig.type,
            style: TextStyle(
              color: _getTypeColor(whatsappConfig.type),
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
            color: whatsappConfig.status == 'Active'
                ? Colors.green.withValues(alpha: 0.1)
                : Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            whatsappConfig.status,
            style: TextStyle(
              color: whatsappConfig.status == 'Active' ? Colors.green : Colors.red,
              fontSize: 12,
            ),
          ),
        ),
      ),
      DataCell(Text(whatsappConfig.createdAt)),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove_red_eye_outlined, color: Colors.grey[600]),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WhatsappConfigDetailPage(whatsappConfigId: int.parse(whatsappConfig.id)),
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
      case 'business':
        return Colors.blue;
      case 'api':
        return Colors.green;
      case 'webhook':
        return Colors.orange;
      case 'template':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}