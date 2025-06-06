import 'package:flutter/material.dart';
import 'dart:convert';
import '../../models/detail/comm_queue_detail.dart';
import '../../services/api_service.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_drawer.dart';

class CommQueueDetailPage extends StatefulWidget {
  final int commQueueId;

  const CommQueueDetailPage({super.key, required this.commQueueId});

  @override
  State<CommQueueDetailPage> createState() => _CommQueueDetailPageState();
}

class _CommQueueDetailPageState extends State<CommQueueDetailPage> {
  CommQueueD? _commQueue;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCommQueueDetail();
  }

  Future<void> _loadCommQueueDetail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await ApiService.instance.getCommQueueDetails(widget.commQueueId);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          _commQueue = CommQueueD.fromJson(data);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load communication queue details: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading communication queue details: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      drawer: const CommonDrawer(selectedSection: DrawerSection.commQueue),
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
                  'Communication Queue Details',
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
            else if (_commQueue != null)
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
                                  _buildFormGroup('ID', _commQueue!.id),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Environment ID', _commQueue!.envId),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Communication ID', _commQueue!.commId),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Reference ID', _commQueue!.refId),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Module', _commQueue!.module),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Sender ID', _commQueue!.senderId),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Type', _commQueue!.type),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Subject', _commQueue!.subject),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('To', _commQueue!.to),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('CC', _commQueue!.cc),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Status', _commQueue!.status),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Attempts', _commQueue!.attempts),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Attempts Left', _commQueue!.attemptsLeft),
                                  const SizedBox(height: 16),
                                  _buildFormGroup('Created At', _commQueue!.createdAt),
                                ],
                              );
                            } else {
                              // Desktop layout - three columns
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('ID', _commQueue!.id)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Environment ID', _commQueue!.envId)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Communication ID', _commQueue!.commId)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('Reference ID', _commQueue!.refId)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Module', _commQueue!.module)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Sender ID', _commQueue!.senderId)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('Type', _commQueue!.type)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Subject', _commQueue!.subject)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('To', _commQueue!.to)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('CC', _commQueue!.cc)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Status', _commQueue!.status)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Attempts', _commQueue!.attempts)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: _buildFormGroup('Attempts Left', _commQueue!.attemptsLeft)),
                                      const SizedBox(width: 24),
                                      Expanded(child: _buildFormGroup('Created At', _commQueue!.createdAt)),
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