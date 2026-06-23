import 'package:flutter/material.dart';
import 'package:sample_app_3/models/contact.dart';
import 'package:sample_app_3/detailspage.dart'; 

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Contact> contacts = Contact.getAllContacts();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List View Sample",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(contacts[index].image),
              ),
              title: Text(contacts[index].name),
              subtitle: Text(contacts[index].phoneNumber),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ContactDetails(
                      contact: contacts[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}