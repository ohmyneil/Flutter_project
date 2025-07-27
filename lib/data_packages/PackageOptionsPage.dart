import 'package:flutter/material.dart';
import '../data_packages/data.dart';

class PackageOptionsPage extends StatefulWidget {
  final Map<String, dynamic> package;
  final Map<String, dynamic> options;

  const PackageOptionsPage({
    super.key,
    required this.package,
    required this.options,
  });

  @override
  State<PackageOptionsPage> createState() => _PackageOptionsPageState();
}

class _PackageOptionsPageState extends State<PackageOptionsPage> {
  DateTime? selectedDate;
  int travelers = 2;
  bool payWithCard = true;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final priceStr = widget.package['price'].replaceAll('₱', '').replaceAll(',', '');
    final price = double.parse(priceStr);
    final discount = 50;
    final serviceFee = 25;
    final total = (price * travelers) - discount + serviceFee;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Tour Info Card
          _buildInfoCard(),
          const SizedBox(height: 16),
          const Divider(height: 32),

          // Date Selection
          _buildDateSelection(),
          const SizedBox(height: 20),

          // Travelers Selection
          _buildTravelersSection(),
          const Divider(height: 32),

          // Traveler Info Form
          _buildTravelerForm(),
          const Divider(height: 32),

          // Payment Method
          _buildPaymentMethod(),
          const Divider(height: 32),

          // Price Summary
          _buildPriceSummary(total),
          const SizedBox(height: 20),

          // Book Button
          _buildBookButton(total),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.package['title'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 4),
          Text(widget.package['description']),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                widget.package['price'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              const Text('per person'),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Location: ${widget.options['location']}',
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            'Duration: ${widget.options['time']}',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Date',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        TextFormField(
          readOnly: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.calendar_today),
            hintText: 'dd/mm/yyyy',
            filled: true,
            fillColor: Colors.white,
          ),
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (picked != null) {
              setState(() => selectedDate = picked);
            }
          },
          controller: TextEditingController(
            text: selectedDate == null
                ? ''
                : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
          ),
        ),
      ],
    );
  }

  Widget _buildTravelersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Travelers',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Number of Travelers'),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline, color: Colors.blue),
                    onPressed: () => setState(() {
                      if (travelers > 1) travelers--;
                    }),
                  ),
                  Text(
                    travelers.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline, color: Colors.blue),
                    onPressed: () => setState(() => travelers = travelers < 15 ? travelers + 1 : 15),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Text(
          'Maximum 15 people',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildTravelerForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Traveler Information',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: firstNameController,
          decoration: const InputDecoration(
            labelText: 'First Name *',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your first name';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: lastNameController,
          decoration: const InputDecoration(
            labelText: 'Last Name *',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your last name';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email *',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: phoneController,
          decoration: const InputDecoration(
            labelText: 'Phone Number *',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPaymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        RadioListTile(
          value: true,
          groupValue: payWithCard,
          title: Row(
            children: [
              const Icon(Icons.credit_card, color: Colors.blue),
              const SizedBox(width: 8),
              const Text("Credit/Debit Card"),
            ],
          ),
          onChanged: (value) => setState(() => payWithCard = value!),
        ),
        RadioListTile(
          value: false,
          groupValue: payWithCard,
          title: Row(
            children: [
              const Icon(Icons.payment, color: Colors.blue),
              const SizedBox(width: 8),
              const Text("PayPal"),
            ],
          ),
          onChanged: (value) => setState(() => payWithCard = value!),
        ),
      ],
    );
  }

  Widget _buildPriceSummary(double total) {
    final priceStr = widget.package['price'].replaceAll('₱', '').replaceAll(',', '');
    final price = double.parse(priceStr);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price Summary',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        _buildPriceRow(
          'Base Price ($travelers x ${widget.package['price']})',
          '₱${(price * travelers).toStringAsFixed(2)}',
        ),
        _buildPriceRow(
          'Discount (Promo)',
          '-₱50.00',
          isDiscount: true,
        ),
        _buildPriceRow(
          'Service Fee',
          '₱25.00',
        ),
        const Divider(),
        _buildPriceRow(
          'Total',
          '₱${total.toStringAsFixed(2)}',
          isTotal: true,
        ),
      ],
    );
  }

  Widget _buildBookButton(double total) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            if (firstNameController.text.isEmpty ||
                lastNameController.text.isEmpty ||
                emailController.text.isEmpty ||
                phoneController.text.isEmpty ||
                selectedDate == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please fill all required fields'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            // Show booking confirmation message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Booking Completed!"),
                backgroundColor: Colors.green,
              ),
            );

            // Navigate back to the homepage
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.popUntil(context, (route) => route.isFirst);
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Complete Booking -',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                ' ₱${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '* Your payment is secure & protected',
          style: TextStyle(fontSize: 12, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isDiscount = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isDiscount ? Colors.green : Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isDiscount ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}