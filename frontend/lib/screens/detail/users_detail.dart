import 'package:flutter/material.dart';
import 'package:techfour_dms_flutter_csui/models/detail/user_detail.dart';
import 'package:techfour_dms_flutter_csui/services/api_service.dart';
import 'package:techfour_dms_flutter_csui/widgets/common_drawer.dart';
import 'package:techfour_dms_flutter_csui/widgets/generic_detail_screen.dart';

class UserDetailsPage extends StatefulWidget {
  final int userId;

  const UserDetailsPage({super.key, required this.userId});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return GenericDetailScreen<UserD>(
      title: 'User Details',
      drawerSection: DrawerSection.users,
      itemId: widget.userId,
      apiCall: ApiService.instance.getUserDetails,
      fromJson: UserD.fromJson,
      buildContent: _buildUserContent,
    );
  }

  Widget _buildUserContent(UserD user) {
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
            _buildFormGroup('First Name', user.firstName),
            _buildFormGroup('Middle Name', user.middleName),
            _buildFormGroup('Last Name', user.lastName),
          ]),
          _buildFormRow([
            _buildFormGroup('Username', user.username),
            _buildFormGroup('Email Address', user.email),
            _buildFormGroup('Mobile', user.mobile),
          ]),
          _buildFormRow([
            _buildFormGroup('Status', user.status),
            _buildFormGroup('Is Admin', user.isAdmin),
            _buildFormGroup('Web Access', user.webAccess),
          ]),
          _buildFormRow([
            _buildFormGroup('Mobile Access', user.mobileAccess),
            _buildFormGroup('Last Password Change', user.lastPasswordChange),
            _buildFormGroup('Created By', user.createdBy),
          ]),
          _buildFormRow([
            _buildFormGroup('Modified By', user.modifiedBy),
            _buildFormGroup('Deleted', user.deleted),
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