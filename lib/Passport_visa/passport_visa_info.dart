import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data'; // Needed to show image on web

class PassportVisaPage extends StatefulWidget {
  const PassportVisaPage({Key? key}) : super(key: key);

  @override
  State<PassportVisaPage> createState() => _PassportVisaPageState();
}

class _PassportVisaPageState extends State<PassportVisaPage> {
  int _currentStep = 0;
  String _applicationType = 'Passport';
  String _fullName = '';
  String _birthDate = '';
  double _processingSpeed = 1.0;
  bool _documentsUploaded = false;

  // ignore: unused_field
  XFile? _documentImage;
  Uint8List? _documentImageBytes;

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _birthDateController = TextEditingController();

  @override
  void dispose() {
    _birthDateController.dispose();
    super.dispose();
  }

  Future<void> _pickDocumentImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _documentImage = image;
        _documentImageBytes = bytes;
        _documentsUploaded = true;
      });
    }
  }

  Future<void> _selectBirthDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _birthDate = "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
        _birthDateController.text = _birthDate;
      });
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Application Submitted"),
        content: const Text(
          "Thank you! Your Passport/Visa application has been submitted. Our agent will contact you shortly.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentStep = 0;
                _applicationType = 'Passport';
                _processingSpeed = 1.0;
                _documentsUploaded = false;
                _fullName = '';
                _birthDate = '';
                _documentImage = null;
                _documentImageBytes = null;
                _birthDateController.clear();
              });
            },
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Passport & Visa Assistance"),
        backgroundColor: Colors.blue, // Changed to blue
      ),
      body: SingleChildScrollView(
        child: Stepper(
          currentStep: _currentStep,
          type: StepperType.vertical,
          onStepTapped: (step) => setState(() => _currentStep = step),
          onStepContinue: () {
            if (_currentStep == 1 && !_formKey.currentState!.validate()) return;
            if (_currentStep < 4) {
              setState(() => _currentStep++);
            } else {
              _showConfirmationDialog();
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep--);
            }
          },
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Changed to blue
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(_currentStep == 4 ? 'Submit' : 'Next', style: const TextStyle(color: Colors.white)), // White text
                  ),
                  const SizedBox(width: 10),
                  if (_currentStep > 0)
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: const Text('Back'),
                    ),
                ],
              ),
            );
          },
          steps: [
            Step(
              title: const Text("Select Service Type"),
              content: Column(
                children: [
                  RadioListTile<String>(
                    value: 'Passport',
                    groupValue: _applicationType,
                    title: const Text('Passport'),
                    onChanged: (value) => setState(() => _applicationType = value!),
                  ),
                  RadioListTile<String>(
                    value: 'Tourist Visa',
                    groupValue: _applicationType,
                    title: const Text('Tourist Visa'),
                    onChanged: (value) => setState(() => _applicationType = value!),
                  ),
                  RadioListTile<String>(
                    value: 'Business Visa',
                    groupValue: _applicationType,
                    title: const Text('Business Visa'),
                    onChanged: (value) => setState(() => _applicationType = value!),
                  ),
                ],
              ),
              isActive: _currentStep >= 0,
              state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            ),
            Step(
              title: const Text("Enter Personal Information"),
              content: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Full Name",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      onChanged: (value) => _fullName = value,
                      validator: (value) => value!.isEmpty ? "Name is required" : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _birthDateController,
                      readOnly: true,
                      onTap: _selectBirthDate,
                      decoration: const InputDecoration(
                        labelText: "Birthdate (MM/DD/YYYY)",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.cake),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? "Birthdate is required" : null,
                    ),
                  ],
                ),
              ),
              isActive: _currentStep >= 1,
              state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            ),
            Step(
              title: const Text("Select Processing Time"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Processing: ${_processingSpeed == 1 ? "Regular (5–7 days)" : "Express (1–2 days)"}",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Slider(
                    value: _processingSpeed,
                    min: 1,
                    max: 2,
                    divisions: 1,
                    label: _processingSpeed == 1 ? 'Regular' : 'Express',
                    activeColor: Colors.blue, // Changed to blue
                    onChanged: (value) => setState(() => _processingSpeed = value),
                  ),
                ],
              ),
              isActive: _currentStep >= 2,
              state: _currentStep > 2 ? StepState.complete : StepState.indexed,
            ),
            Step(
              title: const Text("Upload Required Documents"),
              content: Column(
                children: [
                  if (_documentImageBytes != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(_documentImageBytes!, height: 150),
                    )
                  else
                    const Icon(Icons.insert_drive_file,
                        size: 80, color: Colors.grey),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _pickDocumentImage,
                    icon: const Icon(Icons.upload),
                    label: const Text("Upload Document", style: TextStyle(color: Colors.white)), // White text
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), // Changed to blue
                  ),
                ],
              ),
              isActive: _currentStep >= 3,
              state: _documentsUploaded ? StepState.complete : StepState.indexed,
            ),
            Step(
              title: const Text("Review & Submit"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Service Type: $_applicationType"),
                  Text("Full Name: $_fullName"),
                  Text("Birthdate: $_birthDate"),
                  Text("Processing Time: ${_processingSpeed == 1 ? "Regular" : "Express"}"),
                  Text("Document Uploaded: ${_documentsUploaded ? "Yes" : "No"}"),
                  const SizedBox(height: 10),
                  const Text(
                    "Please ensure all information is correct before submitting.",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              isActive: _currentStep >= 4,
              state: _currentStep == 4 ? StepState.editing : StepState.indexed,
            ),
          ],
        ),
      ),
    );
  }
}