import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';
import 'ewaste_report_bottom_sheet.dart';

class CitizenHomePage extends StatefulWidget {
  const CitizenHomePage({super.key});

  @override
  State<CitizenHomePage> createState() => _CitizenHomePageState();
}

class _CitizenHomePageState extends State<CitizenHomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  AnimationController? _animController;
  Animation<double>? _fadeAnim;

  // ---------- Brand Colors ----------
  static const kOrange = Color(0xFFfd6f22);
  static const kOrangeDark = Color(0xFFe05a10);
  static const kSurface = Color(0xFFF7F7F7);
  static const kCard = Colors.white;
  static const kTextDark = Color(0xFF1A1A1A);
  static const kTextMid = Color(0xFF6B6B6B);

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController!,
      curve: Curves.easeOut,
    );
    _animController!.forward();
  }

  @override
  void dispose() {
    _animController?.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() => _currentIndex = index);
    _animController
      ?..reset()
      ..forward();
  }

  // ---- Page bodies ----
  Widget get _homePage => FadeTransition(
    opacity: _fadeAnim ?? const AlwaysStoppedAnimation(1.0),
    child: _HomeContent(onReport: _openReportSheet),
  );

  final List<Widget> _staticPages = [
    const _PlaceholderPage(label: "My Requests", icon: Icons.list_alt_rounded),
    const _PlaceholderPage(
      label: "Learn & Educate",
      icon: Icons.school_rounded,
    ),
    const _PlaceholderPage(label: "Profile", icon: Icons.person_rounded),
  ];

  void _openReportSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const EwasteReportBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [_homePage, ..._staticPages];

    return Scaffold(
      backgroundColor: kSurface,

      // ---- Gradient AppBar ----
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [kOrangeDark, kOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.recycling, color: Colors.white, size: 22),
            SizedBox(width: 8),
            Text(
              "E-Waste",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 22,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        child: pages[_currentIndex],
      ),

      // ---- FAB ----
      floatingActionButton: FloatingActionButton(
        onPressed: _openReportSheet,
        backgroundColor: kOrange,
        elevation: 6,
        shape: const CircleBorder(),
        child: const Icon(Icons.recycling, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// =========================================================
//  HOME CONTENT
// =========================================================
class _HomeContent extends StatelessWidget {
  final VoidCallback onReport;
  const _HomeContent({required this.onReport});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 100),
      children: [
        // ---- Hero Banner ----
        _HeroBanner(onReport: onReport),

        const SizedBox(height: 20),

        // ---- Nearby Drop-offs ----
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: _SectionTitle("Nearby Drop-off Points"),
        ),
        const SizedBox(height: 10),
        const _NearbyDropoffs(),

        const SizedBox(height: 24),

        // ---- Recent Activity ----
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: _SectionTitle("Recent Activity"),
        ),
        const SizedBox(height: 10),
        const _RecentActivity(),
      ],
    );
  }
}

// =========================================================
//  HERO BANNER
// =========================================================
class _HeroBanner extends StatelessWidget {
  final VoidCallback onReport;
  const _HeroBanner({required this.onReport});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFe05a10), Color(0xFFfd6f22), Color(0xFFff9a57)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFfd6f22).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hello, Alex 👋",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Make the Planet\nGreener Today",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onReport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFe05a10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Report E-Waste",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.recycling, size: 46, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

// =========================================================
//  NEARBY DROP-OFFS  (horizontal cards with fake map pin)
// =========================================================
class _NearbyDropoffs extends StatelessWidget {
  const _NearbyDropoffs();

  static const _locations = [
    (name: "Arusha Recycling Hub", dist: "0.8 km", open: true),
    (name: "CBD Collection Point", dist: "1.4 km", open: true),
    (name: "Njiro Tech Center", dist: "2.1 km", open: false),
    (name: "Sakina Drop Zone", dist: "3.5 km", open: true),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _locations.length,
        itemBuilder: (ctx, i) {
          final loc = _locations[i];
          return Container(
            width: 175,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFfd6f22).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.location_on_rounded,
                        color: Color(0xFFfd6f22),
                        size: 16,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: loc.open
                            ? const Color(0xFF2ECC71).withOpacity(0.12)
                            : Colors.red.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        loc.open ? "Open" : "Closed",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: loc.open
                              ? const Color(0xFF27AE60)
                              : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  loc.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.directions_walk_rounded,
                      size: 12,
                      color: Color(0xFF6B6B6B),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      loc.dist,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B6B6B),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Navigate →",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFfd6f22),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// =========================================================
//  RECENT ACTIVITY FEED
// =========================================================
class _RecentActivity extends StatelessWidget {
  const _RecentActivity();

  static const _items = [
    (
      icon: Icons.check_circle_rounded,
      title: "Pickup Completed",
      subtitle: "Your e-waste was collected",
      time: "2h ago",
      color: Color(0xFF2ECC71),
    ),
    (
      icon: Icons.hourglass_top_rounded,
      title: "Report Under Review",
      subtitle: "TV set & 2 monitors",
      time: "Yesterday",
      color: Color(0xFFF39C12),
    ),
    (
      icon: Icons.recycling,
      title: "Items Recycled",
      subtitle: "3 phones sent to recycler",
      time: "3 days ago",
      color: Color(0xFF3498DB),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: _items.asMap().entries.map((entry) {
            final i = entry.key;
            final item = entry.value;
            return Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: item.color.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item.icon, color: item.color, size: 20),
                  ),
                  title: Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  subtitle: Text(
                    item.subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B6B6B),
                    ),
                  ),
                  trailing: Text(
                    item.time,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF6B6B6B),
                    ),
                  ),
                ),
                if (i < _items.length - 1)
                  const Divider(height: 1, indent: 60, endIndent: 16),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1A1A1A),
          ),
        ),
        Text(
          "See all",
          style: TextStyle(
            fontSize: 13,
            color: const Color(0xFFfd6f22).withOpacity(0.85),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  final String label;
  final IconData icon;
  const _PlaceholderPage({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 60, color: const Color(0xFFfd6f22).withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B6B6B),
            ),
          ),
        ],
      ),
    );
  }
}
