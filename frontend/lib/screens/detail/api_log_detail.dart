import 'package:flutter/material.dart';
import 'package:techfour_dms_flutter_csui/models/detail/api_log_detail.dart';
import 'package:techfour_dms_flutter_csui/services/api_service.dart';
import 'package:techfour_dms_flutter_csui/widgets/common_drawer.dart';
import 'package:techfour_dms_flutter_csui/widgets/generic_detail_screen.dart';

class ApiLogDetailPage extends StatefulWidget {
  final int apiLogId;

  const ApiLogDetailPage({super.key, required this.apiLogId});

  @override
  State<ApiLogDetailPage> createState() => _ApiLogDetailPageState();
}

class _ApiLogDetailPageState extends State<ApiLogDetailPage> {
  @override
  Widget build(BuildContext context) {
    return GenericDetailScreen<ApiLogD>(
      title: 'API Log Details',
      drawerSection: DrawerSection.apiLog,
      itemId: widget.apiLogId,
      apiCall: ApiService.instance.getApiLogsDetails,
      fromJson: ApiLogD.fromJson,
      buildContent: _buildApiLogContent,
    );
  }

  Widget _buildApiLogContent(ApiLogD apiLog) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormRow([
            _buildFormGroup('ID', apiLog.id),
            _buildFormGroup('Environment ID', apiLog.envId),
            _buildFormGroup('API Name', apiLog.apiName),
          ]),
          _buildFormRow([
            _buildFormGroup('URL', apiLog.url),
            _buildFormGroup('Method', apiLog.method),
            _buildFormGroup('Status', apiLog.status),
          ]),
          _buildFormRow([
            _buildFormGroup('IP Address', apiLog.ip),
            _buildFormGroup('Created Date', apiLog.createdDate),
            _buildFormGroup('Created At', apiLog.createdAt),
          ]),
          _buildFormRow([
            _buildFormGroup('Modified At', apiLog.modifiedAt),
            _buildFormGroup('Deleted', apiLog.deleted),
            Container(), // Empty container for spacing
          ]),
          // Full width fields for longer content
          const SizedBox(height: 20),
          _buildLargeFormGroup('Request Body', apiLog.requestBody),
          const SizedBox(height: 20),
          _buildLargeFormGroup('Request Headers', apiLog.reqHeader),
          const SizedBox(height: 20),
          _buildLargeFormGroup('Response', apiLog.response),
        ],
      ),
    );
  }

  Widget _buildFormRow(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children.whereType<Widget>().map((widget) => Expanded(child: widget)).toList(),
      ),
    );
  }

  Widget _buildFormGroup(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0x66000000),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0x19000000), width: 1),
            ),
            child: Text(
              value.isEmpty ? '-' : value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF252C70),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeFormGroup(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0x66000000),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 100),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF6F6F6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0x19000000), width: 1),
          ),
          child: SelectableText(
            value.isEmpty ? '-' : value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF252C70),
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    );
  }
}