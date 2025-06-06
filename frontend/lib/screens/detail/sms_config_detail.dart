import 'package:flutter/material.dart';
import 'dart:convert';
import '../../models/detail/sms_config_detail.dart';
import '../../services/api_service.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_drawer.dart';

class SmsConfigDetailPage extends StatefulWidget {
  final int smsConfigId;

  const SmsConfigDetailPage({super.key, required this.smsConfigId});

  @override
  State<SmsConfigDetailPage> createState() => _SmsConfigDetailPageState();
}

class _SmsConfigDetailPageState extends State<SmsConfigDetailPage> {
  SmsConfigD? _smsConfig;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadSmsConfigDetail();
  }

  Future<void> _loadSmsConfigDetail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await ApiService.instance.getSmsConfigDetails(widget.smsConfigId);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          _smsConfig = SmsConfigD.fromJson(data);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load SMS configuration details: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading SMS configuration details: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      drawer: const CommonDrawer(selectedSection: DrawerSection.smsConfig),
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  'SMS Configuration Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),
            
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_errorMessage != null)
              Center(
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              )
            else if (_smsConfig != null)
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Three column responsive layout
                        LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth < 800) {
                              // Mobile layout - single column
                              return Column(
                                children: [
                                  _buildFormGroup('ID', _smsConfig!.id),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Environment ID', _smsConfig!.envId),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Sender Username', _smsConfig!.senderUsername),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Sender Password', _smsConfig!.senderPassword.isEmpty ? 'N/A' : '********'),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Sender', _smsConfig!.sender),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('License Code', _smsConfig!.licenseCode),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Auth Token', _smsConfig!.authToken.isEmpty ? 'N/A' : '********'),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Base API URL', _smsConfig!.baseApiUrl),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Type', _smsConfig!.type),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Status', _smsConfig!.status),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Created At', _smsConfig!.createdAt),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Modified At', _smsConfig!.modifiedAt),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Created By', _smsConfig!.createdBy),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Modified By', _smsConfig!.modifiedBy),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Deleted', _smsConfig!.deleted),
                                ],
                              );
                            } else {
                              // Desktop layout - three columns
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('ID', _smsConfig!.id)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Environment ID', _smsConfig!.envId)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Sender Username', _smsConfig!.senderUsername)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('Sender Password', _smsConfig!.senderPassword.isEmpty ? 'N/A' : '********')),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Sender', _smsConfig!.sender)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('License Code', _smsConfig!.licenseCode)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('Auth Token', _smsConfig!.authToken.isEmpty ? 'N/A' : '********')),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Base API URL', _smsConfig!.baseApiUrl)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Type', _smsConfig!.type)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('Status', _smsConfig!.status)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Created At', _smsConfig!.createdAt)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Modified At', _smsConfig!.modifiedAt)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('Created By', _smsConfig!.createdBy)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Modified By', _smsConfig!.modifiedBy)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Deleted', _smsConfig!.deleted)),
                                    ],
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormGroup(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value.isEmpty ? '-' : value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}