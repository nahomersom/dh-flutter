import 'package:flutter/material.dart';

class SharedSelectableCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final dynamic value;
  final dynamic groupValue;
  final Function(dynamic) onChanged;
  final bool selected;

  const SharedSelectableCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 102,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: selected
              ? const Color(0xFF8B77C6) // Selected border color
              : Colors.transparent, // Default no border
          width: 2.0,
        ),
        color: selected
            ? const Color(
                0xFFF5F0FF) // Light purple background for selected state
            : Colors.white, // Default background color
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          // Text, icon, and description take 90% width
          Expanded(
            flex: 9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: const Color(0xFF8B77C6)), // Icon color
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Radio button takes 10% width
          Expanded(
            flex: 1,
            child: Radio<dynamic>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: Colors.green, // Color of the selected radio button
            ),
          ),
        ],
      ),
    );
  }
}
