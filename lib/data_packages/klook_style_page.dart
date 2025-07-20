import 'package:flutter/material.dart';
import 'package:final_project/data_packages/PackageOptionsPage.dart';
import 'package:final_project/data_packages/data.dart'; // Import the data file

class KlookStyleTourPage extends StatelessWidget {
  final int packageIndex;

  const KlookStyleTourPage({
    super.key,
    required this.packageIndex, required title, required image, required price, required description,
  });

  @override
  Widget build(BuildContext context) {
    final package = tourPackages[packageIndex];
    final String title = package['title'] ?? '';
    final String image = package['image'] ?? '';
    final String price = package['price'] ?? '';
    final String description = package['description'] ?? '';
    final Map<String, dynamic> options = package['options'] ?? {};

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.blue, // Changed to blue
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                image,
                height: 240,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const Positioned(
                top: 40,
                right: 10,
                child: Row(
                  children: [
                    Icon(Icons.favorite_border, color: Colors.white),
                    SizedBox(width: 10),
                    Icon(Icons.share, color: Colors.white),
                    SizedBox(width: 10),
                    Icon(Icons.shopping_cart, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  '',
                  style: TextStyle(color: Colors.blueGrey),
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    SizedBox(width: 4),
                    Text('4.7', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 6),
                    Text('• 1.2k reviews • 10k+ booked'),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Chip(label: Text('English')),
                    const SizedBox(width: 8),
                    Chip(label: Text('Private/Group')),
                    const SizedBox(width: 8),
                    Chip(label: Text('6hr Duration')),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Divider(),
                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.blue, // Changed to blue
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PackageOptionsPage(
                              options: options,
                              package: package,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Changed to blue
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text('Select Options', style: TextStyle(color: Colors.white)), // White text
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}