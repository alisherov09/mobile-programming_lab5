import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String phone;
  final String email;

  const Contact({
    required this.name,
    required this.phone,
    required this.email,
  });
}

const mockContacts = [
  Contact(
    name: 'Sarah Connor',
    phone: '+1 (555) 019-2834',
    email: 'sarah.connor@resistance.net',
  ),
  Contact(
    name: 'John Doe',
    phone: '+1 (555) 432-8765',
    email: 'john.doe@example.com',
  ),
  Contact(
    name: 'Elena Rostova',
    phone: '+44 20 7946 0912',
    email: 'elena.rostova@techcorp.uk',
  ),
  Contact(
    name: 'Kenji Sato',
    phone: '+81 3 5555 0143',
    email: 'kenji.sato@global.jp',
  ),
  Contact(
    name: 'Amina Diallo',
    phone: '+221 33 800 1234',
    email: 'amina.diallo@innovate.sn',
  ),
];

void main() => runApp(const Task3_3App());

class Task3_3App extends StatelessWidget {
  const Task3_3App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactListScreen(),
    );
  }
}

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts (5 items)'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        itemCount: mockContacts.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final contact = mockContacts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              child: Text(contact.name[0]),
            ),
            title: Text(contact.name,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(contact.phone),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Pass the whole Contact object directly into the constructor
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactScreen(contact: contact),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ContactScreen extends StatelessWidget {
  // Required Contact object passed via constructor
  final Contact contact;

  const ContactScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.indigo.shade50],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 46,
                    backgroundColor: Colors.indigo,
                    child: Text(
                      contact.name[0],
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    contact.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.phone, color: Colors.indigo),
                    title: const Text('Phone Number'),
                    subtitle: Text(
                      contact.phone,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email, color: Colors.indigo),
                    title: const Text('Email Address'),
                    subtitle: Text(
                      contact.email,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back to Contacts'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
