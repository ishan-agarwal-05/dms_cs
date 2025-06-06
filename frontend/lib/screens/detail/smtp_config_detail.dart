import 'package:flutter/material.dart';
import 'dart:convert';
import '../../models/detail/smtp_config_detail.dart';
import '../../services/api_service.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_drawer.dart';

class SmtpConfigDetailPage extends StatefulWidget {
  final int smtpConfigId;

  const SmtpConfigDetailPage({super.key, required this.smtpConfigId});

  @override
  State<SmtpConfigDetailPage> createState() => _SmtpConfigDetailPageState();
}

class _SmtpConfigDetailPageState extends State<SmtpConfigDetailPage> {
  SmtpConfigD? _smtpConfig;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadSmtpConfigDetail();
  }

  Future<void> _loadSmtpConfigDetail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await ApiService.instance.getSmtpConfigDetails(widget.smtpConfigId);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          _smtpConfig = SmtpConfigD.fromJson(data);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load SMTP configuration details: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading SMTP configuration details: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      drawer: const CommonDrawer(selectedSection: DrawerSection.smtpConfig),
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
                  'SMTP Configuration Details',
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
            else if (_smtpConfig != null)
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
                                  _buildFormGroup('ID', _smtpConfig!.id),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Environment ID', _smtpConfig!.envId),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Mail Host', _smtpConfig!.mailHost),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Mail Port', _smtpConfig!.mailPort),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Sender Email', _smtpConfig!.senderEmail),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Mail Username', _smtpConfig!.mailUsername),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Mail Password', _smtpConfig!.mailPassword.isEmpty ? 'N/A' : '********'),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Status', _smtpConfig!.status),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Created At', _smtpConfig!.createdAt),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Modified At', _smtpConfig!.modifiedAt),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Created By', _smtpConfig!.createdBy),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Modified By', _smtpConfig!.modifiedBy),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Deleted', _smtpConfig!.deleted),
                                ],
                              );
                            } else {
                              // Desktop layout - three columns
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('ID', _smtpConfig!.id)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Environment ID', _smtpConfig!.envId)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Mail Host', _smtpConfig!.mailHost)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('Mail Port', _smtpConfig!.mailPort)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Sender Email', _smtpConfig!.senderEmail)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Mail Username', _smtpConfig!.mailUsername)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('Mail Password', _smtpConfig!.mailPassword.isEmpty ? 'N/A' : '********')),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Status', _smtpConfig!.status)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Created At', _smtpConfig!.createdAt)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('Modified At', _smtpConfig!.modifiedAt)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Created By', _smtpConfig!.createdBy)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Modified By', _smtpConfig!.modifiedBy)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('Deleted', _smtpConfig!.deleted)),
                                      const SizedBox(width: 24),
                                      Expanded(child: Container()), // Empty space
                                      const SizedBox(width: 24),
                                      Expanded(child: Container()), // Empty space
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