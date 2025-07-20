import 'package:flutter/material.dart';
import '../wibgets/cart_page.dart';

class PackageOptionsPage extends StatefulWidget {
  final Map<String, dynamic> package;

  const PackageOptionsPage({super.key, required this.package, required Map<String, dynamic> options});

  @override
  _PackageOptionsPageState createState() => _PackageOptionsPageState();
}

class _PackageOptionsPageState extends State<PackageOptionsPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    final options = widget.package['options'];
    final joinIn = options['joinIn'];
    final private = options['private'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Package Options"),
        backgroundColor: Colors.blue, // Changed to blue
        foregroundColor: Colors.white, // Changed text color to white
        elevation: 0.5,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "${widget.package['title']} Package Options",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              for (String date in options['chipDates']) Chip(label: Text(date)),
              const Chip(label: Icon(Icons.calendar_today, size: 16)),
            ],
          ),
          const SizedBox(height: 20),
          const Text("Select Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                setState(() {
                  selectedDate = pickedDate;
                });
              }
            },
            child: Text(selectedDate == null ? 'Select Date' : 'Selected: ${selectedDate!.toLocal()}'.split(' ')[0]),
          ),
          const SizedBox(height: 20),
          const Text("Select Time", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: selectedTime ?? TimeOfDay.now(),
              );
              if (pickedTime != null) {
                setState(() {
                  selectedTime = pickedTime;
                });
              }
            },
            child: Text(selectedTime == null ? 'Select Time' : 'Selected: ${selectedTime!.format(context)}'),
          ),
          const SizedBox(height: 20),
          const Text("Package Type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue), // Changed to blue
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(joinIn['discount'], style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)), // Changed to blue
                      const SizedBox(height: 4),
                      const Text("Join-in Tour"),
                      Text(joinIn['price'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(private['discount'], style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)), // Changed to blue
                      const SizedBox(height: 4),
                      const Text("Private Tour"),
                      Text(private['price'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.location_on_outlined, color: Colors.green),
            title: Text(options['location']),
          ),
          ListTile(
            leading: const Icon(Icons.access_time, color: Colors.green),
            title: Text(options['time']),
          ),
          ListTile(
            leading: const Icon(Icons.group, color: Colors.green),
            title: Text(options['departure']),
          ),
          ListTile(
            leading: const Icon(Icons.check_circle_outline, color: Colors.green),
            title: Text(options['note']),
            subtitle: Text(options['subnote']),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.map),
            label: const Text("See itinerary details"),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue, // Changed text color to blue
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            Text(
              joinIn['price'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue), // Changed to blue
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[300], // Changed to blue
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text("Add to cart", style: TextStyle(color: Colors.white)), // White text
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Tour booked successfully!")),
                );
                Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage(bookingData: {},)));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Changed to blue
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text("Book now", style: TextStyle(color: Colors.white)), // White text
            ),
          ],
        ),
      ),
    );
  }
}