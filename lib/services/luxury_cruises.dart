import 'package:flutter/material.dart';
import 'package:final_project/data_cruises/cruise_booking_form.dart'; // Import next page

class LuxuryCruisesPage extends StatelessWidget {
  final List<Map<String, String>> cruises = [
    {
      'name': 'Caribbean Escape',
      'image': 'assets/mediterranean_cruise.png', // Local asset image
      'description': '7-night luxury Caribbean cruise with private balcony suites and gourmet dining.',
      'price': '₱85,000'
    },
    {
      'name': 'Mediterranean Elegance',
      'image': 'assets/mediterranean_elegance.jpg', // Local asset image
      'description': '10-night cruise through Italy, Greece, and Spain with cultural shore excursions.',
      'price': '₱120,000'
    },
  ];

  void _navigateToBookingForm(BuildContext context, Map<String, String> cruise) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CruiseBookingFormPage(cruise: cruise),
      ),
    );
  }

  Widget _buildCruiseCard(BuildContext context, Map<String, String> cruise) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              cruise['image']!, // Use local asset image
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cruise['name']!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(cruise['description']!),
                SizedBox(height: 12),
                Text(
                  cruise['price']!,
                  style: TextStyle(fontSize: 18, color: Colors.blue), // Changed to blue
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => _navigateToBookingForm(context, cruise),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Changed to blue
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: Icon(Icons.book_online, color: Colors.white), // White icon
                  label: Text(
                    'Book Now',
                    style: TextStyle(color: Colors.white), // White text
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Luxury Cruises'),
        backgroundColor: Colors.blue, // Changed to blue
      ),
      body: ListView(
        children: cruises.map((cruise) => _buildCruiseCard(context, cruise)).toList(),
      ),
    );
  }
}