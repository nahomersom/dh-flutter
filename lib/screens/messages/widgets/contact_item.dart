import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  Map<String, dynamic> contact;
  ContactItem({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: contact['image'] != null
          ? CircleAvatar(
              backgroundImage: AssetImage(contact['image']),
            )
          : CircleAvatar(
              backgroundColor: contact['color'],
              child: Text(
                contact['initials'],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      title: Text(contact['name']),
      subtitle: const Text('Last seen recently'),
    );
  }
}
