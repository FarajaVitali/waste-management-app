import 'package:flutter/material.dart';
import '../widgets/form_input.dart';
import '../widgets/form_dropdown.dart'; // ← Make sure this import is correct

class CitizenAdditionalInfoPage extends StatefulWidget {
  const CitizenAdditionalInfoPage({super.key});

  @override
  State<CitizenAdditionalInfoPage> createState() =>
      _CitizenAdditionalInfoPageState();
}

// Fixed: Added "State" at the end
class _CitizenAdditionalInfoPageState extends State<CitizenAdditionalInfoPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _selectedRegion;
  String? _selectedDistrict;

  bool _isLoading = false;

  final List<String> regions = [
    'Arusha',
    'Dar es Salaam',
    'Mwanza',
    'Dodoma',
    'Mbeya',
    'Tanga',
  ];

  // Fixed: Renamed to districtsByRegion for clarity
  final Map<String, List<String>> districtsByRegion = {
    'Arusha': ['Arusha City', 'Arumeru', 'Monduli', 'Ngorongoro'],
    'Dar es Salaam': ['Ilala', 'Kinondoni', 'Temeke', 'Ubungo', 'Kigamboni'],
    'Mwanza': [
      'Ilemela',
      'Kwimba',
      'Magu',
      'Nyamagana',
      'Sengerema',
      'Ukerewe',
    ],
    'Dodoma': ['Bahi', 'Dodoma City', 'Chamwino', 'Chemba', 'Kondoa', 'Kongwa'],
    // Add more regions as needed
  };

  @override
  void dispose() {
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // TODO: Send data to backend
      // Example: await saveUserInfo(...);

      setState(() => _isLoading = false);

      // Navigate to home page
      // Navigator.pushReplacementNamed(context, '/citizen_home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ← Removed MaterialApp (very important fix!)
      appBar: AppBar(
        title: const Text(
          "Complete Your Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xfffd6f22),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Help us serve you better",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              FormInput(
                "Phone No",
                controller: _phoneController,
                validator: (value) =>
                    value!.isEmpty ? "Phone number is required" : null,
              ),

              const SizedBox(height: 16),

              CustomDropdownField<String>(
                labelText: "Region",
                items: regions,
                value: _selectedRegion,
                onChanged: (value) {
                  setState(() {
                    _selectedRegion = value;
                    _selectedDistrict = null; // Reset district
                  });
                },
                validator: (value) =>
                    value == null ? "Please select your region" : null,
              ),

              const SizedBox(height: 16),

              CustomDropdownField<String>(
                labelText: "District",
                items: _selectedRegion != null
                    ? districtsByRegion[_selectedRegion] ?? []
                    : [],
                value: _selectedDistrict,
                onChanged: (value) {
                  setState(() => _selectedDistrict = value);
                },
                validator: (value) =>
                    value == null ? "Please select your district" : null,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xfffd6f22),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffffffff),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
