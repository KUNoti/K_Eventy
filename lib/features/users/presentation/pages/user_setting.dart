import 'package:flutter/material.dart';

class UserSettingsPage extends StatefulWidget {
  const UserSettingsPage({Key? key}) : super(key: key);

  @override
  _UserSettingsPageState createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  String _username = 'John Doe';
  String _email = 'johndoe@example.com';
  String _password = 'password123';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Image.network(
                'https://via.placeholder.com/150', // Placeholder image URL
                height: 150,
                width: 150,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _username,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _username = newValue!;
                },
              ),
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _email = newValue!;
                },
              ),
              TextFormField(
                initialValue: _password,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true, // Password is obscured
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _password = newValue!;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveForm() {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      // Perform saving logic here, such as updating user data in a database
      // You can also show a confirmation message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Settings saved')),
      );
    }
  }
}
