// ignore_for_file: use_build_context_synchronously

import 'package:db_try1mobapp1/add_update_delete_read_functions.dart';
import 'package:db_try1mobapp1/main.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key, required this.id, required this.note});
  final int id;
  final String note;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController noteController = TextEditingController();

  DatabaseCURD databaseCURD = DatabaseCURD();
  @override
  void initState() {
    super.initState();
    noteController.text = widget.note;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
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
                controller: noteController,
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
                  await databaseCURD.updart(
                      id: widget.id, note: noteController.text);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyApp(),
                      ));
                }
              },
              child: const Text('Save changing'),
            ),
          ],
        ),
      ),
    );
  }
}
