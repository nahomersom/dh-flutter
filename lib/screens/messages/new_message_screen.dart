import 'package:dh_flutter_v2/screens/messages/widgets/contact_item.dart';
import 'package:dh_flutter_v2/screens/messages/widgets/section_header.dart';
import 'package:flutter/material.dart';

class NewMessageScreen extends StatelessWidget {
  const NewMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> contacts = [
      {'name': 'Abraham Muluneh', 'initials': 'AM', 'color': Colors.blue},
      {'name': 'Adera Tadesse', 'initials': '', 'image': 'assets/person1.png'},
      {'name': 'Abel Mekonnen', 'initials': 'AM', 'color': Colors.green},
      {'name': 'Abebe Habtamu', 'initials': '', 'image': 'assets/person2.png'},
      {'name': 'Biruk Mulugeta', 'initials': 'BM', 'color': Colors.lightBlue},
      {'name': 'Daniel Yusuf', 'initials': 'DY', 'color': Colors.yellow},
      {'name': 'Fanuel Girma', 'initials': 'FG', 'color': Colors.red},
      {'name': 'Fikirte Yishak', 'initials': '', 'image': 'assets/person3.png'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Message'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                fillColor: Colors.grey[200],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Contact List
          Expanded(
            child: ListView(
              children: [
                SectionHeader(letter: 'A'),
                ContactItem(contact: contacts[0]),
                ContactItem(contact: contacts[1]),
                ContactItem(contact: contacts[2]),
                ContactItem(contact: contacts[3]),
                SectionHeader(letter: 'B'),
                ContactItem(contact: contacts[4]),
                SectionHeader(letter: 'D'),
                ContactItem(contact: contacts[5]),
                SectionHeader(letter: 'F'),
                ContactItem(contact: contacts[6]),
                ContactItem(contact: contacts[7]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
