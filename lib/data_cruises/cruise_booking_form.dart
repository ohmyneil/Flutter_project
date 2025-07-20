import 'package:flutter/material.dart';
import '../home_page.dart';
import 'package:final_project/wibgets/cart_model.dart';

class CruiseBookingFormPage extends StatefulWidget {
  final Map<String, String> cruise;

  const CruiseBookingFormPage({Key? key, required this.cruise}) : super(key: key);

  @override
  _CruiseBookingFormPageState createState() => _CruiseBookingFormPageState();
}

class _CruiseBookingFormPageState extends State<CruiseBookingFormPage> {
  DateTimeRange? _selectedDateRange;
  int _adults = 2;
  int _children = 0;
  bool _agreeToTerms = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _passportController = TextEditingController();
  final TextEditingController _emergencyNameController = TextEditingController();
  final TextEditingController _emergencyContactController = TextEditingController();

  String _cabinType = 'Balcony';
  String _departurePort = 'Manila';
  String _mealPreference = 'Standard';

  final List<String> _cabinOptions = ['Interior', 'Oceanview', 'Balcony', 'Suite'];
  final List<String> _portOptions = ['Manila', 'Cebu', 'Davao', 'Batangas'];
  final List<String> _mealOptions = ['Standard', 'Vegetarian', 'Vegan', 'Kosher'];

  String _formatDate(DateTime date) {
    return "${date.month}/${date.day}/${date.year}";
  }

  void _pickDateRange() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  void _confirmBooking() {
    if (!_formKey.currentState!.validate() || _selectedDateRange == null || !_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields, select dates, and agree to the terms.')),
      );
      return;
    }

    _showAdditionalForm();
  }

  void _showAdditionalForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Final Booking Step', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passportController,
                    decoration: const InputDecoration(labelText: 'Passport Number *', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _emergencyNameController,
                    decoration: const InputDecoration(labelText: 'Emergency Contact Name *', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _emergencyContactController,
                    decoration: const InputDecoration(labelText: 'Emergency Contact Number *', border: OutlineInputBorder()),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_passportController.text.isEmpty ||
                          _emergencyNameController.text.isEmpty ||
                          _emergencyContactController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill all required fields.')),
                        );
                        return;
                      }

                      Navigator.pop(context); // Close bottom sheet
                      _goToHomePage(); // Proceed to HomePage
                    },
                    child: const Text('Finish Booking'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, // Changed to teal
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _goToHomePage() {
    Map<String, dynamic> bookingDetails = {
      'cruise': widget.cruise,
      'name': _fullNameController.text,
      'email': _emailController.text,
      'contact': _contactController.text,
      'passport': _passportController.text,
      'emergencyName': _emergencyNameController.text,
      'emergencyContact': _emergencyContactController.text,
      'dates': _selectedDateRange,
      'adults': _adults,
      'children': _children,
      'cabinType': _cabinType,
      'departurePort': _departurePort,
      'mealPreference': _mealPreference,
      'notes': _notesController.text,
    };

    // ✅ Store to cart before navigating
    CartService.addCruiseItem(bookingDetails);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cruise = widget.cruise;

    return Scaffold(
      appBar: AppBar(
        title: Text('Book ${cruise['name']}'),
        backgroundColor: Colors.teal, // Changed to teal
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Image.network(cruise['image']!, height: 180, fit: BoxFit.cover),
              const SizedBox(height: 16),
              Text(cruise['description']!, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name *', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Full Name is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email Address *', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Email is required';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(labelText: 'Contact Number *', border: OutlineInputBorder()),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty ? 'Contact number is required' : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _cabinType,
                decoration: const InputDecoration(labelText: 'Cabin Type *', border: OutlineInputBorder()),
                items: _cabinOptions.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                onChanged: (value) => setState(() => _cabinType = value!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _departurePort,
                decoration: const InputDecoration(labelText: 'Departure Port *', border: OutlineInputBorder()),
                items: _portOptions.map((port) => DropdownMenuItem(value: port, child: Text(port))).toList(),
                onChanged: (value) => setState(() => _departurePort = value!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _mealPreference,
                decoration: const InputDecoration(labelText: 'Meal Preference *', border: OutlineInputBorder()),
                items: _mealOptions.map((meal) => DropdownMenuItem(value: meal, child: Text(meal))).toList(),
                onChanged: (value) => setState(() => _mealPreference = value!),
              ),
              const SizedBox(height: 20),
              const Text('Select Date Range:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _pickDateRange,
                icon: const Icon(Icons.date_range),
                label: const Text('Choose Dates'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal), // Changed to teal
              ),
              const SizedBox(height: 10),
              _selectedDateRange == null
                  ? const Text('No date selected.')
                  : Text(
                      'From: ${_formatDate(_selectedDateRange!.start)}\nTo: ${_formatDate(_selectedDateRange!.end)}',
                      style: TextStyle(color: Colors.green.shade700),
                    ),
              const SizedBox(height: 20),
              Text('Number of Adults: $_adults'),
              Slider(
                value: _adults.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                label: '$_adults',
                onChanged: (value) => setState(() => _adults = value.toInt()),
              ),
              Text('Number of Children: $_children'),
              Slider(
                value: _children.toDouble(),
                min: 0,
                max: 10,
                divisions: 10,
                label: '$_children',
                onChanged: (value) => setState(() => _children = value.toInt()),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Special Requests / Notes (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text("I agree to the terms and conditions."),
                value: _agreeToTerms,
                activeColor: Colors.teal, // Changed to teal
                onChanged: (value) => setState(() => _agreeToTerms = value ?? false),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _confirmBooking,
                child: const Text('Confirm Booking'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Changed to teal
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}