import 'package:flutter/material.dart';
import 'dart:convert';
import '../../models/detail/whatsapp_config_detail.dart';
import '../../services/api_service.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_drawer.dart';

class WhatsappConfigDetailPage extends StatefulWidget {
  final int whatsappConfigId;

  const WhatsappConfigDetailPage({super.key, required this.whatsappConfigId});

  @override
  State<WhatsappConfigDetailPage> createState() => _WhatsappConfigDetailPageState();
}

class _WhatsappConfigDetailPageState extends State<WhatsappConfigDetailPage> {
  WhatsappConfigD? _whatsappConfig;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadWhatsappConfigDetail();
  }

  Future<void> _loadWhatsappConfigDetail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await ApiService.instance.getWhatsappConfigDetails(widget.whatsappConfigId);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          _whatsappConfig = WhatsappConfigD.fromJson(data);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load WhatsApp configuration details: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading WhatsApp configuration details: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      drawer: const CommonDrawer(selectedSection: DrawerSection.whatsappConfig),
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
                  'WhatsApp Configuration Details',
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
            else if (_whatsappConfig != null)
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
                                  _buildFormGroup('ID', _whatsappConfig!.id),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Environment ID', _whatsappConfig!.envId),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('WhatsApp Phone Number ID', _whatsappConfig!.whatsappPhoneNumberId),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('WhatsApp Access Token', _whatsappConfig!.whatsappAccessToken.isEmpty ? 'N/A' : '********'),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Sender', _whatsappConfig!.sender),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('WhatsApp Vendor ID', _whatsappConfig!.whatsappVendorId),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Type', _whatsappConfig!.type),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Status', _whatsappConfig!.status),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Created At', _whatsappConfig!.createdAt),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Modified At', _whatsappConfig!.modifiedAt),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Created By', _whatsappConfig!.createdBy),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Modified By', _whatsappConfig!.modifiedBy),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Deleted', _whatsappConfig!.deleted),
                                ],
                              );
                            } else {
                              // Desktop layout - three columns
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('ID', _whatsappConfig!.id)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Environment ID', _whatsappConfig!.envId)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('WhatsApp Phone Number ID', _whatsappConfig!.whatsappPhoneNumberId)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('WhatsApp Access Token', _whatsappConfig!.whatsappAccessToken.isEmpty ? 'N/A' : '********')),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Sender', _whatsappConfig!.sender)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('WhatsApp Vendor ID', _whatsappConfig!.whatsappVendorId)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('Type', _whatsappConfig!.type)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Status', _whatsappConfig!.status)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Created At', _whatsappConfig!.createdAt)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('Modified At', _whatsappConfig!.modifiedAt)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Created By', _whatsappConfig!.createdBy)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Modified By', _whatsappConfig!.modifiedBy)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('Deleted', _whatsappConfig!.deleted)),
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