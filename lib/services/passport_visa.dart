import 'package:flutter/material.dart';
import 'package:final_project/Passport_visa/passport_visa_info.dart';

class PassportVisaInfoPage extends StatelessWidget {
  const PassportVisaInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fc),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600, // Changed to blue
        elevation: 0,
        title: const Text("Passport & Visa Services"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: const [
                    Icon(Icons.travel_explore, size: 48, color: Colors.blue), // Changed to blue
                    SizedBox(height: 12),
                    Text(
                      "Travel with Ease",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // Changed to blue
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "We offer professional passport and visa assistance tailored to your travel needs. Let us handle the paperwork while you plan your journey.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Our Services",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16),

            // PASSPORT CARD
            _buildServiceCard(
              icon: Icons.assignment_ind,
              title: "Passport Assistance",
              content: [
                "✔ New passport application",
                "✔ Renewal and updates",
                "✔ Lost passport replacement",
                "✔ Appointment scheduling",
              ],
              context: context,
            ),

            const SizedBox(height: 20),

            // VISA CARD
            _buildServiceCard(
              icon: Icons.document_scanner,
              title: "Visa Services",
              content: [
                "✔ Tourist visas (Japan, Korea, Schengen, etc.)",
                "✔ Business visa assistance",
                "✔ Consultation & documentation review",
                "✔ Fast-track visa processing",
              ],
              context: context,
            ),

            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.arrow_forward_ios),
                label: const Text("Start Application", style: TextStyle(color: Colors.white)), // White text
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PassportVisaPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Changed to blue
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required List<String> content,
    required BuildContext context,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 30, color: Colors.blue), // Changed to blue
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...content.map((item) => Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 6),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.blue, size: 18), // Changed to blue
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}