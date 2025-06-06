import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/auth/login.dart';
import '../screens/list/users_list.dart';
import '../screens/list/api_list.dart';
import '../screens/list/api_application_master_list.dart';
import '../screens/list/api_log_list.dart';
import '../screens/list/application_list.dart';
import '../screens/list/client_list.dart';
import '../screens/list/comm_queue_list.dart';
import '../screens/list/communication_list.dart';
import '../screens/list/sms_config_list.dart';
import '../screens/list/smtp_config_list.dart';
import '../screens/list/whatsapp_config_list.dart';

enum DrawerSection {
  dashboard,
  users,
  api,
  apiApplicationMaster,
  apiLog,
  application,
  client,
  commQueue,
  communication,
  smsConfig,
  smtpConfig,
  whatsappConfig,
}

// Placeholder widget for screens not yet implemented
class PlaceholderScreen extends StatelessWidget {
  final String title;
  final DrawerSection section;
  
  const PlaceholderScreen({
    super.key, 
    required this.title,
    required this.section,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color.fromARGB(255, 15, 36, 100),
        foregroundColor: Colors.white,
      ),
      drawer: CommonDrawer(selectedSection: section),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              '$title Screen',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Coming Soon...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommonDrawer extends StatefulWidget {
  final DrawerSection selectedSection;
  final bool isCommunicationServiceExpanded;

  const CommonDrawer({
    super.key,
    required this.selectedSection,
    this.isCommunicationServiceExpanded = true,
  });

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  late bool _isCommunicationServiceExpanded;

  @override
  void initState() {
    super.initState();
    _isCommunicationServiceExpanded = widget.isCommunicationServiceExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Image.asset(
                'assets/images/techfour.png',
                width: 150,
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
          ),
          _buildDrawerItem(
            Icons.dashboard,
            'Dashboard',
            isSelected: widget.selectedSection == DrawerSection.dashboard,
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => const UserManagementScreen()));
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.cloud, color: Colors.grey[800]),
            title: Text(
              'Communication Service',
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            trailing: Icon(
              _isCommunicationServiceExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              color: Colors.grey[800],
            ),
            onExpansionChanged: (bool expanded) {
              setState(() {
                _isCommunicationServiceExpanded = expanded;
              });
            },
            initiallyExpanded: _isCommunicationServiceExpanded,
            children: <Widget>[
              _buildSubDrawerItem(
                Icons.people,
                'Users',
                isSelected: widget.selectedSection == DrawerSection.users,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => const UserManagementScreen()));
                },
              ),
              _buildSubDrawerItem(
                Icons.api,
                'API Management',
                isSelected: widget.selectedSection == DrawerSection.api,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => const ApiListScreen()));
                },
              ),
              _buildSubDrawerItem(
                Icons.settings_applications,
                'API Application Master',
                isSelected: widget.selectedSection == DrawerSection.apiApplicationMaster,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => const ApiApplicationMasterListScreen()));
                },
              ),
              _buildSubDrawerItem(
                Icons.history,
                'API Logs',
                isSelected: widget.selectedSection == DrawerSection.apiLog,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => const ApiLogListScreen()));
                },
              ),
              _buildSubDrawerItem(
                Icons.apps,
                'Applications',
                isSelected: widget.selectedSection == DrawerSection.application,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => const ApplicationListScreen()));
                },
              ),
              _buildSubDrawerItem(
                Icons.business,
                'Clients',
                isSelected: widget.selectedSection == DrawerSection.client,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => const ClientListScreen()));
                },
              ),
              _buildSubDrawerItem(
                Icons.queue,
                'Communication Queue',
                isSelected: widget.selectedSection == DrawerSection.commQueue,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => const CommQueueListScreen()));
                },
              ),
              _buildSubDrawerItem(
                Icons.chat,
                'Communication',
                isSelected: widget.selectedSection == DrawerSection.communication,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => const CommunicationListScreen()));
                },
              ),
              _buildSubDrawerItem(
                Icons.sms,
                'SMS Configuration',
                isSelected: widget.selectedSection == DrawerSection.smsConfig,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => const SmsConfigListScreen()));
                },
              ),
              _buildSubDrawerItem(
                Icons.email,
                'SMTP Configuration',
                isSelected: widget.selectedSection == DrawerSection.smtpConfig,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => const SmtpConfigListScreen()));
                },
              ),
              _buildSubDrawerItem(
                Icons.chat_bubble,
                'WhatsApp Configuration',
                isSelected: widget.selectedSection == DrawerSection.whatsappConfig,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => const WhatsappConfigListScreen()));
                },
              ),
            ],
          ),
          _buildDrawerItem(
            Icons.logout,
            'Logout',
            iconColor: Colors.redAccent,
            textColor: Colors.redAccent,
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('authToken');

              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(
    IconData icon,
    String title, {
    bool isSelected = false,
    Color? iconColor,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? (isSelected ? const Color.fromARGB(255, 15, 36, 100) : Colors.grey[800]),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? (isSelected ? const Color.fromARGB(255, 15, 36, 100) : Colors.grey[800]),
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          fontSize: 16,
        ),
      ),
      tileColor: isSelected ? const Color.fromARGB(255, 15, 36, 100).withValues(alpha: 0.1) : null,
      onTap: () {
        if (MediaQuery.of(context).size.width < 800) {
          Navigator.pop(context);
        }
        onTap?.call();
      },
    );
  }

  ListTile _buildSubDrawerItem(
    IconData icon,
    String title, {
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 56.0),
      leading: Icon(icon, color: isSelected ? const Color.fromARGB(255, 15, 36, 100) : Colors.grey[700]),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? const Color.fromARGB(255, 15, 36, 100) : Colors.grey[700],
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          fontSize: 15,
        ),
      ),
      tileColor: isSelected ? const Color.fromARGB(255, 15, 36, 100).withValues(alpha: 0.1) : null,
      onTap: () {
        if (MediaQuery.of(context).size.width < 800) {
          Navigator.pop(context);
        }
        onTap?.call();
      },
    );
  }
}