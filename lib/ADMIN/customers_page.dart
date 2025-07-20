import 'package:flutter/material.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Customers',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.teal[700],
        elevation: 4,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.people, color: Colors.teal, size: 28),
                          SizedBox(width: 10),
                          Text(
                            'Customer List',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20, thickness: 1.5),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            color: Colors.white,
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
                                    headingRowColor: MaterialStateProperty.all(Colors.teal[100]),
                                    columns: const [
                                      DataColumn(label: Text('Customer ID')),
                                      DataColumn(label: Text('Name')),
                                      DataColumn(label: Text('Email')),
                                      DataColumn(label: Text('Phone')),
                                      DataColumn(label: Text('Nationality')),
                                      DataColumn(label: Text('Action')),
                                    ],
                                    rows: _buildCustomerRows(context),
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
              ),
            ),
          );
        },
      ),
    );
  }

  List<DataRow> _buildCustomerRows(BuildContext context) {
    final customers = [
      {
        'id': 'CU001',
        'name': 'Jonathan Mainot',
        'email': 'jona@email.com',
        'phone': '+971 50 1234567',
        'nationality': 'Philippines',
      },
      {
        'id': 'CU002',
        'name': 'Neil Ivan Tanamor',
        'email': 'neil.ivan@email.com',
        'phone': '+971 52 6543210',
        'nationality': 'UAE',
      },
      {
        'id': 'CU003',
        'name': 'James Trinidad',
        'email': 'james@email.com',
        'phone': '+971 55 7891234',
        'nationality': 'Egypt',
      },
      {
        'id': 'CU004',
        'name': 'Ninoy Hitman',
        'email': 'bangbang@email.com',
        'phone': '+971 56 3219876',
        'nationality': 'Lebanon',
      },
      {
        'id': 'CU005',
        'name': 'Pedro Calungsod',
        'email': 'pedro@email.com',
        'phone': '+63 917 555 1234',
        'nationality': 'Philippines',
      },
      {
        'id': 'CU006',
        'name': 'Angelo Corre',
        'email': 'gelo@email.com',
        'phone': '+34 612 987 654',
        'nationality': 'Spain',
      },
      {
        'id': 'CU007',
        'name': 'Dominic Malpica',
        'email': 'doms@email.com',
        'phone': '+1 202 456 7890',
        'nationality': 'USA',
      },
      {
        'id': 'CU008',
        'name': 'Manuel Abello',
        'email': 'koyamany@email.com',
        'phone': '+81 90 1234 5678',
        'nationality': 'Japan',
      },
      {
        'id': 'CU009',
        'name': 'Jose Rizal',
        'email': 'piso@email.com',
        'phone': '+86 138 0013 8000',
        'nationality': 'China',
      },
      {
        'id': 'CU010',
        'name': 'Isabella Rossi',
        'email': 'isabella.r@email.com',
        'phone': '+39 345 678 9012',
        'nationality': 'Italy',
      },
      {
        'id': 'CU011',
        'name': 'Noah Smith',
        'email': 'noah.smith@email.com',
        'phone': '+44 7911 123456',
        'nationality': 'UK',
      },
      {
        'id': 'CU012',
        'name': 'Amina Yusuf',
        'email': 'amina.y@email.com',
        'phone': '+254 712 345678',
        'nationality': 'Kenya',
      },
      {
        'id': 'CU013',
        'name': 'Pedro Lima',
        'email': 'pedro.l@email.com',
        'phone': '+55 21 98765 4321',
        'nationality': 'Brazil',
      },
      {
        'id': 'CU014',
        'name': 'Anna Müller',
        'email': 'anna.m@email.com',
        'phone': '+49 176 12345678',
        'nationality': 'Germany',
      },
      {
        'id': 'CU015',
        'name': 'Liam O\'Connor',
        'email': 'liam.o@email.com',
        'phone': '+353 85 123 4567',
        'nationality': 'Ireland',
      },
      {
        'id': 'CU016',
        'name': 'Chloe Dubois',
        'email': 'chloe.d@email.com',
        'phone': '+33 6 12 34 56 78',
        'nationality': 'France',
      },
      {
        'id': 'CU017',
        'name': 'Ivan Petrov',
        'email': 'ivan.p@email.com',
        'phone': '+7 911 123 4567',
        'nationality': 'Russia',
      },
      {
        'id': 'CU018',
        'name': 'Maya Patel',
        'email': 'maya.patel@email.com',
        'phone': '+91 98765 43210',
        'nationality': 'India',
      },
      {
        'id': 'CU019',
        'name': 'William Brown',
        'email': 'william.b@email.com',
        'phone': '+1 303 123 4567',
        'nationality': 'USA',
      },
      {
        'id': 'CU020',
        'name': 'Nora Svensson',
        'email': 'nora.s@email.com',
        'phone': '+46 70 123 4567',
        'nationality': 'Sweden',
      },
      {
        'id': 'CU021',
        'name': 'Zahra Rahimi',
        'email': 'zahra.r@email.com',
        'phone': '+98 912 345 6789',
        'nationality': 'Iran',
      },
      {
        'id': 'CU022',
        'name': 'Tomás Herrera',
        'email': 'tomas.h@email.com',
        'phone': '+52 55 1234 5678',
        'nationality': 'Mexico',
      },
      {
        'id': 'CU023',
        'name': 'Linda Olsen',
        'email': 'linda.o@email.com',
        'phone': '+47 911 12 345',
        'nationality': 'Norway',
      },
      {
        'id': 'CU024',
        'name': 'George Kim',
        'email': 'george.k@email.com',
        'phone': '+82 10 1234 5678',
        'nationality': 'South Korea',
      },
    ];

    return customers.map((customer) {
      return DataRow(
        cells: [
          DataCell(Text(customer['id']!, style: const TextStyle(fontWeight: FontWeight.w500))),
          DataCell(Text(customer['name']!)),
          DataCell(Text(customer['email']!)),
          DataCell(Text(customer['phone']!)),
          DataCell(Text(customer['nationality']!)),
          DataCell(
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () {
                // Show customer details in a dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      title: Text(
                        'Customer Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[700],
                        ),
                      ),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person, color: Colors.teal),
                                const SizedBox(width: 10),
                                Text('ID: ${customer['id']}', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.person_outline, color: Colors.teal),
                                const SizedBox(width: 10),
                                Text('Name: ${customer['name']}', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.email, color: Colors.teal),
                                const SizedBox(width: 10),
                                Text('Email: ${customer['email']}', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.phone, color: Colors.teal),
                                const SizedBox(width: 10),
                                Text('Phone: ${customer['phone']}', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.flag, color: Colors.teal),
                                const SizedBox(width: 10),
                                Text('Nationality: ${customer['nationality']}', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("View"),
            ),
          ),
        ],
      );
    }).toList();
  }
}