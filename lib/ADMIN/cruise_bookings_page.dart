import 'package:flutter/material.dart';

class CruiseBookingsPage extends StatefulWidget {
  const CruiseBookingsPage({super.key});

  @override
  State<CruiseBookingsPage> createState() => _CruiseBookingsPageState();
}

class _CruiseBookingsPageState extends State<CruiseBookingsPage> {
  final _formKey = GlobalKey<FormState>();
  final List<Booking> _bookings = [
    Booking(id: '#C001', customer: 'Lara Cruz', cruiseName: 'Oceanic Explorer', cabinType: 'Deluxe Suite', embarkation: '2025-10-01', disembarkation: '2025-10-10', amount: 'PHP 35,000', status: 'Confirmed'),
    Booking(id: '#C002', customer: 'Mark Reyes', cruiseName: 'Island Voyager', cabinType: 'Ocean View', embarkation: '2025-11-15', disembarkation: '2025-11-22', amount: 'PHP 28,000', status: 'Pending'),
    Booking(id: '#C003', customer: 'Anna Santos', cruiseName: 'Pacific Dream', cabinType: 'Interior Cabin', embarkation: '2025-08-05', disembarkation: '2025-08-12', amount: 'PHP 22,500', status: 'Confirmed'),
    Booking(id: '#C004', customer: 'John Dela Cruz', cruiseName: 'Caribbean Bliss', cabinType: 'Balcony Suite', embarkation: '2025-09-10', disembarkation: '2025-09-18', amount: 'PHP 40,000', status: 'Cancelled'),
    Booking(id: '#C005', customer: 'Michelle Lim', cruiseName: 'Ocean Queen', cabinType: 'Ocean View', embarkation: '2025-12-01', disembarkation: '2025-12-08', amount: 'PHP 30,000', status: 'Pending'),
    Booking(id: '#C006', customer: 'Carlos Gomez', cruiseName: 'Arctic Adventure', cabinType: 'Luxury Suite', embarkation: '2025-10-20', disembarkation: '2025-10-30', amount: 'PHP 55,000', status: 'Confirmed'),
    Booking(id: '#C007', customer: 'Elaine Yu', cruiseName: 'Mediterranean Pearl', cabinType: 'Deluxe Suite', embarkation: '2025-11-05', disembarkation: '2025-11-12', amount: 'PHP 38,500', status: 'Confirmed'),
    Booking(id: '#C008', customer: 'Kevin Tan', cruiseName: 'Northern Lights', cabinType: 'Interior Cabin', embarkation: '2025-09-25', disembarkation: '2025-10-01', amount: 'PHP 20,000', status: 'Cancelled'),
    Booking(id: '#C009', customer: 'Grace Navarro', cruiseName: 'Island Hopper', cabinType: 'Balcony Suite', embarkation: '2025-10-15', disembarkation: '2025-10-22', amount: 'PHP 42,000', status: 'Pending'),
  ];

  final _idController = TextEditingController();
  final _customerController = TextEditingController();
  final _cruiseController = TextEditingController();
  final _cabinController = TextEditingController();
  final _embarkController = TextEditingController();
  final _disembarkController = TextEditingController();
  final _amountController = TextEditingController();
  final _statusController = TextEditingController();
  // ignore: unused_field
  String _searchQuery = '';

