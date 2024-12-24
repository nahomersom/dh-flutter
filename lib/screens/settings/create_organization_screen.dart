import 'package:dh_flutter_v2/constants/app_theme.dart';
import 'package:dh_flutter_v2/screens/settings/widgets/profile_bottom_sheet_content.dart';
import 'package:dh_flutter_v2/widgets/shared_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateOrganizationSettingScreen extends StatefulWidget {
  const CreateOrganizationSettingScreen({Key? key}) : super(key: key);

  @override
  State<CreateOrganizationSettingScreen> createState() =>
      _CreateOrganizationSettingScreenState();
}

class _CreateOrganizationSettingScreenState
    extends State<CreateOrganizationSettingScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedIndustry;
  String? _selectedMembers;
  final TextEditingController organizationNameController =
      TextEditingController(text: '');

  // Sample industry list
  final List<String> _industries = [
    'Industries',
    'Agriculture',
    'Mining',
    'Construction',
    'Manufacturing',
    'Wholesale and Retail Trade',
    'Information and Technology',
    'Finance and Insurance',
    'Real Estate',
    'Communication and Broadcasting',
    'Professional and Business Services',
    'Education and Health Services',
    'Arts and Entertainment',
    'Public Administration',
    'Other Services'
  ];

  // Sample members list
  final List<String> _members = ['Member 1', 'Member 2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Create Organization',
          style: TextStyle(
            color: AppTheme.gray.shade600,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SharedTextFormField(
                controller: organizationNameController,
                label: 'Organization Name',
                hintText: 'Insert Organization name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter organization name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Industry',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.gray.shade600,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                value: _selectedIndustry,
                hint: Text(
                  'Select Industry',
                  style: TextStyle(
                      color: AppTheme.gray.shade400,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.baseWhite),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                items: _industries.map((String industry) {
                  return DropdownMenuItem<String>(
                    value: industry,
                    child: Text(industry),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedIndustry = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an industry';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Members',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.gray.shade600,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                value: _selectedMembers,
                hint: Text(
                  'Add Members',
                  style: TextStyle(
                      color: AppTheme.gray.shade400,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                decoration: InputDecoration(
                  filled: false,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.baseWhite),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                items: _members.map((String member) {
                  return DropdownMenuItem<String>(
                    value: member,
                    child: Text(member),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedMembers = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select members range';
                  }
                  return null;
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle form submission
                      print('Form is valid');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.baseWhite),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
