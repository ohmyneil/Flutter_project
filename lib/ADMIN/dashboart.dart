import 'package:flutter/material.dart';
import 'flight_bookings_page.dart';
import 'cruise_bookings_page.dart';
import 'visa_applications_page.dart';
import 'package_tours_page.dart';
import 'customers_page.dart';
import 'reports_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override


  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A.C Travel & Tours - Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const DashboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: isMobile
          ? AppBar(
              title: const Text('Admin Dashboard'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ],
            )
          : null,
      drawer: isMobile ? _buildDrawer(context) : null,
      body: isMobile ? _buildMobileBody() : _buildDesktopBody(context),
    );
  }

  Widget _buildMobileBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildStatsGrid(true),
          const SizedBox(height: 16),
          _buildRevenueChartPlaceholder(),
          const SizedBox(height: 16),
          _buildRecentActivities(),
          const SizedBox(height: 16),
          _buildRecentBookings(),
        ],
      ),
    );
  }

  Widget _buildDesktopBody(BuildContext context) {
    return Row(
      children: [
        _buildDrawer(context),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Dashboard Overview',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    _buildSearchBar(),
                  ],
                ),
                const SizedBox(height: 24),
                _buildStatsGrid(false),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          _buildRevenueChartPlaceholder(),
                          const SizedBox(height: 16),
                          _buildRecentBookings(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildRecentActivities(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal[700],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Text(
                    'A.C',
                    style: TextStyle(color: Colors.teal, fontSize: 20),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'A.C Travel & Tours',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Admin Dashboard',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.dashboard,
            title: 'Dashboard',
            isSelected: _selectedIndex == 0,
            onTap: () => _onDrawerItemTapped(0),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text(
              'SERVICES',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.flight,
            title: 'Flight Bookings',
            isSelected: _selectedIndex == 1,
            onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const FlightBookingsPage()),
  );
},

          ),
          _buildDrawerItem(
  context,
  icon: Icons.directions_boat,
  title: 'Cruise Packages',
  isSelected: _selectedIndex == 2,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CruiseBookingsPage()),
    );
    _onDrawerItemTapped(2);
  },
),

          _buildDrawerItem(
  context,
  icon: Icons.assignment_outlined, // Fixed passport icon
  title: 'Visa Applications',
  isSelected: _selectedIndex == 3,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VisaApplicationsPage()),
    );
    _onDrawerItemTapped(3);
  },
),

         _buildDrawerItem(
  context,
  icon: Icons.work_outline,
  title: 'Package Tours',
  isSelected: _selectedIndex == 4,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PackageToursPage()),
    );
    _onDrawerItemTapped(4);
  },
),
          const Divider(),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text(
              'MANAGEMENT',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        _buildDrawerItem(
  context,
  icon: Icons.people,
  title: 'Customers',
  isSelected: _selectedIndex == 5,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CustomersPage()),
    );
    _onDrawerItemTapped(5);
  },
),

          _buildDrawerItem(
            context,
            icon: Icons.bar_chart,
            title: 'Reports',
            isSelected: _selectedIndex == 7,
            onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ReportsPage()),
  );
  _onDrawerItemTapped(6); // or whatever index you’re using for 'Reports'
},

          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text(
              'SETTINGS',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.settings,
            title: 'Settings',
            isSelected: _selectedIndex == 8,
            onTap: () => _onDrawerItemTapped(8),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.logout,
            title: 'Logout',
            isSelected: _selectedIndex == 9,
            textColor: Colors.red,
            iconColor: Colors.red,
            onTap: () => _onDrawerItemTapped(9),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? badge,
    bool isSelected = false,
    Color? textColor,
    Color? iconColor,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: isSelected
          ? BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor ?? (isSelected ? Theme.of(context).colorScheme.primary : Colors.grey[700]),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: textColor ?? (isSelected ? Theme.of(context).colorScheme.primary : Colors.grey[800]),
          ),
        ),
        trailing: badge != null
            ? Chip(
                label: Text(badge),
                labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
                backgroundColor: Theme.of(context).colorScheme.primary,
              )
            : null,
        onTap: onTap,
      ),
    );
  }

  Widget _buildSearchBar() {
    return SizedBox(
      width: 300,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
        ),
      ),
    );
  }

  Widget _buildStatsGrid(bool isMobile) {
    return GridView.count(
      crossAxisCount: isMobile ? 2 : 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildStatCard(
          icon: Icons.flight,
          title: 'Flight Bookings',
          value: '42',
          percentage: '12%',
          isIncrease: true,
          color: Colors.blue,
        ),
        _buildStatCard(
          icon: Icons.directions_boat,
          title: 'Cruise Packages',
          value: '18',
          percentage: '8%',
          isIncrease: true,
          color: Colors.indigo, 
        ),
        _buildStatCard(
          icon: Icons.assignment_outlined, // Fixed passport icon
          title: 'Visa Applications',
          value: '27',
          percentage: '3%',
          isIncrease: false,
          color: Colors.green,
        ),
        _buildStatCard(
          icon: Icons.work_outline, // Fixed suitcase icon
          title: 'Package Tours',
          value: '35',
          percentage: '22%',
          isIncrease: true,
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required String percentage,
    required bool isIncrease,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                Text(
                  percentage,
                  style: TextStyle(
                    color: isIncrease ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueChartPlaceholder() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Monthly Revenue',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.insert_chart, size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('Revenue Chart Placeholder'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivities() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Activities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildActivityItem(
              icon: Icons.flight,
              color: Colors.blue,
              title: 'New flight booking',
              subtitle: 'Dubai to London - AED 2,450',
              time: '5 mins ago',
            ),
            _buildActivityItem(
              icon: Icons.directions_boat,
              color: Colors.indigo,
              title: 'Cruise booking confirmed',
              subtitle: 'Mediterranean Cruise - AED 5,999',
              time: '1 hour ago',
            ),
            _buildActivityItem(
              icon: Icons.assignment_outlined, // Fixed passport icon
              color: Colors.green,
              title: 'Visa application submitted',
              subtitle: 'UK Tourist Visa - AED 1,200',
              time: '3 hours ago',
            ),
            _buildActivityItem(
              icon: Icons.work_outlined, // Fixed suitcase icon
              color: Colors.purple,
              title: 'Tour package booked',
              subtitle: 'Switzerland 7D/6N - AED 8,400',
              time: '5 hours ago',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildRecentBookings() {
  return Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Bookings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          /// ✅ Wrap in BOTH vertical & horizontal scroll views
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 24,
                dataRowMinHeight: 56,
                dataRowMaxHeight: 72,
                columns: const [
                  DataColumn(label: Text('Booking ID')),
                  DataColumn(label: Text('Customer')),
                  DataColumn(label: Text('Service')),
                  DataColumn(label: Text('Destination')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Action')),
                ],
                rows: [
                  _buildBookingRow(
                    bookingId: '#AC23456',
                    customer: 'Ahmed Khan',
                    service: 'Flight',
                    destination: 'Dubai to Paris',
                    amount: 'AED 3,200',
                    status: 'Confirmed',
                    statusColor: Colors.green,
                  ),
                  _buildBookingRow(
                    bookingId: '#AC23457',
                    customer: 'Fatima Ali',
                    service: 'Cruise',
                    destination: 'Caribbean Cruise',
                    amount: 'AED 6,500',
                    status: 'Pending',
                    statusColor: Colors.orange,
                  ),
                  _buildBookingRow(
                    bookingId: '#AC23458',
                    customer: 'Mohammed Hassan',
                    service: 'Visa',
                    destination: 'UK Tourist Visa',
                    amount: 'AED 1,200',
                    status: 'Processing',
                    statusColor: Colors.blue,
                  ),
                  _buildBookingRow(
                    bookingId: '#AC23459',
                    customer: 'Leila Ismail',
                    service: 'Tour',
                    destination: 'Maldives Package',
                    amount: 'AED 7,800',
                    status: 'Confirmed',
                    statusColor: Colors.green,
                  ),
                  _buildBookingRow(
                    bookingId: '#AC23460',
                    customer: 'Jamal Youssef',
                    service: 'Flight',
                    destination: 'Cairo to Rome',
                    amount: 'AED 2,950',
                    status: 'Pending',
                    statusColor: Colors.orange,
                  ),
                  _buildBookingRow(
                    bookingId: '#AC23461',
                    customer: 'Sara Al Mansoori',
                    service: 'Cruise',
                    destination: 'Dubai to Singapore',
                    amount: 'AED 9,000',
                    status: 'Confirmed',
                    statusColor: Colors.green,
                  ),
                  _buildBookingRow(
                    bookingId: '#AC23462',
                    customer: 'Ali Reza',
                    service: 'Visa',
                    destination: 'Schengen Visa',
                    amount: 'AED 1,500',
                    status: 'Processing',
                    statusColor: Colors.blue,
                  ),
                  _buildBookingRow(
                    bookingId: '#AC23463',
                    customer: 'Zahra Karim',
                    service: 'Tour',
                    destination: 'Japan Explorer',
                    amount: 'AED 10,000',
                    status: 'Cancelled',
                    statusColor: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}




  DataRow _buildBookingRow({
  required String bookingId,
  required String customer,
  required String service,
  required String destination,
  required String amount,
  required String status,
  required Color statusColor,
}) {
  return DataRow(
    cells: [
      DataCell(Text(bookingId)),
      DataCell(Text(customer)),
      DataCell(Text(service)),
      DataCell(Text(destination)),
      DataCell(Text(amount)), // ✅ Amount shown
      DataCell(               // ✅ Status badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            status,
            style: TextStyle(color: statusColor),
          ),
        ),
      ),
      DataCell(const Text('15 Jun 2023')), // ✅ Date shown
      DataCell(                            // ✅ Action button
        TextButton(
          onPressed: () {},
          child: const Text('View'),
        ),
      ),
    ],
  );
}


void _onDrawerItemTapped(int index) {
  if (index == 9) {
    // Logout tapped
    showLogoutDialog(context);
  } else {
    setState(() {
      _selectedIndex = index;
    });
  }
}

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Dismiss the dialog
            },
          ),
          TextButton(
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Dismiss the dialog
              Navigator.of(context).popUntil((route) => route.isFirst); // Simulate logout
            },
          ),
        ],
      );
    },
  );
}

}