  @override
  void dispose() {
    _idController.dispose();
    _customerController.dispose();
    _cruiseController.dispose();
    _cabinController.dispose();
    _embarkController.dispose();
    _disembarkController.dispose();
    _amountController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  void _addBooking() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _bookings.add(Booking(
          id: _idController.text,
          customer: _customerController.text,
          cruiseName: _cruiseController.text,
          cabinType: _cabinController.text,
          embarkation: _embarkController.text,
          disembarkation: _disembarkController.text,
          amount: _amountController.text,
          status: _statusController.text,
        ));
        _idController.clear();
        _customerController.clear();
        _cruiseController.clear();
        _cabinController.clear();
        _embarkController.clear();
        _disembarkController.clear();
        _amountController.clear();
        _statusController.clear();
      });
      Navigator.of(context).pop();
    }
  }

  Future<void> _showAddDialog() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text('Add Cruise Booking', style: TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(controller: _idController, label: 'Booking ID'),
                _buildTextField(controller: _customerController, label: 'Customer Name'),
                _buildTextField(controller: _cruiseController, label: 'Cruise Name'),
                _buildTextField(controller: _cabinController, label: 'Cabin Type'),
                _buildTextField(controller: _embarkController, label: 'Embarkation (YYYY-MM-DD)'),
                _buildTextField(controller: _disembarkController, label: 'Disembarkation (YYYY-MM-DD)'),
                _buildTextField(controller: _amountController, label: 'Amount'),
                _buildTextField(controller: _statusController, label: 'Status'),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            onPressed: _addBooking,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _showViewDialog(Booking booking) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text('Booking Details', style: TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Row(
                children: [
                  const Icon(Icons.confirmation_number, color: Colors.teal),
                  const SizedBox(width: 10),
                  Text('ID: ${booking.id}', style: const TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.person, color: Colors.teal),
                  const SizedBox(width: 10),
                  Text('Customer: ${booking.customer}', style: const TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.directions_boat, color: Colors.teal),
                  const SizedBox(width: 10),
                  Text('Cruise: ${booking.cruiseName}', style: const TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.hotel, color: Colors.teal),
                  const SizedBox(width: 10),
                  Text('Cabin: ${booking.cabinType}', style: const TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.teal),
                  const SizedBox(width: 10),
                  Text('Embark: ${booking.embarkation}', style: const TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.teal),
                  const SizedBox(width: 10),
                  Text('Disembark: ${booking.disembarkation}', style: const TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.money, color: Colors.teal),
                  const SizedBox(width: 10),
                  Text('Amount: ${booking.amount}', style: const TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.teal),
                  const SizedBox(width: 10),
                  Text('Status: ${booking.status}', style: const TextStyle(fontSize: 16)),
                ],
              ),
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

  Widget _buildTextField({required TextEditingController controller, required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (v) => v == null || v.isEmpty ? 'Required' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cruise Bookings', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _showAddDialog),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: BookingSearchDelegate(bookings: _bookings),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Cruise Booking Records',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.teal),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: isMobile ? 600 : MediaQuery.of(context).size.width),
                        child: DataTable(
                          columnSpacing: 24,
                          headingRowColor: MaterialStateProperty.all(Colors.teal[100]),
                          columns: const [
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('Customer')),
                            DataColumn(label: Text('Cruise')),
                            DataColumn(label: Text('Cabin')),
                            DataColumn(label: Text('Embark')),
                            DataColumn(label: Text('Disembark')),
                            DataColumn(label: Text('Amount')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Action')),
                          ],
                          rows: _bookings.map((b) => DataRow(cells: [
                            DataCell(Text(b.id)),
                            DataCell(Text(b.customer)),
                            DataCell(Text(b.cruiseName)),
                            DataCell(Text(b.cabinType)),
                            DataCell(Text(b.embarkation)),
                            DataCell(Text(b.disembarkation)),
                            DataCell(Text(b.amount)),
                            DataCell(Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _statusColor(b.status).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                b.status,
                                style: TextStyle(
                                  color: _statusColor(b.status),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                            DataCell(
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () => _showViewDialog(b),
                                child: const Text('View'),
                              ),
                            ),
                          ])).toList(),
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
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class Booking {
  final String id, customer, cruiseName, cabinType, embarkation, disembarkation, amount, status;
  Booking({
    required this.id,
    required this.customer,
    required this.cruiseName,
    required this.cabinType,
    required this.embarkation,
    required this.disembarkation,
    required this.amount,
    required this.status,
  });
}

class BookingSearchDelegate extends SearchDelegate<Booking?> {
  final List<Booking> bookings;

  BookingSearchDelegate({required this.bookings});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = bookings.where((b) => b.customer.toLowerCase().contains(query.toLowerCase()) || b.cruiseName.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final booking = results[index];
        return ListTile(
          title: Text(booking.customer),
          subtitle: Text(booking.cruiseName),
          onTap: () {
            Navigator.of(context).pop();
            // Optionally, you can show the booking details here
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = bookings.where((b) => b.customer.toLowerCase().contains(query.toLowerCase()) || b.cruiseName.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final booking = suggestions[index];
        return ListTile(
          title: Text(booking.customer),
          subtitle: Text(booking.cruiseName),
          onTap: () {
            query = booking.customer; // Set the query to the selected suggestion
          },
        );
      },
    );
  }
} 