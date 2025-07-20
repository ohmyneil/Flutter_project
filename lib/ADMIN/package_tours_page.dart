import 'package:flutter/material.dart';

class PackageToursPage extends StatelessWidget {
  const PackageToursPage({super.key});

  // Example user-submitted data
  final List<Map<String, dynamic>> packageTours = const [
    {
      'bookingId': '#PT001',
      'customer': 'Ali Ahmed',
      'package': 'European Tour',
      'destination': 'Paris, Rome, Berlin',
      'amount': 'AED 12,000',
      'status': 'Confirmed',
      'statusColor': Colors.green,
      'date': '2025-07-12',
    },
    {
      'bookingId': '#PT002',
      'customer': 'Sara Khan',
      'package': 'Asia Delight',
      'destination': 'Tokyo, Seoul, Bangkok',
      'amount': 'AED 9,500',
      'status': 'Pending',
      'statusColor': Colors.orange,
      'date': '2025-07-10',
    },
    {
      'bookingId': '#PT003',
      'customer': 'Mohamed Hassan',
      'package': 'Desert Safari',
      'destination': 'Dubai, Abu Dhabi',
      'amount': 'AED 4,500',
      'status': 'Cancelled',
      'statusColor': Colors.red,
      'date': '2025-07-08',
    },
    {
      'bookingId': '#PT004',
      'customer': 'Lara Mendoza',
      'package': 'Bali Escape',
      'destination': 'Bali, Indonesia',
      'amount': 'AED 6,800',
      'status': 'Confirmed',
      'statusColor': Colors.green,
      'date': '2025-07-15',
    },
    {
      'bookingId': '#PT005',
      'customer': 'John Smith',
      'package': 'Mediterranean Cruise',
      'destination': 'Greece, Italy, Spain',
      'amount': 'AED 14,200',
      'status': 'Pending',
      'statusColor': Colors.orange,
      'date': '2025-07-20',
    },
    {
      'bookingId': '#PT006',
      'customer': 'Aisha Binte',
      'package': 'African Safari',
      'destination': 'Kenya, Tanzania',
      'amount': 'AED 11,000',
      'status': 'Confirmed',
      'statusColor': Colors.green,
      'date': '2025-07-18',
    },
    {
      'bookingId': '#PT007',
      'customer': 'Carlos Dizon',
      'package': 'Canadian Rockies',
      'destination': 'Banff, Jasper',
      'amount': 'AED 10,300',
      'status': 'Cancelled',
      'statusColor': Colors.red,
      'date': '2025-07-22',
    },
    {
      'bookingId': '#PT008',
      'customer': 'Nina Rosario',
      'package': 'Australia Discovery',
      'destination': 'Sydney, Melbourne',
      'amount': 'AED 13,750',
      'status': 'Confirmed',
      'statusColor': Colors.green,
      'date': '2025-07-25',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: const Text('Package Tours'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Section Header with Icon
                  Row(
                    children: const [
                      Icon(Icons.card_travel, color: Colors.teal),
                      SizedBox(width: 8),
                      Text(
                        'Tour Bookings Overview',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(minWidth: constraints.maxWidth),
                              child: DataTable(
                                columnSpacing: 24,
                                dataRowMinHeight: 56,
                                dataRowMaxHeight: 72,
                                headingRowColor: MaterialStateColor.resolveWith((states) => Colors.teal.shade50),
                                headingTextStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                                columns: const [
                                  DataColumn(label: Text('Booking ID')),
                                  DataColumn(label: Text('Customer')),
                                  DataColumn(label: Text('Package')),
                                  DataColumn(label: Text('Destination')),
                                  DataColumn(label: Text('Amount')),
                                  DataColumn(label: Text('Status')),
                                  DataColumn(label: Text('Date')),
                                  DataColumn(label: Text('Action')),
                                ],
                                rows: packageTours.map((tour) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(tour['bookingId'])),
                                      DataCell(Text(tour['customer'])),
                                      DataCell(Text(tour['package'])),
                                      DataCell(Text(tour['destination'])),
                                      DataCell(Text(tour['amount'])),
                                      DataCell(
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: (tour['statusColor'] as Color).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            tour['status'],
                                            style: TextStyle(
                                              color: tour['statusColor'],
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(Text(tour['date'])),
                                      DataCell(
                                        TextButton(
                                          onPressed: () {
                                            _showViewDialog(context, tour);
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.teal,
                                          ),
                                          child: const Text('View'),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showViewDialog(BuildContext context, Map<String, dynamic> tour) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text('Tour Details', style: TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text('Booking ID: ${tour['bookingId']}'),
              Text('Customer: ${tour['customer']}'),
              Text('Package: ${tour['package']}'),
              Text('Destination: ${tour['destination']}'),
              Text('Amount: ${tour['amount']}'),
              Text('Status: ${tour['status']}'),
              Text('Date: ${tour['date']}'),
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
}