import 'package:flutter/material.dart';
import 'package:final_project/data_flight.dart/flight_details.dart';

class FlightResultsPage extends StatelessWidget {
  final String from;
  final String to;
  final DateTime? departureDate;
  final DateTime? returnDate;
  final String travelClass;

  const FlightResultsPage({
    super.key,
    required this.from,
    required this.to,
    required this.departureDate,
    required this.returnDate,
    required this.travelClass,
  });

  List<Map<String, String>> getFlightResults() {
    final dep = from.toLowerCase();
    final arr = to.toLowerCase();
    final key = '$dep-$arr-$travelClass'.toLowerCase();

    final Map<String, List<Map<String, String>>> simulatedDB = {
      'manila-singapore-economy': [
        {'airline': 'Scoot', 'time': '6:00 AM', 'price': '₱7,800'},
        {'airline': 'Jetstar', 'time': '11:00 AM', 'price': '₱8,300'},
      ],
      'manila-singapore-business': [
        {'airline': 'Singapore Airlines', 'time': '9:00 AM', 'price': '₱22,000'},
        {'airline': 'Cebu Pacific', 'time': '5:00 PM', 'price': '₱18,500'},
      ],
      'manila-singapore-first class': [
        {'airline': 'Singapore Airlines', 'time': '1:00 PM', 'price': '₱35,000'},
        {'airline': 'PAL', 'time': '7:00 PM', 'price': '₱30,000'},
      ],
      'manila-tokyo-economy': [
        {'airline': 'ANA', 'time': '10:00 AM', 'price': '₱19,000'},
        {'airline': 'JAL', 'time': '3:00 PM', 'price': '₱21,000'},
      ],
      'manila-tokyo-business': [
        {'airline': 'JAL', 'time': '8:00 AM', 'price': '₱28,000'},
        {'airline': 'ANA', 'time': '2:00 PM', 'price': '₱29,500'},
      ],
      'manila-tokyo-first class': [
        {'airline': 'ANA', 'time': '9:00 AM', 'price': '₱55,000'},
        {'airline': 'JAL', 'time': '1:30 PM', 'price': '₱60,000'},
      ],
      'manila-cebu-economy': [
        {'airline': 'Cebu Pacific', 'time': '6:00 AM', 'price': '₱2,800'},
        {'airline': 'AirAsia', 'time': '10:00 AM', 'price': '₱3,100'},
      ],
      'manila-cebu-business': [
        {'airline': 'PAL', 'time': '7:30 AM', 'price': '₱6,500'},
        {'airline': 'Cebu Pacific', 'time': '3:30 PM', 'price': '₱5,900'},
      ],
      'manila-cebu-first class': [
        {'airline': 'PAL', 'time': '9:00 AM', 'price': '₱9,000'},
        {'airline': 'Cebu Pacific', 'time': '5:00 PM', 'price': '₱8,800'},
      ],
      'cebu-manila-economy': [
        {'airline': 'Cebu Pacific', 'time': '8:00 AM', 'price': '₱2,900'},
        {'airline': 'AirAsia', 'time': '4:00 PM', 'price': '₱3,000'},
      ],
      'cebu-singapore-economy': [
        {'airline': 'Scoot', 'time': '12:00 PM', 'price': '₱10,000'},
        {'airline': 'Jetstar', 'time': '6:00 PM', 'price': '₱10,800'},
      ],
      'cebu-singapore-business': [
        {'airline': 'Singapore Airlines', 'time': '1:00 PM', 'price': '₱21,000'},
        {'airline': 'Scoot', 'time': '7:30 PM', 'price': '₱19,900'},
      ],
      'cebu-singapore-first class': [
        {'airline': 'Singapore Airlines', 'time': '10:00 AM', 'price': '₱33,000'},
        {'airline': 'PAL', 'time': '4:00 PM', 'price': '₱30,500'},
      ],
      'cebu-tokyo-economy': [
        {'airline': 'ANA', 'time': '6:00 AM', 'price': '₱24,000'},
        {'airline': 'JAL', 'time': '11:00 AM', 'price': '₱23,500'},
      ],
      'cebu-tokyo-first class': [
        {'airline': 'JAL', 'time': '2:00 PM', 'price': '₱56,000'},
        {'airline': 'ANA', 'time': '5:00 PM', 'price': '₱58,200'},
      ],
      'tokyo-manila-economy': [
        {'airline': 'PAL', 'time': '7:00 AM', 'price': '₱18,000'},
        {'airline': 'Cebu Pacific', 'time': '6:00 PM', 'price': '₱17,000'},
      ],
      'tokyo-manila-business': [
        {'airline': 'ANA', 'time': '8:00 AM', 'price': '₱30,000'},
        {'airline': 'JAL', 'time': '2:00 PM', 'price': '₱28,000'},
      ],
      'tokyo-manila-first class': [
        {'airline': 'ANA', 'time': '9:00 AM', 'price': '₱50,000'},
        {'airline': 'JAL', 'time': '1:00 PM', 'price': '₱52,000'},
      ],
    };

    return simulatedDB[key] ??
        [
          {'airline': 'SkyAir', 'time': '6:00 AM', 'price': '₱14,000'},
          {'airline': 'BudgetWings', 'time': '4:00 PM', 'price': '₱13,500'},
        ];
  }

  @override
  Widget build(BuildContext context) {
    final flights = getFlightResults();

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text('Available Flights'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDetail('From', from),
            buildDetail('To', to),
            buildDetail('Departure', formatDate(departureDate)),
            buildDetail('Return', formatDate(returnDate)),
            buildDetail('Class', travelClass),
            const SizedBox(height: 20),
            const Text(
              'Flight Options:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: flights.length,
                itemBuilder: (context, index) {
                  final flight = flights[index];
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.flight_takeoff, color: Colors.indigo),
                        title: Text(
                          '${flight['airline']} - ${flight['time']}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          'Price: ${flight['price']}',
                          style: const TextStyle(color: Colors.black54),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FlightDetailsPage(
                                from: from,
                                to: to,
                                airline: flight['airline'] ?? '',
                                time: flight['time'] ?? '',
                                price: flight['price'] ?? '',
                                travelClass: travelClass,
                                departureDate: departureDate,
                                returnDate: returnDate,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.month}/${date.day}/${date.year}';
  }

  Widget buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}