import 'package:flutter/material.dart';
import 'package:final_project/wibgets/cart_model.dart'; // Ensure correct path

class FlightDetailsPage extends StatelessWidget {
  final String from;
  final String to;
  final String airline;
  final String time;
  final String price;
  final String travelClass;
  final DateTime? departureDate;
  final DateTime? returnDate;

  const FlightDetailsPage({
    super.key,
    required this.from,
    required this.to,
    required this.airline,
    required this.time,
    required this.price,
    required this.travelClass,
    this.departureDate,
    this.returnDate,
  });

  String formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.month}/${date.day}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('Flight Details'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Airline: $airline',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 16),

              buildDetail('From', from),
              buildDetail('To', to),
              buildDetail('Time', time),
              buildDetail('Class', travelClass),
              buildDetail('Price', price),

              const SizedBox(height: 10),
              const Divider(height: 30, color: Colors.grey),

              buildDetail('Departure Date', formatDate(departureDate)),
              buildDetail('Return Date', formatDate(returnDate)),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // ✅ Add flight to cart
                    CartService.addItem(CartItem(
                      from: from,
                      to: to,
                      airline: airline,
                      time: time,
                      price: price,
                      travelClass: travelClass,
                      departureDate: departureDate,
                      returnDate: returnDate,
                    ));

                    // ✅ Show confirmation message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Booking successful!'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    // ✅ Delay a bit and return to home
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    });
                  },
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Confirm and Book'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
