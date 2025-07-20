import 'package:flutter/material.dart';

class VisaApplicationsPage extends StatelessWidget {
  const VisaApplicationsPage({super.key});
  
  get context => null;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> visaApplications = [
      {
        'id': '#V1001',
        'name': 'Ali Reza',
        'nationality': 'Emirati',
        'destination': 'UK',
        'purpose': 'Tourism',
        'status': 'Processing'
      },
      {
        'id': '#V1002',
        'name': 'Fatima Noor',
        'nationality': 'Pakistani',
        'destination': 'Canada',
        'purpose': 'Business',
        'status': 'Approved'
      },
      {
        'id': '#V1003',
        'name': 'Mohammed Ali',
        'nationality': 'Egyptian',
        'destination': 'Germany',
        'purpose': 'Education',
        'status': 'Rejected'
      },
      {
        'id': '#V1004',
        'name': 'Zainab Hussain',
        'nationality': 'Indian',
        'destination': 'USA',
        'purpose': 'Medical Treatment',
        'status': 'Processing'
      },
      {
        'id': '#V1005',
        'name': 'Omar Said',
        'nationality': 'Jordanian',
        'destination': 'Australia',
        'purpose': 'Work',
        'status': 'Approved'
      },
      {
        'id': '#V1006',
        'name': 'Ayesha Khan',
        'nationality': 'Bangladeshi',
        'destination': 'France',
        'purpose': 'Tourism',
        'status': 'Rejected'
      },
      {
        'id': '#V1007',
        'name': 'Youssef Ibrahim',
        'nationality': 'Lebanese',
        'destination': 'Italy',
        'purpose': 'Business',
        'status': 'Approved'
      },
      {
        'id': '#V1008',
        'name': 'Laila Ahmed',
        'nationality': 'Syrian',
        'destination': 'Spain',
        'purpose': 'Family Visit',
        'status': 'Processing'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Visa Applications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 6,
        shadowColor: Colors.black26,
      ),
      backgroundColor: const Color(0xFFF3F6F9),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadowColor: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Applications Overview',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ConstrainedBox(
                              constraints:
                                  BoxConstraints(minWidth: constraints.maxWidth),
                              child: DataTable(
                                headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.teal.shade100),
                                headingTextStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                columnSpacing: 24,
                                dataRowMinHeight: 56,
                                dataRowMaxHeight: 72,
                                columns: const [
                                  DataColumn(label: Text('Application ID')),
                                  DataColumn(label: Text('Name')),
                                  DataColumn(label: Text('Nationality')),
                                  DataColumn(label: Text('Destination')),
                                  DataColumn(label: Text('Purpose')),
                                  DataColumn(label: Text('Status')),
                                  DataColumn(label: Text('Action')),
                                ],
                                rows: visaApplications.map((app) {
                                  Color statusColor;
                                  switch (app['status']) {
                                    case 'Approved':
                                      statusColor = Colors.green;
                                      break;
                                    case 'Rejected':
                                      statusColor = Colors.red;
                                      break;
                                    default:
                                      statusColor = Colors.orange;
                                  }

                                  return DataRow(cells: [
                                    DataCell(Text(app['id']!)),
                                    DataCell(Text(app['name']!)),
                                    DataCell(Text(app['nationality']!)),
                                    DataCell(Text(app['destination']!)),
                                    DataCell(Text(app['purpose']!)),
                                    DataCell(
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: statusColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          app['status']!,
                                          style: TextStyle(
                                            color: statusColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        children: [
                                          MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.teal,
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              onPressed: () {
                                                _showViewDialog(app);
                                              },
                                              child: const Text('View'),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.green,
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              onPressed: () {
                                                _updateStatus(app, 'Approved');
                                              },
                                              child: const Text('Approve'),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.red,
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              onPressed: () {
                                                _updateStatus(app, 'Rejected');
                                              },
                                              child: const Text('Disapprove'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]);
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showViewDialog(Map<String, String> app) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text('Application Details', style: TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text('Application ID: ${app['id']}'),
              Text('Name: ${app['name']}'),
              Text('Nationality: ${app['nationality']}'),
              Text('Destination: ${app['destination']}'),
              Text('Purpose: ${app['purpose']}'),
              Text('Status: ${app['status']}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  void _updateStatus(Map<String, String> app, String newStatus) {
    // Update the status of the application
    app['status'] = newStatus;
    // You may want to call setState or similar to refresh the UI if needed
  }
}