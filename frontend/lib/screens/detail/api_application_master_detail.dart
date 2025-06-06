import 'package:flutter/material.dart';
import 'package:techfour_dms_flutter_csui/models/detail/api_application_master_detail.dart';
import 'package:techfour_dms_flutter_csui/services/api_service.dart';
import 'package:techfour_dms_flutter_csui/widgets/common_drawer.dart';
import 'package:techfour_dms_flutter_csui/widgets/generic_detail_screen.dart';

class ApiApplicationMasterDetailPage extends StatefulWidget {
  final int apiAppMasterId;

  const ApiApplicationMasterDetailPage({super.key, required this.apiAppMasterId});

  @override
  State<ApiApplicationMasterDetailPage> createState() => _ApiApplicationMasterDetailPageState();
}

class _ApiApplicationMasterDetailPageState extends State<ApiApplicationMasterDetailPage> {
  @override
  Widget build(BuildContext context) {
    return GenericDetailScreen<ApiApplicationMasterD>(
      title: 'API Application Master Details',
      drawerSection: DrawerSection.apiApplicationMaster,
      itemId: widget.apiAppMasterId,
      apiCall: ApiService.instance.getApiApplicationMasterDetails,
      fromJson: ApiApplicationMasterD.fromJson,
      buildContent: _buildApiApplicationMasterContent,
    );
  }

  Widget _buildApiApplicationMasterContent(ApiApplicationMasterD apiAppMaster) {
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
            _buildFormGroup('ID', apiAppMaster.id),
            _buildFormGroup('Environment ID', apiAppMaster.envId),
            _buildFormGroup('Environment Name', apiAppMaster.envName),
          ]),
          _buildFormRow([
            _buildFormGroup('Type', apiAppMaster.type),
            _buildFormGroup('Status', apiAppMaster.status),
            _buildFormGroup('Created At', apiAppMaster.createdAt),
          ]),
          _buildFormRow([
            _buildFormGroup('Modified At', apiAppMaster.modifiedAt),
            _buildFormGroup('Created By', apiAppMaster.createdBy),
            _buildFormGroup('Modified By', apiAppMaster.modifiedBy),
          ]),
          _buildFormRow([
            _buildFormGroup('Deleted', apiAppMaster.deleted),
            Container(),
            Container(),
          ]),
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
    );
  }
}