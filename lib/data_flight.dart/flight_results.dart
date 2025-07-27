import 'package:flutter/material.dart';
import 'flight_details.dart';

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

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> flights = [
      {
        'airline': 'SkyWings',
        'departure': '08:30',
        'arrival': '16:15',
        'duration': '7h 45m',
        'stops': 'Direct',
        'class': 'Economy',
        'price': '\$599',
        'rating': '4.8'
      },
      {
        'airline': 'AirElite',
        'departure': '14:15',
        'arrival': '23:35',
        'duration': '9h 20m',
        'stops': '1 Stop',
        'class': 'Economy',
        'price': '\$749',
        'rating': '4.6'
      },
      {
        'airline': 'CloudJet',
        'departure': '19:45',
        'arrival': '03:55+1',
        'duration': '8h 10m',
        'stops': 'Direct',
        'class': 'Business',
        'price': '\$899',
        'rating': '4.9'
      }
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back to Search
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Text(
                '← Back to Search',
                style: TextStyle(color: Colors.blueGrey, fontSize: 14),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '$from → $to',
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            Text(
              '${formatDate(departureDate)} • ${flights.length} flights found',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            // Flight Cards
            Expanded(
              child: ListView.builder(
                itemCount: flights.length,
                itemBuilder: (context, index) {
                  final flight = flights[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      child: Row(
                        children: [
                          // Airline Icon
                          Column(
                            children: [
                              const Icon(Icons.flight, size: 32, color: Colors.blue),
                              const SizedBox(height: 4),
                              Text(flight['rating'], style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                          const SizedBox(width: 16),
                          // Flight Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  flight['airline'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(flight['departure'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const Icon(Icons.arrow_forward, size: 16),
                                    Text(flight['arrival'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(from, style: const TextStyle(fontSize: 12)),
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(flight['stops'],
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.blue)),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(to, style: const TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Pricing and Button
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  flight['class'],
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                flight['price'],
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'per person',
                                style:
                                    TextStyle(fontSize: 10, color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => FlightDetailsPage(
                                        from: from,
                                        to: to,
                                        departureDate: departureDate,
                                        returnDate: returnDate,
                                        travelClass: travelClass,
                                        airline: flight['airline'],
                                        time: flight['departure'],
                                        price: flight['price'],
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2563EB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                ),
                                child: const Text(
                                  'Select Flight',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
