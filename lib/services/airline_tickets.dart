import 'package:flutter/material.dart';
import 'package:final_project/data_flight.dart/flight_results.dart';

class AirlineTicketsPage extends StatefulWidget {
  const AirlineTicketsPage({super.key});

  @override
  State<AirlineTicketsPage> createState() => _AirlineTicketsPageState();
}

class _AirlineTicketsPageState extends State<AirlineTicketsPage> {
  String travelClass = 'Economy';
  String passengers = '1 Passenger';
  bool isRoundTrip = false;
  DateTime? departureDate;
  DateTime? returnDate;

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        departureDate = picked;
      });
    }
  }

  Future<void> pickReturnDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: departureDate ?? DateTime.now(),
      firstDate: departureDate ?? DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        returnDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF63B3ED), Color(0xFF4299E1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Back Button
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 10),

                // ✅ Title & Subtitle
                const Center(
                  child: Column(
                    children: [
                      Text(
                        'Find Your Perfect Flight',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Book flights to anywhere in the world with the best prices guaranteed',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // ✅ White Form Container
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.search, color: Colors.black87),
                          const SizedBox(width: 8),
                          const Text(
                            'Search Flights',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          const Text('Round trip'),
                          Switch(
                            value: isRoundTrip,
                            onChanged: (value) {
                              setState(() {
                                isRoundTrip = value;
                                if (!isRoundTrip) returnDate = null;
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      buildTextField(fromController, 'Enter departure city', Icons.flight_takeoff),
                      const SizedBox(height: 12),
                      buildTextField(toController, 'Enter destination city', Icons.flight_land),
                      const SizedBox(height: 16),

                      // ✅ Departure Label + Picker
                      const Text(
                        'Departure Date',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      buildDatePickerField(
                        label: 'Select departure date',
                        selectedDate: departureDate,
                        onTap: pickDate,
                      ),

                      // ✅ Return Label + Picker (if round trip)
                      if (isRoundTrip) ...[
                        const SizedBox(height: 16),
                        const Text(
                          'Return Date',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        buildDatePickerField(
                          label: 'Select return date',
                          selectedDate: returnDate,
                          onTap: pickReturnDate,
                        ),
                      ],
                      const SizedBox(height: 16),

                      // ✅ Passengers & Class
                      Row(
                        children: [
                          Expanded(
                            child: buildDropdownField(
                              label: 'Passengers',
                              value: passengers,
                              items: const [
                                '1 Passenger',
                                '2 Passengers',
                                '3 Passengers',
                                '4+ Passengers',
                              ],
                              icon: Icons.person,
                              onChanged: (value) {
                                setState(() {
                                  passengers = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: buildDropdownField(
                              label: 'Class',
                              value: travelClass,
                              items: const ['Economy', 'Business', 'First Class'],
                              icon: Icons.chair,
                              onChanged: (value) {
                                setState(() {
                                  travelClass = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // ✅ Search Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.search),
                          label: const Text(
                            'Search Flights',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            if (fromController.text.isNotEmpty &&
                                toController.text.isNotEmpty &&
                                departureDate != null &&
                                (!isRoundTrip || returnDate != null)) {
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
                                  content: Text('Please complete all fields.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      TextEditingController controller, String hint, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF7FAFC),
        prefixIcon: Icon(icon, color: Colors.grey),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
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
          hintText: label,
          prefixIcon: const Icon(Icons.date_range),
          filled: true,
          fillColor: const Color(0xFFF7FAFC),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        child: Text(
          selectedDate == null
              ? ''
              : '${selectedDate.month}/${selectedDate.day}/${selectedDate.year}',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required IconData icon,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: const Color(0xFFF7FAFC),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
