// lib/pages/TourPackagesPage.dart

import 'package:flutter/material.dart';
import 'package:final_project/wibgets/cart_page.dart';
import '../data_packages/data.dart';
import '../data_packages/klook_style_page.dart';

class TourPackagesPage extends StatelessWidget {
  const TourPackagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A.C. Tour Packages'),
        backgroundColor: Colors.blue[700], // Changed to blue
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage(bookingData: {})),
              );
            },
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: tourPackages.length,
        itemBuilder: (context, index) {
          final tour = tourPackages[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 20),
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.asset(
                    tour['image'],
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tour['title'],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue, // Changed to blue
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tour['description'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        tour['price'],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.blue, // Changed to blue
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => KlookStyleTourPage(
                                  packageIndex: index,
                                  title: tour['title'],
                                  image: tour['image'],
                                  price: tour['price'],
                                  description: tour['description'], // Pass tour details
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.flight_takeoff, color: Colors.white), // White icon
                          label: const Text(
                            'Book Now',
                            style: TextStyle(color: Colors.white), // White text
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[600], // Changed to blue
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}