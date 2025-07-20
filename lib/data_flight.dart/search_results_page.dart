import 'package:flutter/material.dart';

class SearchResultsPage extends StatelessWidget {
  final String from;
  final String to;
  final DateTime? departureDate;
  final DateTime? returnDate;

  const SearchResultsPage({
    required this.from,
    required this.to,
    required this.departureDate,
    required this.returnDate,
  });

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    // Simulated flight data
    final List<Map<String, String>> availableFlights = [
      {'from': 'Manila', 'to': 'Tokyo'},
      {'from': 'Manila', 'to': 'Singapore'},
      {'from': 'Cebu', 'to': 'Tokyo'},
    ];

    // Check if the flight is available
    bool flightAvailable = availableFlights.any((flight) =>
        flight['from']?.toLowerCase() == from.toLowerCase() &&
        flight['to']?.toLowerCase() == to.toLowerCase());

    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Search Results',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Icon(Icons.attach_money, color: Colors.black),
          SizedBox(width: 16),
          Icon(Icons.favorite_border, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            // Blob Shape at the Top
            ClipPath(
              clipper: BlobClipper(),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.pink[200],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // ✅ Search Summary
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 6,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your Search", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 8),
                  Text("From: $from"),
                  Text("To: $to"),
                  Text("Departure: ${_formatDate(departureDate)}"),
                  Text("Return: ${_formatDate(returnDate)}"),
                ],
              ),
            ),

            // ✅ Flight Availability
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 6,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Center(
                child: flightAvailable
                    ? Text(
                        'Flights available from $from to $to!',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
                      )
                    : Text(
                        'No available flights from $from to $to.',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red),
                      ),
              ),
            ),

            // ✅ Example Flight Card (if available)
            if (flightAvailable) ...[
              SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      ),
                      child: Center(child: Text('Flight Image Placeholder')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Flight from $from to $to',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 4),
                          Text('Departure: ${_formatDate(departureDate)}'),
                          Text('Return: ${_formatDate(returnDate)}'),
                          SizedBox(height: 8),
                          // ✅ Price as Prominent Button
                          Container(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Booking flight from $from to $to')),
                                );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red[100],
                                padding: EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                '₱ 1,165',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[800],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Custom Clipper for Blob Shape
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
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}