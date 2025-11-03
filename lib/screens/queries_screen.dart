import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';
import '../theme/anatomy_colors.dart';

class Query {
  final int queryId;
  final int partId;
  final String question;
  final String? answer;
  final DateTime askedAt;
  final DateTime? answeredAt;
  final String status; // pending, answered

  Query({
    required this.queryId,
    required this.partId,
    required this.question,
    this.answer,
    required this.askedAt,
    this.answeredAt,
    required this.status,
  });

  bool get isAnswered => status == 'answered';
}

class QueriesScreen extends StatefulWidget {
  const QueriesScreen({super.key});

  @override
  State<QueriesScreen> createState() => _QueriesScreenState();
}

class _QueriesScreenState extends State<QueriesScreen> {
  // Sample data - in real app, this would come from API/database
  final Map<String, List<Query>> queriesByPart = {
    "Skeletal System": [
      Query(
        queryId: 1,
        partId: 1,
        question: "What's the difference between compact and spongy bone?",
        answer: "Compact bone is dense and solid, forming the outer layer of bones, while spongy bone is lighter and has a honeycomb structure found at the ends of long bones and in flat bones.",
        askedAt: DateTime.now().subtract(Duration(days: 2)),
        answeredAt: DateTime.now().subtract(Duration(days: 1)),
        status: "answered",
      ),
      Query(
        queryId: 2,
        partId: 1,
        question: "How many bones are in the human skull?",
        answer: null,
        askedAt: DateTime.now().subtract(Duration(hours: 5)),
        answeredAt: null,
        status: "pending",
      ),
    ],
    "Muscular System": [
      Query(
        queryId: 3,
        partId: 2,
        question: "What's the difference between voluntary and involuntary muscles?",
        answer: "Voluntary muscles are under conscious control (like skeletal muscles), while involuntary muscles work automatically (like cardiac and smooth muscles).",
        askedAt: DateTime.now().subtract(Duration(days: 3)),
        answeredAt: DateTime.now().subtract(Duration(days: 2)),
        status: "answered",
      ),
      Query(
        queryId: 4,
        partId: 2,
        question: "How do muscles generate force?",
        answer: "Through the sliding filament theory where actin and myosin filaments slide past each other, powered by ATP hydrolysis.",
        askedAt: DateTime.now().subtract(Duration(days: 1)),
        answeredAt: DateTime.now().subtract(Duration(hours: 12)),
        status: "answered",
      ),
    ],
    "Nervous System": [
      Query(
        queryId: 5,
        partId: 3,
        question: "What is the blood-brain barrier?",
        answer: null,
        askedAt: DateTime.now().subtract(Duration(hours: 2)),
        answeredAt: null,
        status: "pending",
      ),
    ],
    "Cardiovascular System": [
      Query(
        queryId: 6,
        partId: 4,
        question: "How does the heart's electrical system work?",
        answer: "The SA node generates electrical impulses that travel through the atria, then to the AV node, Bundle of His, and Purkinje fibers, coordinating heart contractions.",
        askedAt: DateTime.now().subtract(Duration(days: 4)),
        answeredAt: DateTime.now().subtract(Duration(days: 3)),
        status: "answered",
      ),
    ],
  };

  final Map<int, String> partNames = {
    1: "Skeletal System",
    2: "Muscular System",
    3: "Nervous System",
    4: "Cardiovascular System",
    5: "Respiratory System",
    6: "Digestive System",
  };

  final Map<String, bool> _expandedSections = {};

