import 'package:flutter/material.dart';

class TableStatsCard extends StatelessWidget {
  static const TextStyle _cardTitleStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    height: 1.27,
    color: Colors.black,
  );

  static const BoxDecoration _tableRowBorder = BoxDecoration(
    border: Border(
      bottom: BorderSide(color: Colors.black26),
    ),
  );

  final String title;
  final List<String> headers;
  final List<List<String>> rows;

  const TableStatsCard({
    super.key,
    required this.title,
    required this.headers,
    required this.rows,
  });

  Widget _buildTableContent() {
    final List<TableRow> tableRowList = [];
    tableRowList.add(
      TableRow(
        children: headers.map((header) => Text(header)).toList(),
        decoration: _tableRowBorder,
      ),
    );
    for (int i = 0; i < rows.length; i++) {
      final bool isLastRow = (i == rows.length - 1);
      tableRowList.add(
        TableRow(
          decoration: isLastRow ? null : _tableRowBorder,
          children: rows[i].map((cell) => Text(cell)).toList(),
        ),
      );
    }
    return Table(
      children: tableRowList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: _cardTitleStyle),
            const SizedBox(height: 10),
            _buildTableContent(),
          ],
        ),
      ),
    );
  }
}