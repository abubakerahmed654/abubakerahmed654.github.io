// ignore_for_file: deprecated_member_use

import 'package:bxliv_media/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetInTouchSection extends StatefulWidget {
  const GetInTouchSection({super.key});

  @override
  State<GetInTouchSection> createState() => _GetInTouchSectionState();
}

class _GetInTouchSectionState extends State<GetInTouchSection> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _companyController;
  late TextEditingController _projectController;
  bool _isHoveredSubmit = false;
  bool _isHoveredBudget = false;
  bool _isHoveredGoal = false;

  String? _selectedBudgetRange;
  String? _selectedCampaignGoal;
  bool _isLoading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final budgetRanges = [
    '5K - 10K',
    '10K - 25K',
    '25K - 50K',
    '50K - 100K',
    '100K+',
  ];

  final campaignGoals = [
    'Brand Awareness',
    'Audience Growth',
    'Engagement & Reach',
    'Sales & Conversions',
    'Product Launch',
    'Content Creation',
    'Influencer Partnerships',
    'Other',
  ];

  final Map<String, String> _errorMessages = {};

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _companyController = TextEditingController();
    _projectController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _companyController.dispose();
    _projectController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    _errorMessages.clear();

    // Name validation
    if (_nameController.text.isEmpty) {
      _errorMessages['name'] = 'Full name is required';
    } else if (_nameController.text.length < 2) {
      _errorMessages['name'] = 'Name must be at least 2 characters';
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(_nameController.text)) {
      _errorMessages['name'] = 'Name can only contain letters and spaces';
    }

    // Email validation
    if (_emailController.text.isEmpty) {
      _errorMessages['email'] = 'Email is required';
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(_emailController.text)) {
      _errorMessages['email'] = 'Please enter a valid email address';
    }

    // Company validation
    if (_companyController.text.isEmpty) {
      _errorMessages['company'] = 'Company name is required';
    } else if (_companyController.text.length < 2) {
      _errorMessages['company'] = 'Company name must be at least 2 characters';
    }

    // Budget range validation
    if (_selectedBudgetRange == null) {
      _errorMessages['budget'] = 'Please select a budget range';
    }

    // Campaign goal validation
    if (_selectedCampaignGoal == null) {
      _errorMessages['goal'] = 'Please select a campaign goal';
    }

    // Project description validation
    if (_projectController.text.isEmpty) {
      _errorMessages['project'] = 'Tell us about your project';
    } else if (_projectController.text.length < 10) {
      _errorMessages['project'] = 'Description must be at least 10 characters';
    } else if (_projectController.text.length > 500) {
      _errorMessages['project'] = 'Description cannot exceed 500 characters';
    }

    return _errorMessages.isEmpty;
  }

  Future<void> _submitInquiry() async {
    if (!_validateForm()) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields correctly'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _firestore.collection('applications').add({
        'Type': 'Brand',
        'fullName': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'company': _companyController.text.trim(),
        'budgetRange': _selectedBudgetRange,
        'campaignGoal': _selectedCampaignGoal,
        'projectDescription': _projectController.text.trim(),
        'submittedAt': FieldValue.serverTimestamp(),
        'status': 'pending',
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Inquiry submitted successfully! We\'ll contact you soon.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      // Clear form
      _nameController.clear();
      _emailController.clear();
      _companyController.clear();
      _projectController.clear();
      setState(() {
        _selectedBudgetRange = null;
        _selectedCampaignGoal = null;
        _errorMessages.clear();
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return _buildFormContent(context, isMobile);
  }

  Widget _buildFormContent(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 400,
        vertical: isMobile ? 60 : 100,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFFBE8F3),
            Color(0xFFE8F9F7),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              // Title
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'GET IN ',
                      style: GoogleFonts.inter(
                        fontSize: isMobile ? 36 : 56,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'TOUCH',
                      style: GoogleFonts.inter(
                        fontSize: isMobile ? 36 : 56,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF26d9d0),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Subtitle
              SizedBox(
                width: 700,
                child: Text(
                  'Tell us about your brand and goals. We\'ll craft a custom strategy.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 14 : 16,
                    color: Colors.grey[700],
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              // Form fields
              LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      // Row 1: Full Name and Email
                      if (isMobile)
                        Column(
                          children: [
                            _buildFormField(
                              label: 'Full Name *',
                              hint: 'Your name',
                              controller: _nameController,
                              errorMessage: _errorMessages['name'],
                            ),
                            const SizedBox(height: 24),
                            _buildFormField(
                              label: 'Work Email *',
                              hint: 'you@company.com',
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              errorMessage: _errorMessages['email'],
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            Expanded(
                              child: _buildFormField(
                                label: 'Full Name *',
                                hint: 'Your name',
                                controller: _nameController,
                                errorMessage: _errorMessages['name'],
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: _buildFormField(
                                label: 'Work Email *',
                                hint: 'you@company.com',
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                errorMessage: _errorMessages['email'],
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 24),
                      // Row 2: Company and Budget Range
                      if (isMobile)
                        Column(
                          children: [
                            _buildFormField(
                              label: 'Company *',
                              hint: 'Company name',
                              controller: _companyController,
                              errorMessage: _errorMessages['company'],
                            ),
                            const SizedBox(height: 24),
                            _buildDropdown(
                              label: 'Budget Range *',
                              hint: 'Select range',
                              value: _selectedBudgetRange,
                              items: budgetRanges,
                              onChanged: (value) {
                                setState(() => _selectedBudgetRange = value);
                              },
                              isHovered: _isHoveredBudget,
                              onHover: (val) =>
                                  setState(() => _isHoveredBudget = val),
                              errorMessage: _errorMessages['budget'],
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            Expanded(
                              child: _buildFormField(
                                label: 'Company *',
                                hint: 'Company name',
                                controller: _companyController,
                                errorMessage: _errorMessages['company'],
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: _buildDropdown(
                                label: 'Budget Range *',
                                hint: 'Select range',
                                value: _selectedBudgetRange,
                                items: budgetRanges,
                                onChanged: (value) {
                                  setState(
                                      () => _selectedBudgetRange = value);
                                },
                                isHovered: _isHoveredBudget,
                                onHover: (val) =>
                                    setState(() => _isHoveredBudget = val),
                                errorMessage: _errorMessages['budget'],
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 24),
                      // Campaign Goals
                      _buildDropdown(
                        label: 'Campaign Goals *',
                        hint: 'Select primary goal',
                        value: _selectedCampaignGoal,
                        items: campaignGoals,
                        onChanged: (value) {
                          setState(() => _selectedCampaignGoal = value);
                        },
                        isHovered: _isHoveredGoal,
                        onHover: (val) =>
                            setState(() => _isHoveredGoal = val),
                        errorMessage: _errorMessages['goal'],
                      ),
                      const SizedBox(height: 24),
                      // Project Description
                      _buildTextArea(
                        label: 'Tell us about your project *',
                        hint: 'What are you looking to achieve?',
                        controller: _projectController,
                        errorMessage: _errorMessages['project'],
                      ),
                      const SizedBox(height: 32),
                      // Submit Button
                      MouseRegion(
                        onEnter: (_) =>
                            setState(() => _isHoveredSubmit = true),
                        onExit: (_) =>
                            setState(() => _isHoveredSubmit = false),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submitInquiry,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isHoveredSubmit
                                  ? AppColors.accentCyan2
                                  : Colors.transparent,
                              disabledBackgroundColor:
                                  AppColors.accentMagenta.withOpacity(0.6),
                              foregroundColor: _isHoveredSubmit
                                  ? Colors.white
                                  : Colors.black,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: _isHoveredSubmit
                                      ? AppColors.accentCyan2
                                      : Colors.black.withOpacity(0.2),
                                  width: .9,
                                ),
                              ),
                              elevation: _isHoveredSubmit ? 8 : 0,
                            ),
                            child: _isLoading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                        Colors.black.withOpacity(0.6),
                                      ),
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Text(
                                    'Submit Inquiry',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: _isHoveredSubmit
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? errorMessage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[400],
            ),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color:
                    errorMessage != null ? Colors.red : Colors.grey[300]!,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color:
                    errorMessage != null ? Colors.red : Colors.grey[300]!,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: errorMessage != null
                    ? Colors.red
                    : AppColors.accentMagenta,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        if (errorMessage != null) ...[
          const SizedBox(height: 6),
          Text(
            errorMessage,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required bool isHovered,
    required Function(bool) onHover,
    String? errorMessage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        MouseRegion(
          onEnter: (_) => onHover(true),
          onExit: (_) => onHover(false),
          child: Container(
            decoration: BoxDecoration(
              color: isHovered
                  ? AppColors.accentCyan2.withOpacity(0.1)
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: errorMessage != null
                    ? Colors.red
                    : (isHovered
                        ? AppColors.accentCyan2
                        : Colors.grey[300]!),
                width: isHovered ? 2 : 1,
              ),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: value,
              hint: Text(
                hint,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
              ),
              borderRadius: BorderRadius.circular(8),
              onChanged: onChanged,
              icon: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: isHovered
                      ? AppColors.accentCyan2
                      : Colors.grey[600],
                ),
              ),
              underline: const SizedBox(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              items: items
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        if (errorMessage != null) ...[
          const SizedBox(height: 6),
          Text(
            errorMessage,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTextArea({
    required String label,
    required String hint,
    required TextEditingController controller,
    String? errorMessage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              '${controller.text.length}/500',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: controller.text.length > 500
                    ? Colors.red
                    : Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: 5,
          onChanged: (value) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[400],
            ),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color:
                    errorMessage != null ? Colors.red : Colors.grey[300]!,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color:
                    errorMessage != null ? Colors.red : Colors.grey[300]!,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: errorMessage != null
                    ? Colors.red
                    : AppColors.accentMagenta,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        if (errorMessage != null) ...[
          const SizedBox(height: 6),
          Text(
            errorMessage,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}