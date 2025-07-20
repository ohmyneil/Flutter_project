import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> monthlyStats = [
      {'month': 'January', 'flights': 120, 'cruises': 80, 'visas': 45},
      {'month': 'February', 'flights': 150, 'cruises': 90, 'visas': 60},
      {'month': 'March', 'flights': 170, 'cruises': 110, 'visas': 70},
      {'month': 'April', 'flights': 130, 'cruises': 75, 'visas': 40},
      {'month': 'May', 'flights': 160, 'cruises': 100, 'visas': 65},
      {'month': 'June', 'flights': 140, 'cruises': 95, 'visas': 50},
      {'month': 'July', 'flights': 180, 'cruises': 120, 'visas': 75},
    ];

    int getMaxValue() {
      int max = 0;
      for (var stat in monthlyStats) {
        max = [
          max,
          stat['flights'] as int,
          stat['cruises'] as int,
          stat['visas'] as int
        ].reduce((a, b) => a > b ? a : b);
      }
      return max;
    }

    int getMaxTotalBookings() {
      int max = 0;
      for (var stat in monthlyStats) {
        int total = stat['flights'] + stat['cruises'] + stat['visas'];
        if (total > max) max = total;
      }
      return max;
    }

    final maxValue = getMaxValue().toDouble();
    final maxTotal = getMaxTotalBookings().toDouble();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Reports'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: monthlyStats.length,
          itemBuilder: (context, index) {
            final stat = monthlyStats[index];
            final int totalBookings = stat['flights'] + stat['cruises'] + stat['visas'];
            final double totalBar = (totalBookings / maxTotal) * MediaQuery.of(context).size.width * 0.8;

            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.bar_chart, color: Colors.teal, size: 32),
                      title: Text(
                        stat['month'],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCircularProgressIndicator(stat['flights'], maxValue, Colors.blue, "Flights"),
                          _buildCircularProgressIndicator(stat['cruises'], maxValue, Colors.green, "Cruises"),
                          _buildCircularProgressIndicator(stat['visas'], maxValue, Colors.orange, "Visas"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text("Total Bookings:", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Stack(
                      children: [
                        Container(
                          height: 20,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: totalBar,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('$totalBookings total bookings'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCircularProgressIndicator(int value, double maxValue, Color color, String label) {
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            value: value / maxValue,
            backgroundColor: Colors.grey[300],
            color: color,
            strokeWidth: 6,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
        Text('$value', style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}