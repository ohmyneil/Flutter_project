import 'package:flutter/material.dart';
import 'package:final_project/data_flight.dart/flight_results.dart';

class AirlineTicketsPage extends StatefulWidget {
  const AirlineTicketsPage({super.key});

  @override
  State<AirlineTicketsPage> createState() => _AirlineTicketsPageState();
}

class _AirlineTicketsPageState extends State<AirlineTicketsPage> {
  String travelClass = 'Economy';
  DateTime? departureDate;
  DateTime? returnDate;

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  Future<void> pickDate({required bool isDeparture}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          departureDate = picked;
        } else {
          returnDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD), // Light blue background
      appBar: AppBar(
        title: const Text(
          'Book a Flight',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue, // Blue app bar
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Blob Shape at the Top
            ClipPath(
              clipper: BlobClipper(),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blue, // Blue blob shape
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildTextField(fromController, 'From'),
                  const SizedBox(height: 12),
                  buildTextField(toController, 'To'),
                  const SizedBox(height: 12),
                  buildDatePickerField(
                    label: 'Departure Date',
                    selectedDate: departureDate,
                    onTap: () => pickDate(isDeparture: true),
                  ),
                  const SizedBox(height: 12),
                  buildDatePickerField(
                    label: 'Return Date',
                    selectedDate: returnDate,
                    onTap: () => pickDate(isDeparture: false),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: travelClass,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Class',
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Economy', child: Text('Economy')),
                      DropdownMenuItem(value: 'Business', child: Text('Business')),
                      DropdownMenuItem(value: 'First Class', child: Text('First Class')),
                    ],
                    onChanged: (value) => setState(() => travelClass = value!),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Blue button
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () {
                      if (fromController.text.isNotEmpty &&
                          toController.text.isNotEmpty &&
                          departureDate != null &&
                          returnDate != null &&
                          travelClass.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FlightResultsPage(
                              from: fromController.text.trim(),
                              to: toController.text.trim(),
                              departureDate: departureDate,
                              returnDate: returnDate,
                              travelClass: travelClass,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please complete all fields before searching.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Search Flights',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: const Icon(Icons.flight_takeoff, color: Colors.blue), // Blue icon
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }

  Widget buildDatePickerField({
    required String label,
    required DateTime? selectedDate,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          prefixIcon: const Icon(Icons.calendar_today, color: Colors.blue), // Blue icon
          filled: true,
          fillColor: Colors.grey[100],
        ),
        child: Text(
          selectedDate == null
              ? 'Select $label'
              : '${selectedDate.month}/${selectedDate.day}/${selectedDate.year}',
          style: TextStyle(
            color: selectedDate == null ? Colors.grey : Colors.black,
            fontSize: 16,
          ),
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