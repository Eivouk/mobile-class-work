import 'package:flutter/material.dart';
import 'package:sample_app_3/models/contact.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails({super.key, required this.contact});

  final Contact contact;

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name)      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              CircleAvatar(
                radius: 120,
                backgroundImage: AssetImage(contact.image),
              ),
              const SizedBox(height: 15),
            Text(
              contact.name,
              style: const TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Text(
              contact.phoneNumber,
              style: const TextStyle(
                fontSize: 20, ),
            ),
          ],
        ),
      ),
    )
    );
  }
}