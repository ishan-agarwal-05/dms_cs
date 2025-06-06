import 'package:flutter/material.dart';
import 'package:techfour_dms_flutter_csui/models/list/smtp_config_list.dart';
import 'package:techfour_dms_flutter_csui/screens/detail/smtp_config_detail.dart';
import 'package:techfour_dms_flutter_csui/widgets/common_drawer.dart';
import 'package:techfour_dms_flutter_csui/widgets/generic_list_screen.dart';
import 'package:techfour_dms_flutter_csui/services/api_service.dart';

class SmtpConfigListScreen extends StatefulWidget {
  const SmtpConfigListScreen({super.key});

  @override
  State<SmtpConfigListScreen> createState() => _SmtpConfigListScreenState();
}

class _SmtpConfigListScreenState extends State<SmtpConfigListScreen> {
  @override
  Widget build(BuildContext context) {
    return GenericListScreen<SmtpConfig>(
      title: 'SMTP Configuration',
      drawerSection: DrawerSection.smtpConfig,
      apiCall: (page, limit, filters) => ApiService.instance.getSmtpConfigList(
        page: page,
        limit: limit,
        search: filters,
      ),
      fromJson: SmtpConfig.fromJson,
      searchableColumns: const [
        SearchableColumn(label: 'ID', filterId: 'id', width: 50),
        SearchableColumn(label: 'Env ID', filterId: 'env_id', width: 80),
        SearchableColumn(label: 'Mail Host', filterId: 'mail_host', width: 150),
        SearchableColumn(label: 'Mail Port', filterId: 'mail_port', width: 80),
        SearchableColumn(label: 'Sender Email', filterId: 'sender_email', width: 180),
        SearchableColumn(label: 'Mail Username', filterId: 'mail_username', width: 150),
        SearchableColumn(label: 'Status', filterId: 'status', width: 100),
        SearchableColumn(label: 'Created At', filterId: 'created_at', width: 120),
      ],
      buildCells: _buildSmtpConfigCells,
    );
  }

  List<DataCell> _buildSmtpConfigCells(SmtpConfig smtpConfig) {
    return [
      DataCell(Text(smtpConfig.id)),
      DataCell(Text(smtpConfig.envId)),
      DataCell(Text(smtpConfig.mailHost)),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _getPortColor(smtpConfig.mailPort).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            smtpConfig.mailPort,
            style: TextStyle(
              color: _getPortColor(smtpConfig.mailPort),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      DataCell(Text(smtpConfig.senderEmail)),
      DataCell(Text(smtpConfig.mailUsername)),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: smtpConfig.status == 'Active'
                ? Colors.green.withValues(alpha: 0.1)
                : Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            smtpConfig.status,
            style: TextStyle(
              color: smtpConfig.status == 'Active' ? Colors.green : Colors.red,
              fontSize: 12,
            ),
          ),
        ),
      ),
      DataCell(Text(smtpConfig.createdAt)),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove_red_eye_outlined, color: Colors.grey[600]),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SmtpConfigDetailPage(smtpConfigId: int.parse(smtpConfig.id)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ];
  }

  Color _getPortColor(String port) {
    switch (port) {
      case '25':
        return Colors.blue; // Standard SMTP
      case '465':
        return Colors.green; // SMTP with SSL
      case '587':
        return Colors.orange; // SMTP with TLS
      case '2525':
        return Colors.purple; // Alternative SMTP
      default:
        return Colors.grey;
    }
  }
}