import 'package:flutter/material.dart';

class RegisterAs extends StatelessWidget {
  const RegisterAs({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xfffd6f22);

    return Scaffold(
      backgroundColor: Colors.white,

      // ───────── APP BAR ─────────
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'E-Waste Management',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xfffd6f22), Color(0xffff914d)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      // ───────── BODY ─────────
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ───────── HEADER ─────────
              const Text(
                "Choose Action",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Text(
                "Manage your electronic waste easily",
                style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
              ),

              const SizedBox(height: 30),

              // ───────── CARD 1 ─────────
              _buildActionCard(
                icon: Icons.upload_rounded,
                title: "Submit E-Waste",
                description:
                    "Submit your e-waste for collection. Our team will pick it up from your location.",
                buttonText: "E-Waste Submit",
                primaryColor: primaryColor,
                onTap: () {},
              ),

              const SizedBox(height: 24),

              // ───────── CARD 2 ─────────
              _buildActionCard(
                icon: Icons.recycling,
                title: "E-Waste Collector",
                description:
                    "View and manage all collected e-waste. Track collection status and history.",
                buttonText: "E-Waste Collector",
                primaryColor: primaryColor,
                onTap: () {},
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ───────── REUSABLE CARD ─────────
  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String description,
    required String buttonText,
    required Color primaryColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon + Title
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.10),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: primaryColor, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Description
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 22),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onTap,
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(buttonText),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
                    shape: const StadiumBorder(),
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
