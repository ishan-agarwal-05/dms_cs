import 'package:flutter/material.dart';
import 'dart:convert';
import '../../models/detail/application_detail.dart';
import '../../services/api_service.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_drawer.dart';

class ApplicationDetailPage extends StatefulWidget {
  final int applicationId;

  const ApplicationDetailPage({super.key, required this.applicationId});

  @override
  State<ApplicationDetailPage> createState() => _ApplicationDetailPageState();
}

class _ApplicationDetailPageState extends State<ApplicationDetailPage> {
  ApplicationD? _application;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadApplicationDetail();
  }

  Future<void> _loadApplicationDetail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await ApiService.instance.getApplicationDetails(widget.applicationId);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          _application = ApplicationD.fromJson(data);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load application details: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading application details: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      drawer: const CommonDrawer(selectedSection: DrawerSection.application),
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
                  'Application Details',
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
            else if (_application != null)
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
                                  _buildFormGroup('ID', _application!.id),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Environment ID', _application!.envId),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Client ID', _application!.clientId),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Environment Name', _application!.envName),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Code', _application!.code),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Status', _application!.status),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Retry Attempts', _application!.retryAttempts),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Created At', _application!.createdAt),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Modified At', _application!.modifiedAt),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Created By', _application!.createdBy),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Modified By', _application!.modifiedBy),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Deleted', _application!.deleted),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('App API Config', _application!.appApiConfig),
                                ],
                              );
                            } else {
                              // Desktop layout - three columns
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('ID', _application!.id)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Environment ID', _application!.envId)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Client ID', _application!.clientId)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('Environment Name', _application!.envName)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Code', _application!.code)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Status', _application!.status)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('Retry Attempts', _application!.retryAttempts)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Created At', _application!.createdAt)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Modified At', _application!.modifiedAt)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('Created By', _application!.createdBy)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Modified By', _application!.modifiedBy)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Deleted', _application!.deleted)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('App API Config', _application!.appApiConfig)),
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