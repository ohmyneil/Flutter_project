import 'package:flutter/material.dart';
import '../wibgets/cart_page.dart'; // ✅ Import the cart page
import '../profile_page.dart'; // Import the Profile page
import '../settings_page.dart'; // Import the Settings page

class CustomDrawer extends StatelessWidget {
  final AnimationController logoController;
  final Function(int) onItemTapped;
  final VoidCallback onLogout;

  const CustomDrawer({
    super.key,
    required this.logoController,
    required this.onItemTapped,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          _AnimatedDrawerHeader(controller: logoController),

          // ✅ HOME item
          _buildDrawerItem(Icons.home, 'Home', () {
            Navigator.pop(context);
            onItemTapped(0);
          }),

          // ✅ BOOKINGS item
          _buildCartNavigationItem(context),

          // ✅ PROFILE item
          _buildDrawerItem(Icons.person, 'Profile', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProfilePage()),
            );
          }),

          // ✅ SETTINGS item
          _buildDrawerItem(Icons.settings, 'Settings', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsPage()),
            );
          }),

          const Divider(),

          // ✅ LOGOUT item
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: onLogout,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue), // Changed to blue
            const SizedBox(width: 16),
            Text(title, style: const TextStyle(color: Colors.blue)), // Changed to blue
          ],
        ),
      ),
    );
  }

  Widget _buildCartNavigationItem(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const CartPage(bookingData: {}),
          ),
        );
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
        child: Row(
          children: [
            Icon(Icons.shopping_cart, color: Colors.blue), // Changed to blue
            SizedBox(width: 16),
            Text('Bookings', style: TextStyle(color: Colors.blue)), // Changed to blue
          ],
        ),
      ),
    );
  }
}

class _AnimatedDrawerHeader extends StatelessWidget {
  final AnimationController controller;

  const _AnimatedDrawerHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.lightBlueAccent], // Changed to blue gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: controller,
            builder: (_, __) {
              return Transform.scale(
                scale: controller.value * 0.2 + 1,
                child: const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/logo.png'), // ✅ Replace with your image
                  backgroundColor: Colors.white,
                ),
              );
            },
          ),
          const SizedBox(width: 16),
          const Text(
            'A.C.',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ],
      ),
    );
  }
}