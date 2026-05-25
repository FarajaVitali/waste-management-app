import 'package:flutter/material.dart';

class EwasteReportBottomSheet extends StatefulWidget {
  const EwasteReportBottomSheet({super.key});

  @override
  State<EwasteReportBottomSheet> createState() =>
      _EwasteReportBottomSheetState();
}

class _EwasteReportBottomSheetState extends State<EwasteReportBottomSheet>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Brand colors
  static const kOrange = Color(0xFFfd6f22);
  static const kOrangeDark = Color(0xFFe05a10);
  static const kSurface = Color(0xFFF7F7F7);
  static const kTextDark = Color(0xFF1A1A1A);
  static const kTextMid = Color(0xFF6B6B6B);
  static const kBorder = Color(0xFFE0E0E0);

  String? _deviceType;
  int? _selectedConditionIndex; // 0=Working, 1=Partial, 2=Dead
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Step tracking (0 = Device Info, 1 = Condition, 2 = Notes)
  int _currentStep = 0;

  late AnimationController _slideController;
  late Animation<Offset> _slideAnim;

  final _deviceTypes = [
    (label: "Phone", icon: Icons.smartphone_rounded),
    (label: "Laptop", icon: Icons.laptop_rounded),
    (label: "Tablet", icon: Icons.tablet_rounded),
    (label: "Desktop", icon: Icons.desktop_windows_rounded),
    (label: "TV", icon: Icons.tv_rounded),
    (label: "Other", icon: Icons.devices_other_rounded),
  ];

  final _conditions = [
    (
      label: "Working",
      sub: "Powers on, functional",
      icon: Icons.check_circle_rounded,
      color: Color(0xFF2ECC71),
    ),
    (
      label: "Partially Working",
      sub: "Some functions broken",
      icon: Icons.warning_rounded,
      color: Color(0xFFF39C12),
    ),
    (
      label: "Not Working",
      sub: "Dead / won't power on",
      icon: Icons.cancel_rounded,
      color: Color(0xFFE74C3C),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _brandController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      _slideController.reset();
      setState(() => _currentStep++);
      _slideController.forward();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      _slideController.reset();
      setState(() => _currentStep--);
      _slideController.forward();
    }
  }

  bool get _canProceedStep0 => _deviceType != null;
  bool get _canProceedStep1 => _selectedConditionIndex != null;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle_rounded, color: Colors.white),
              SizedBox(width: 10),
              Text("Report Submitted Successfully!"),
            ],
          ),
          backgroundColor: const Color(0xFF2ECC71),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _formKey,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ---- Drag handle ----
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: kBorder,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // ---- Header ----
              _buildHeader(),

              // ---- Step Indicator ----
              _buildStepIndicator(),

              // ---- Step Content ----
              SlideTransition(
                position: _slideAnim,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: _buildStepContent(),
                ),
              ),

              // ---- Navigation Buttons ----
              _buildNavButtons(),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [kOrangeDark, kOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.recycling, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Report E-Waste",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: kTextDark,
                ),
              ),
              Text(
                "Help us keep Arusha clean",
                style: TextStyle(fontSize: 12, color: kTextMid),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kSurface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.close_rounded, size: 18, color: kTextMid),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  Widget _buildStepIndicator() {
    final steps = ["Device", "Condition", "Details"];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Row(
        children: List.generate(steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            // Connector line
            final stepIdx = i ~/ 2;
            final filled = stepIdx < _currentStep;
            return Expanded(
              child: Container(height: 2, color: filled ? kOrange : kBorder),
            );
          }
          final stepIdx = i ~/ 2;
          final isActive = stepIdx == _currentStep;
          final isDone = stepIdx < _currentStep;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: isActive ? 32 : 28,
            height: isActive ? 32 : 28,
            decoration: BoxDecoration(
              color: isDone
                  ? kOrange
                  : isActive
                  ? kOrange
                  : kSurface,
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive || isDone ? kOrange : kBorder,
                width: 2,
              ),
            ),
            child: Center(
              child: isDone
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : Text(
                      "${stepIdx + 1}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isActive ? Colors.white : kTextMid,
                      ),
                    ),
            ),
          );
        }),
      ),
    );
  }

  // =========================================================
  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStep0();
      case 1:
        return _buildStep1();
      case 2:
        return _buildStep2();
      default:
        return const SizedBox();
    }
  }

  // ---- Step 0: Device Type ----
  Widget _buildStep0() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What type of device?",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: kTextDark,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "Select the category that best fits",
          style: TextStyle(fontSize: 12, color: kTextMid),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.1,
          ),
          itemCount: _deviceTypes.length,
          itemBuilder: (ctx, i) {
            final d = _deviceTypes[i];
            final selected = _deviceType == d.label;
            return GestureDetector(
              onTap: () => setState(() => _deviceType = d.label),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: selected ? kOrange.withOpacity(0.1) : kSurface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: selected ? kOrange : kBorder,
                    width: selected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      d.icon,
                      color: selected ? kOrange : kTextMid,
                      size: 26,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      d.label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: selected ? kOrange : kTextDark,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        // Brand field
        _styledTextField(
          controller: _brandController,
          label: "Brand & Model",
          hint: "e.g. Samsung Galaxy A12",
          icon: Icons.business_rounded,
          required: false,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // ---- Step 1: Condition ----
  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What's the condition?",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: kTextDark,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "This helps us route it to the right recycler",
          style: TextStyle(fontSize: 12, color: kTextMid),
        ),
        const SizedBox(height: 16),
        ...List.generate(_conditions.length, (i) {
          final c = _conditions[i];
          final selected = _selectedConditionIndex == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedConditionIndex = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: selected ? c.color.withOpacity(0.08) : kSurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: selected ? c.color : kBorder,
                  width: selected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: c.color.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(c.icon, color: c.color, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.label,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: selected ? c.color : kTextDark,
                          ),
                        ),
                        Text(
                          c.sub,
                          style: const TextStyle(fontSize: 12, color: kTextMid),
                        ),
                      ],
                    ),
                  ),
                  if (selected)
                    Icon(Icons.check_circle_rounded, color: c.color, size: 20),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 8),
      ],
    );
  }

  // ---- Step 2: Notes & Submit ----
  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Any additional details?",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: kTextDark,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "Optional — helps our team prepare for pickup",
          style: TextStyle(fontSize: 12, color: kTextMid),
        ),
        const SizedBox(height: 16),

        // Summary chip
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [kOrangeDark, kOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.summarize_rounded,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "${_deviceType ?? 'Device'} • ${_selectedConditionIndex != null ? _conditions[_selectedConditionIndex!].label : 'Condition TBD'}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Description field
        TextFormField(
          controller: _descriptionController,
          maxLines: 4,
          style: const TextStyle(fontSize: 14, color: kTextDark),
          decoration: InputDecoration(
            hintText: "Screen broken, battery swollen, missing charger...",
            hintStyle: const TextStyle(color: kTextMid, fontSize: 13),
            filled: true,
            fillColor: kSurface,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: kBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: kBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: kOrange, width: 2),
            ),
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  // =========================================================
  Widget _buildNavButtons() {
    final isLast = _currentStep == 2;
    final isFirst = _currentStep == 0;

    final canProceed = _currentStep == 0
        ? _canProceedStep0
        : _currentStep == 1
        ? _canProceedStep1
        : true;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Row(
        children: [
          if (!isFirst)
            Expanded(
              child: OutlinedButton(
                onPressed: _prevStep,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  side: const BorderSide(color: kBorder, width: 1.5),
                ),
                child: const Text(
                  "Back",
                  style: TextStyle(
                    color: kTextMid,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          if (!isFirst) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: canProceed ? (isLast ? _submit : _nextStep) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: kOrange,
                disabledBackgroundColor: kBorder,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: canProceed ? 4 : 0,
                shadowColor: kOrange.withOpacity(0.4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLast ? "Submit Report" : "Continue",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    isLast ? Icons.check_rounded : Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  Widget _styledTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool required = true,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontSize: 14, color: kTextDark),
      validator: required
          ? (v) => (v == null || v.isEmpty) ? "Required" : null
          : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: kTextMid, size: 20),
        labelStyle: const TextStyle(color: kTextMid, fontSize: 13),
        hintStyle: const TextStyle(color: kTextMid, fontSize: 13),
        filled: true,
        fillColor: kSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kOrange, width: 2),
        ),
      ),
    );
  }
}
