import 'package:flutter/material.dart';
import 'package:techfour_dms_flutter_csui/models/list/user_list.dart';
import 'package:techfour_dms_flutter_csui/screens/detail/users_detail.dart';
import 'package:techfour_dms_flutter_csui/widgets/common_drawer.dart';
import 'package:techfour_dms_flutter_csui/widgets/generic_list_screen.dart';
import 'package:techfour_dms_flutter_csui/services/api_service.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return GenericListScreen<User>(
      title: 'Users',
      drawerSection: DrawerSection.users,
      apiCall: (page, limit, filters) => ApiService.instance.getUsersList(
        page: page,
        limit: limit,
        search: filters,
      ),
      fromJson: User.fromJson,
      searchableColumns: const [
        SearchableColumn(label: 'ID', filterId: 'id', width: 50),
        SearchableColumn(label: 'Username', filterId: 'username', width: 120),
        SearchableColumn(label: 'First Name', filterId: 'first_name', width: 120),
        SearchableColumn(label: 'Last Name', filterId: 'last_name', width: 120),
        SearchableColumn(label: 'Email ID', filterId: 'email', width: 180),
        SearchableColumn(label: 'Mobile No.', filterId: 'mobile', width: 120),
        SearchableColumn(label: 'Status', filterId: 'status', width: 100),
      ],
      buildCells: _buildUserCells,
    );
  }

  List<DataCell> _buildUserCells(User user) {
    return [
      DataCell(Text(user.id)),
      DataCell(Text(user.username)),
      DataCell(Text(user.firstName)),
      DataCell(Text(user.lastName)),
      DataCell(Text(user.email)),
      DataCell(Text(user.mobile)),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: user.status == 'Active'
                ? Colors.green.withValues(alpha: 0.1)
                : Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            user.status,
            style: TextStyle(
              color: user.status == 'Active' ? Colors.green : Colors.red,
              fontSize: 12,
            ),
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
                    builder: (context) => UserDetailsPage(userId: int.parse(user.id)),
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