  @override
  void initState() {
    super.initState();
    // Initialize all sections as expanded
    for (var part in queriesByPart.keys) {
      _expandedSections[part] = true;
    }
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1B103E),
                Color(0xFF0D0A1F),
                Color(0xFF050613),
              ],
              stops: [0.0, 0.6, 1.0],
            ),
          ),
        ),
        Positioned(
          top: -100,
          right: -60,
          child: Container(
            width: 350,
            height: 350,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                radius: 0.7,
                colors: [
                  Color(0xAA9E5BFF),
                  Color(0x00000000),
                ],
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.3),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsHeader() {
    int totalQueries = 0;
    int answeredQueries = 0;

    queriesByPart.forEach((part, queries) {
      totalQueries += queries.length;
      answeredQueries += queries.where((q) => q.isAnswered).length;
    });

    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Queries",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "$totalQueries Questions Asked",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Stack(
                    children: [
                      CircularProgressIndicator(
                        value: totalQueries > 0 ? answeredQueries / totalQueries : 0,
                        strokeWidth: 8,
                        backgroundColor: Colors.white24,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00D4FF)),
                      ),
                      Center(
                        child: Text(
                          "${totalQueries > 0 ? ((answeredQueries / totalQueries) * 100).toInt() : 0}%",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem("Total Asked", "$totalQueries", Color(0xFF00D4FF)),
                _buildStatItem("Answered", "$answeredQueries", Color(0xFF00FF88)),
                _buildStatItem("Pending", "${totalQueries - answeredQueries}", Color(0xFFFF6B8B)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.5)),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPartSection(String partName, List<Query> queries) {
    final isExpanded = _expandedSections[partName] ?? false;
    final answeredCount = queries.where((q) => q.isAnswered).length;
    final pendingCount = queries.length - answeredCount;

    return GlassCard(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          // Section Header
          ListTile(
            onTap: () {
              setState(() {
                _expandedSections[partName] = !isExpanded;
              });
            },
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6B00FF),
                    Color(0xFF9E5BFF),
                  ],
                ),
              ),
              child: Icon(
                Icons.help_outline,
                color: Colors.white,
                size: 20,
              ),
            ),
            title: Text(
              partName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "$answeredCount answered • $pendingCount pending",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            trailing: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.white70,
            ),
          ),

          // Queries List
          if (isExpanded) ...[
            Divider(
              color: Colors.white.withOpacity(0.1),
              height: 1,
            ),
            ...queries.map((query) => _buildQueryItem(query)),
          ],
        ],
      ),
    );
  }

  Widget _buildQueryItem(Query query) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: query.isAnswered
                        ? Color(0xFF00FF88).withOpacity(0.2)
                        : Color(0xFFFF6B8B).withOpacity(0.2),
                  ),
                  child: Icon(
                    query.isAnswered ? Icons.check : Icons.schedule,
                    color: query.isAnswered ? Color(0xFF00FF88) : Color(0xFFFF6B8B),
                    size: 14,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    query.question,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            // Answer (if available)
            if (query.isAnswered && query.answer != null) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFF00D4FF).withOpacity(0.1),
                  border: Border.all(color: Color(0xFF00D4FF).withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: Color(0xFF00D4FF),
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Expert Answer",
                          style: TextStyle(
                            color: Color(0xFF00D4FF),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      query.answer!,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
            ],

            // Status and Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: query.isAnswered
                        ? Color(0xFF00FF88).withOpacity(0.2)
                        : Color(0xFFFF6B8B).withOpacity(0.2),
                    border: Border.all(
                      color: query.isAnswered
                          ? Color(0xFF00FF88)
                          : Color(0xFFFF6B8B),
                    ),
                  ),
                  child: Text(
                    query.isAnswered ? "Answered" : "Pending",
                    style: TextStyle(
                      color: query.isAnswered ? Color(0xFF00FF88) : Color(0xFFFF6B8B),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  _formatDateTime(query.askedAt),
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAskQuestionButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: GlassCard(
        onTap: _onAskQuestion,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF00D4FF),
                      Color(0xFF00FF88),
                    ],
                  ),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New Question",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Ask our anatomy experts",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white70,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago";
    } else {
      return "${difference.inMinutes} min${difference.inMinutes > 1 ? 's' : ''} ago";
    }
  }

  void _onAskQuestion() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1A1F3D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Ask a Question',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select a topic and ask your anatomy question',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.1),
              ),
              child: Text(
                'Feature coming soon...',
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Question submitted to experts!'),
                  backgroundColor: Color(0xFF00FF88),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF7A3FFF),
            ),
            child: Text('Submit Question'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          _buildBackground(),

          // Content
          Column(
            children: [
              // Custom App Bar
              Container(
                padding: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      "My Queries",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: Column(
                  children: [
                    // Stats Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _buildStatsHeader(),
                    ),
                    SizedBox(height: 20),

                    // Ask Question Button
                    _buildAskQuestionButton(),

                    // Queries List
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            ...queriesByPart.entries.map(
                                    (entry) => _buildPartSection(entry.key, entry.value)
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}