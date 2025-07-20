import 'package:flutter/material.dart';
import 'dart:math';
import 'wibgets/cart_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'services/airline_tickets.dart';
import 'services/luxury_cruises.dart';
import 'services/passport_visa.dart';
import 'wibgets/custom_drawer.dart';
import 'data_homepage/data.dart';
import 'services/tours_packages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late List<Widget> _pages;
  late AnimationController _logoController;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeContent(),
      CartPage(bookingData: {}),
      ProfilePage(),
      SettingsPage(),
    ];
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          TextButton(
            child: const Text("Logout", style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A.C. Travel and Tours', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(0, 0, 121, 107),
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          IconButton(icon: const Icon(Icons.language), onPressed: () {}),
        ],
      ),
      drawer: CustomDrawer(
        logoController: _logoController,
        onItemTapped: _onItemTapped,
        onLogout: _logout,
      ),
      body: SafeArea(child: _pages[_selectedIndex]),
    );
  }
}

class HomeContent extends StatelessWidget {
  final List<Service> services = [
    Service('Airline Tickets', Icons.flight, AirlineTicketsPage(), 'flight.logo.jpg'),
    Service('Packages Tours', Icons.public, TourPackagesPage(), 'tour.logo.jpg'),
    Service('Luxury Cruises', Icons.directions_boat_filled, LuxuryCruisesPage(), 'cruise.logo.jpg'),
    Service('Passport & Visa', Icons.card_travel, PassportVisaInfoPage(), 'passport.logo.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              final svc = services[index];
              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => svc.page)),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          svc.imagePath,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        svc.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 30),
          ..._buildSections(context),
        ],
      ),
    );
  }

  List<Widget> _buildSections(BuildContext context) {
    return [
      _buildSection(context, TravelData.airlineTickets),
      _buildSection(context, TravelData.packageTours),
      _buildSection(context, TravelData.luxuryCruises),
      _buildSection(context, TravelData.passportVisa),
    ];
  }

  Widget _buildSection(BuildContext context, List<Map<String, dynamic>> dataList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dataList.map<Widget>((section) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              section['title'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 4),
            Text(section['description'], style: const TextStyle(color: Colors.black87)),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: section['items'].length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final item = section['items'][index];
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300 + Random().nextInt(200)),
                    curve: Curves.easeInOut,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.asset(
                            item['image'],
                            height: 110,
                            width: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: item.entries.map<Widget>((entry) {
                              if (entry.key == 'image') return const SizedBox();
                              return Text(
                                '${_capitalize(entry.key)}: ${entry.value}',
                                style: const TextStyle(fontSize: 13),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        );
      }).toList(),
    );
  }

  String _capitalize(String text) {
    return text
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}

class Service {
  final String name;
  final IconData icon;
  final Widget page;
  final String imagePath;

  Service(this.name, this.icon, this.page, this.imagePath);
}
