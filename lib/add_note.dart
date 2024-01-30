// ignore_for_file: use_build_context_synchronously

import 'package:db_try1mobapp1/add_update_delete_read_functions.dart';
import 'package:db_try1mobapp1/main.dart';
import 'package:flutter/material.dart';

class AddNote extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();
  DatabaseCURD databaseCURD = DatabaseCURD();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: note,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your your note',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your note';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await databaseCURD.insert(note: note.text);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyApp(),
                      ));
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
