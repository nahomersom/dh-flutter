import 'package:flutter/material.dart';

class TimerCard extends StatelessWidget {
  TimerCard({super.key, required this.title, required this.imageUrl});
  String title;
  String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
      decoration: BoxDecoration(
          color: const Color(0xffEFECF8),
          borderRadius: BorderRadius.circular(8.0), // Rounded border
          border: Border.all(color: const Color(0xffCEC5E7), width: 1)
          // Border color
          ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imageUrl),
          const SizedBox(
            height: 6,
          ),
          Text(
            title,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Color(0xff515152),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
