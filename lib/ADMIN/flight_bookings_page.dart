import 'package:flutter/material.dart';

class FlightBookingsPage extends StatelessWidget {
  const FlightBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flight Bookings',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        elevation: 4,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF4F6F8),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 8, // Increased elevation for a more pronounced shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // More rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20), // Increased padding
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Booking Records',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.teal), // Increased font size and changed color
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
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
                                headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.teal.shade100,
                                ),
                                columns: const [
                                  DataColumn(label: Text('Booking ID', style: TextStyle(fontWeight: FontWeight.bold))),
                                  DataColumn(label: Text('Customer Name', style: TextStyle(fontWeight: FontWeight.bold))),
                                  DataColumn(label: Text('From', style: TextStyle(fontWeight: FontWeight.bold))),
                                  DataColumn(label: Text('To', style: TextStyle(fontWeight: FontWeight.bold))),
                                  DataColumn(label: Text('Departure', style: TextStyle(fontWeight: FontWeight.bold))),
                                  DataColumn(label: Text('Return', style: TextStyle(fontWeight: FontWeight.bold))),
                                  DataColumn(label: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold))),
                                  DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                                  DataColumn(label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
                                ],
                                rows: [
                                  _buildFlightRow(
                                    id: '#F001',
                                    name: 'Juan Dela Cruz',
                                    from: 'Manila',
                                    to: 'Tokyo',
                                    departure: '2025-08-10',
                                    returnDate: '2025-08-20',
                                    amount: 'PHP 18,500',
                                    status: 'Confirmed',
                                    statusColor: Colors.green,
                                  ),
                                  _buildFlightRow(
                                    id: '#F002',
                                    name: 'Maria Santos',
                                    from: 'Cebu',
                                    to: 'Singapore',
                                    departure: '2025-09-01',
                                    returnDate: '2025-09-07',
                                    amount: 'PHP 12,000',
                                    status: 'Pending',
                                    statusColor: Colors.orange,
                                  ),
                                  _buildFlightRow(
                                    id: '#F003',
                                    name: 'Pedro Garcia',
                                    from: 'Davao',
                                    to: 'Hong Kong',
                                    departure: '2025-08-25',
                                    returnDate: '2025-09-01',
                                    amount: 'PHP 14,200',
                                    status: 'Cancelled',
                                    statusColor: Colors.red,
                                  ),
                                  _buildFlightRow(
                                    id: '#F004',
                                    name: 'Andrea Mendoza',
                                    from: 'Clark',
                                    to: 'Dubai',
                                    departure: '2025-10-05',
                                    returnDate: '2025-10-15',
                                    amount: 'PHP 22,000',
                                    status: 'Confirmed',
                                    statusColor: Colors.green,
                                  ),
                                  _buildFlightRow(
                                    id: '#F005',
                                    name: 'Luis Navarro',
                                    from: 'Iloilo',
                                    to: 'Seoul',
                                    departure: '2025-11-10',
                                    returnDate: '2025-11-20',
                                    amount: 'PHP 19,800',
                                    status: 'Pending',
                                    statusColor: Colors.orange,
                                  ),
                                  _buildFlightRow(
                                    id: '#F006',
                                    name: 'Erika Lim',
                                    from: 'Manila',
                                    to: 'Bangkok',
                                    departure: '2025-08-30',
                                    returnDate: '2025-09-05',
                                    amount: 'PHP 13,900',
                                    status: 'Confirmed',
                                    statusColor: Colors.green,
                                  ),
                                  _buildFlightRow(
                                    id: '#F007',
                                    name: 'Carlos Rivera',
                                    from: 'Cebu',
                                    to: 'Kuala Lumpur',
                                    departure: '2025-09-12',
                                    returnDate: '2025-09-18',
                                    amount: 'PHP 15,300',
                                    status: 'Cancelled',
                                    statusColor: Colors.red,
                                  ),
                                  _buildFlightRow(
                                    id: '#F008',
                                    name: 'Isabel Cruz',
                                    from: 'Davao',
                                    to: 'Sydney',
                                    departure: '2025-12-01',
                                    returnDate: '2025-12-15',
                                    amount: 'PHP 28,500',
                                    status: 'Confirmed',
                                    statusColor: Colors.green,
                                  ),
                                ],
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

  DataRow _buildFlightRow({
    required String id,
    required String name,
    required String from,
    required String to,
    required String departure,
    required String returnDate,
    required String amount,
    required String status,
    required Color statusColor,
  }) {
    return DataRow(
      cells: [
        DataCell(Text(id)),
        DataCell(Text(name)),
        DataCell(Text(from)),
        DataCell(Text(to)),
        DataCell(Text(departure)),
        DataCell(Text(returnDate)),
        DataCell(Text(amount)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
              style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataCell(
          TextButton(
            onPressed: () {},
            child: const Text(
              'View',
              style: TextStyle(color: Colors.teal),
            ),
          ),
        ),
      ],
    );
  }
}