import 'package:flutter/material.dart';
import 'package:techfour_dms_flutter_csui/widgets/common_app_bar.dart';
import 'package:techfour_dms_flutter_csui/widgets/common_drawer.dart';
import 'package:techfour_dms_flutter_csui/widgets/common_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techfour_dms_flutter_csui/screens/auth/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchableColumn {
  final String label;
  final String filterId;
  final double width;
  final Widget? customSearchWidget;
  final TextAlign textAlign;

  const SearchableColumn({
    required this.label,
    required this.filterId,
    this.width = 120,
    this.customSearchWidget,
    this.textAlign = TextAlign.start,
  });
}

class GenericListScreen<T> extends StatefulWidget {
  final String title;
  final DrawerSection drawerSection;
  final Future<http.Response> Function(int page, int limit, Map<String, dynamic>? filters) apiCall;
  final T Function(Map<String, dynamic> json) fromJson;
  final List<SearchableColumn> searchableColumns;
  final List<DataCell> Function(T item) buildCells;
  final Widget Function(T item)? onItemTap;
  
  const GenericListScreen({
    super.key,
    required this.title,
    required this.drawerSection,
    required this.apiCall,
    required this.fromJson,
    required this.searchableColumns,
    required this.buildCells,
    this.onItemTap,
  });

  @override
  State<GenericListScreen<T>> createState() => _GenericListScreenState<T>();
}

class _GenericListScreenState<T> extends State<GenericListScreen<T>> {
  // Pagination State Variables
  int _currentPage = 1;
  final int _itemsPerPage = 5;
  List<T> _displayedItems = [];

  // API related state variables
  bool _isLoading = false;
  String? _errorMessage;
  int _totalItems = 0;
  int _totalPages = 0;

  // Search filters and controllers
  final Map<String, dynamic> _filters = {};
  final Map<String, TextEditingController> _searchControllers = {};
  final Map<String, dynamic> _dropdownValues = {};

  @override
  void initState() {
    super.initState();
    _initializeSearchControllers();
    _fetchDataFromApi();
  }

  void _initializeSearchControllers() {
    for (final column in widget.searchableColumns) {
      _searchControllers[column.filterId] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final controller in _searchControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // Helper method to retrieve the auth token
  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  // Generic method to fetch data from API
  Future<void> _fetchDataFromApi() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Check if auth token exists
    final String? authToken = await getAuthToken();
    
    if (authToken == null) {
      setState(() {
        _errorMessage = 'Authentication token not found. Please log in again.';
        _isLoading = false;
      });

      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
      return;
    }

    try {
      _updateFiltersFromControllers();
      final response = await widget.apiCall(_currentPage, _itemsPerPage, _filters.isNotEmpty ? _filters : null);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Parse the list of items
        final List<dynamic> itemDataList = responseData['data'];
        final List<T> fetchedItems = itemDataList.map((json) => widget.fromJson(json)).toList();

        setState(() {
          _displayedItems = fetchedItems;
          _totalItems = responseData['totalItems'] ?? 0;
          _totalPages = responseData['totalPages'] ?? 0;
          _isLoading = false;
        });
      } else if (response.statusCode == 401) {
        setState(() {
          _errorMessage = 'Your session has expired. Please log in again.';
          _isLoading = false;
        });

        if (mounted) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
        }
      } else {
        final errorData = jsonDecode(response.body);
        setState(() {
          _errorMessage = 'Failed to load ${widget.title.toLowerCase()}: ${errorData['error'] ?? response.statusCode}';
          _isLoading = false;
          _displayedItems = [];
          _totalItems = 0;
          _totalPages = 0;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: Could not connect to the server. ${e.toString()}';
        _isLoading = false;
        _displayedItems = [];
        _totalItems = 0;
        _totalPages = 0;
      });
    }
  }

  void _updateFiltersFromControllers() {
    _filters.clear();
    for (final entry in _searchControllers.entries) {
      if (entry.value.text.isNotEmpty) {
        _filters[entry.key] = entry.value.text;
      }
    }
    for (final entry in _dropdownValues.entries) {
      if (entry.value != null) {
        _filters[entry.key] = entry.value;
      }
    }
  }

  void _applySearchFilters() {
    _currentPage = 1;
    _fetchDataFromApi();
  }

  // Pagination Methods
  void _goToFirstPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage = 1;
        _fetchDataFromApi();
      });
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
        _fetchDataFromApi();
      });
    }
  }

  void _goToNextPage() {
    if (_currentPage < _totalPages) {
      setState(() {
        _currentPage++;
        _fetchDataFromApi();
      });
    }
  }

  void _goToLastPage() {
    if (_currentPage < _totalPages) {
      setState(() {
        _currentPage = _totalPages;
        _fetchDataFromApi();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      drawer: CommonDrawer(selectedSection: widget.drawerSection),
      backgroundColor: Colors.grey[50],
      body: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                if (_isLoading)
                  const Expanded(child: Center(child: CircularProgressIndicator()))
                else if (_errorMessage != null)
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: _buildDataTable(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              '$_totalItems ${widget.title}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: DataTable(
                    columnSpacing: 30.0,
                    dataRowMaxHeight: 50.0,
                    headingRowHeight: 80.0,
                    headingTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 15, 36, 100),
                    ),
                    columns: _buildSearchableColumns(),
                    rows: _displayedItems.map((item) {
                      return DataRow(
                        cells: widget.buildCells(item),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          CommonPagination(
            currentPage: _currentPage,
            totalPages: _totalPages,
            totalItems: _totalItems,
            itemsPerPage: _itemsPerPage,
            onFirstPage: _goToFirstPage,
            onPreviousPage: _goToPreviousPage,
            onNextPage: _goToNextPage,
            onLastPage: _goToLastPage,
          ),
        ],
      ),
    );
  }

  List<DataColumn> _buildSearchableColumns() {
    final columns = <DataColumn>[];
    
    for (final column in widget.searchableColumns) {
      columns.add(DataColumn(
        label: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(column.label),
            const SizedBox(height: 5),
            column.customSearchWidget ?? _buildSearchTextField(
              _searchControllers[column.filterId]!,
              width: column.width,
              textAlign: column.textAlign,
            ),
          ],
        ),
      ));
    }
    
    // Add Actions column with search button
    columns.add(DataColumn(
      label: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Actions'),
          const SizedBox(height: 5),
          SizedBox(
            height: 25,
            child: ElevatedButton(
              onPressed: _applySearchFilters,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                textStyle: const TextStyle(fontSize: 12),
                minimumSize: Size.zero,
              ),
              child: const Text('Search'),
            ),
          ),
        ],
      ),
    ));
    
    return columns;
  }

  Widget _buildSearchTextField(
    TextEditingController controller, {
    double width = 120,
    TextAlign textAlign = TextAlign.start,
  }) {
    return SizedBox(
      width: width,
      height: 30,
      child: TextField(
        controller: controller,
        textAlign: textAlign,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 0.0,
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2.0,
            ),
          ),
        ),
        onSubmitted: (_) => _applySearchFilters(),
      ),
    );
  }

  Widget buildDropdownSearch({
    required String filterId,
    required List<String> options,
    double width = 100,
    String hint = 'Select',
  }) {
    return SizedBox(
      width: width,
      height: 30,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _dropdownValues[filterId],
          hint: Text(hint, style: TextStyle(color: Colors.grey[400], fontSize: 13)),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          isDense: true,
          onChanged: (String? newValue) {
            setState(() {
              _dropdownValues[filterId] = newValue;
              _applySearchFilters();
            });
          },
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}