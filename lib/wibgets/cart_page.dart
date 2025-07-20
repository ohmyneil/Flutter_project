import 'package:flutter/material.dart';
import 'cart_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.bookingData});

  final Map<String, dynamic> bookingData;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _bookingAdded = false;

  @override
  void initState() {
    super.initState();

    // Add cruise booking once
    if (!_bookingAdded &&
        widget.bookingData.isNotEmpty &&
        widget.bookingData['cruise'] != null) {
      CartService.addCruiseItem(widget.bookingData);
      _bookingAdded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = CartService.items;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text('Bookings'),
        backgroundColor: Colors.blue, // Changed to blue
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Column(
        children: [
          ClipPath(
            clipper: BlobClipper(),
            child: Container(
              height: 150,
              decoration: const BoxDecoration(color: Colors.blue), // Changed to blue
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: items.isEmpty
                ? const Center(
                    child: Text(
                      'Your cart is empty.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final bool isCruise = item is Map<String, dynamic> && item.containsKey('cruise');

                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isCruise) ...[
                                Text(
                                  '${item['cruise']['name']}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text('Name: ${item['name']}'),
                                Text('Email: ${item['email']}'),
                                Text('Contact: ${item["contact"]}'),
                                Text('Passport: ${item['passport']}'),
                                Text('Emergency Contact: ${item['emergencyName']} - ${item['emergencyContact']}'),
                                Text('Cabin: ${item['cabinType']}'),
                                Text('Port: ${item['departurePort']}'),
                                Text('Meal: ${item['mealPreference']}'),
                                Text('Adults: ${item['adults']} | Children: ${item['children']}'),
                                Text(
                                  'Dates: ${_formatDate(item['dates']?.start)} to ${_formatDate(item['dates']?.end)}',
                                ),
                                if (item['notes'] != null && item['notes'].toString().isNotEmpty)
                                  Text('Notes: ${item['notes']}'),
                              ] else if (item is CartItem) ...[
                                Text(
                                  '${item.from} ➔ ${item.to}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text('Airline: ${item.airline}'),
                                Text('Time: ${item.time}'),
                                Text('Class: ${item.travelClass}'),
                                Text('Price: ${item.price}'),
                                Text('Departure: ${_formatDate(item.departureDate)}'),
                                Text('Return: ${_formatDate(item.returnDate)}'),
                              ],
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton.icon(
                                  onPressed: () {
                                    CartService.removeItem(index);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const CartPage(bookingData: {}),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                                  label: const Text(
                                    'Remove',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.month}/${date.day}/${date.year}';
  }
}

class BlobClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(size.width / 4, size.height, size.width / 2, size.height - 30);
    path.quadraticBezierTo(size.width * 3 / 4, size.height - 60, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}