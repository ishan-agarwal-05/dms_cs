import 'package:flutter/material.dart';

class CommonPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final VoidCallback onFirstPage;
  final VoidCallback onPreviousPage;
  final VoidCallback onNextPage;
  final VoidCallback onLastPage;

  const CommonPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.onFirstPage,
    required this.onPreviousPage,
    required this.onNextPage,
    required this.onLastPage,
  });

  @override
  Widget build(BuildContext context) {
    final int startItem = (currentPage - 1) * itemsPerPage + 1;
    final int endItem = currentPage * itemsPerPage > totalItems ? totalItems : currentPage * itemsPerPage;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Items per page: $itemsPerPage',
            style: const TextStyle(fontSize: 14),
          ),
          Row(
            children: [
              Text(
                '$startItem-$endItem of $totalItems',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.first_page),
                onPressed: currentPage > 1 ? onFirstPage : null,
                tooltip: 'First page',
              ),
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: currentPage > 1 ? onPreviousPage : null,
                tooltip: 'Previous page',
              ),
              Text(
                '$currentPage of $totalPages',
                style: const TextStyle(fontSize: 14),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: currentPage < totalPages ? onNextPage : null,
                tooltip: 'Next page',
              ),
              IconButton(
                icon: const Icon(Icons.last_page),
                onPressed: currentPage < totalPages ? onLastPage : null,
                tooltip: 'Last page',
              ),
            ],
          ),
        ],
      ),
    );
  }
}