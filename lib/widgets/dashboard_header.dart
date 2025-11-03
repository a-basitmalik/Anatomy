import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  final String studentName;
  final VoidCallback onNotificationTap;

  const DashboardHeader({
    super.key,
    required this.studentName,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back,",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              studentName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        // Notifications Button
        GestureDetector(
          onTap: onNotificationTap,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFF141936),
              border: Border.all(color: Colors.white24),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFF4757),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}