// ignore_for_file: deprecated_member_use

import 'package:bxliv_media/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ApplyNowSection extends StatefulWidget {
  const ApplyNowSection({super.key});

  @override
  State<ApplyNowSection> createState() => _ApplyNowSectionState();
}

class _ApplyNowSectionState extends State<ApplyNowSection> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _tiktokHandleController;
  late TextEditingController _bioController;

  String? _selectedFollowerRange;
  String? _selectedNiche;
  bool _isLoading = false;
  bool _isHoveredFollowers = false;
  bool _isHoveredNiche = false;
  bool _isHoveredSubmit = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final followerRanges = [
    '10K - 50K',
    '50K - 100K',
    '100K - 500K',
    '500K - 1M',
    '1M - 5M',
    '5M+',
  ];

  final contentNiches = [
    'Entertainment',
    'Gaming',
    'Fashion & Beauty',
    'Food & Cooking',
    'Fitness & Wellness',
    'Education',
    'Music & Dance',
    'Travel & Lifestyle',
    'Comedy',
    'Business & Finance',
    'Other',
  ];

  // Error messages
  final Map<String, String> _errorMessages = {};

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _tiktokHandleController = TextEditingController();
    _bioController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _tiktokHandleController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  // Validation Methods
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

    // TikTok Handle validation
    if (_tiktokHandleController.text.isEmpty) {
      _errorMessages['tiktok'] = 'TikTok handle is required';
    } else if (!_tiktokHandleController.text.startsWith('@')) {
      _errorMessages['tiktok'] = 'TikTok handle must start with @';
    } else if (_tiktokHandleController.text.length < 3) {
      _errorMessages['tiktok'] = 'TikTok handle must be at least 3 characters';
    } else if (!RegExp(r'^@[a-zA-Z0-9._]+$')
        .hasMatch(_tiktokHandleController.text)) {
      _errorMessages['tiktok'] =
          'TikTok handle can only contain letters, numbers, dots, and underscores';
    }

    // Follower count validation
    if (_selectedFollowerRange == null) {
      _errorMessages['followers'] = 'Please select a follower count range';
    }

    // Niche validation
    if (_selectedNiche == null) {
      _errorMessages['niche'] = 'Please select a content niche';
    }

    // Bio validation
    if (_bioController.text.isEmpty) {
      _errorMessages['bio'] = 'Tell us about yourself';
    } else if (_bioController.text.length < 10) {
      _errorMessages['bio'] = 'Bio must be at least 10 characters';
    } else if (_bioController.text.length > 500) {
      _errorMessages['bio'] = 'Bio cannot exceed 500 characters';
    }

    return _errorMessages.isEmpty;
  }

  Future<void> _submitApplication() async {
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
      // Add data to Firebase Firestore
      await _firestore.collection('applications').add({
        'Type': 'Creator',
        'fullName': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'tiktokHandle': _tiktokHandleController.text.trim(),
        'followerCount': _selectedFollowerRange,
        'contentNiche': _selectedNiche,
        'bio': _bioController.text.trim(),
        'submittedAt': FieldValue.serverTimestamp(),
        'status': 'pending',
      });

      // Success message
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Application submitted successfully! We\'ll be in touch within 48 hours.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      // Clear form
      _nameController.clear();
      _emailController.clear();
      _tiktokHandleController.clear();
      _bioController.clear();
      setState(() {
        _selectedFollowerRange = null;
        _selectedNiche = null;
        _errorMessages.clear();
      });
    } catch (e) {
      // Error message
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
        vertical: isMobile ? 40 : 80,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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
                      text: 'APPLY ',
                      style: GoogleFonts.inter(
                        fontSize: isMobile ? 40 : 56,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF26d9d0),
                      ),
                    ),
                    TextSpan(
                      text: 'NOW',
                      style: GoogleFonts.inter(
                        fontSize: isMobile ? 40 : 56,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Fill out the form below and we\'ll get back to you within 48 hours.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 14 : 16,
                  color: Colors.grey[700],
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 48),
              // Form fields
              LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
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
                              label: 'Email *',
                              hint: 'you@email.com',
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
                                label: 'Email *',
                                hint: 'you@email.com',
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                errorMessage: _errorMessages['email'],
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 24),
                      if (isMobile)
                        Column(
                          children: [
                            _buildFormField(
                              label: 'TikTok Handle *',
                              hint: '@yourhandle',
                              controller: _tiktokHandleController,
                              errorMessage: _errorMessages['tiktok'],
                            ),
                            const SizedBox(height: 24),
                            _buildDropdown(
                              label: 'Follower Count *',
                              hint: 'Select range',
                              value: _selectedFollowerRange,
                              items: followerRanges,
                              onChanged: (value) {
                                setState(() => _selectedFollowerRange = value);
                              },
                              isHovered: _isHoveredFollowers,
                              onHover: (val) =>
                                  setState(() => _isHoveredFollowers = val),
                              errorMessage: _errorMessages['followers'],
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            Expanded(
                              child: _buildFormField(
                                label: 'TikTok Handle *',
                                hint: '@yourhandle',
                                controller: _tiktokHandleController,
                                errorMessage: _errorMessages['tiktok'],
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: _buildDropdown(
                                label: 'Follower Count *',
                                hint: 'Select range',
                                value: _selectedFollowerRange,
                                items: followerRanges,
                                onChanged: (value) {
                                  setState(
                                      () => _selectedFollowerRange = value);
                                },
                                isHovered: _isHoveredFollowers,
                                onHover: (val) =>
                                    setState(() => _isHoveredFollowers = val),
                                errorMessage: _errorMessages['followers'],
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 24),
                      _buildDropdown(
                        label: 'Content Niche *',
                        hint: 'Select your niche',
                        value: _selectedNiche,
                        items: contentNiches,
                        onChanged: (value) {
                          setState(() => _selectedNiche = value);
                        },
                        isHovered: _isHoveredNiche,
                        onHover: (val) =>
                            setState(() => _isHoveredNiche = val),
                        errorMessage: _errorMessages['niche'],
                      ),
                      const SizedBox(height: 24),
                      _buildTextArea(
                        label: 'Tell us about yourself *',
                        hint: 'What are your goals? What makes you unique?',
                        controller: _bioController,
                        errorMessage: _errorMessages['bio'],
                      ),
                      const SizedBox(height: 32),
                      MouseRegion(
                        onEnter: (_) =>
                            setState(() => _isHoveredSubmit = true),
                        onExit: (_) =>
                            setState(() => _isHoveredSubmit = false),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:
                                _isLoading ? null : _submitApplication,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isHoveredSubmit
                                  ? AppColors.accentMagenta.withOpacity(0.9)
                                  : AppColors.accentMagenta,
                              disabledBackgroundColor:
                                  AppColors.accentMagenta.withOpacity(0.6),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: _isHoveredSubmit ? 8 : 2,
                            ),
                            child: _isLoading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                        Colors.white.withOpacity(0.8),
                                      ),
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Text(
                                    'Submit Application',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
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
                width: 2,
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