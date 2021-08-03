import 'package:flutter/material.dart';

class JournalEntryFields {
  late String title;
  late String body;
  late int rating;
}

class JournalEntryForm extends StatefulWidget {
  @override
  _JournalEntryFormState createState() => _JournalEntryFormState();
}

class _JournalEntryFormState extends State<JournalEntryForm> {
  final formKey = GlobalKey<FormState>();
  final journalEntryFields = JournalEntryFields();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            formTextInput('Title', journalEntryFields),
            formTextInput('Body', journalEntryFields),
            formTextInput('Rating', journalEntryFields),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed:() {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel')
                ),
                ElevatedButton(
                  onPressed:() {
                    if(formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      // Database.of(context).saveJournalEntry(journalEntryFields);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Save Entry')
                ),
              ],
            )
          ]
        ),
      )
    );
  }
}

Widget formTextInput(String label, final dto) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15.0),
    child: TextFormField(
        autofocus: true,
        decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder()
        ),
        onSaved: (value) {
          switch (label){
            case 'Title':
              dto.title = value!;
              break;
            case 'Body':
              dto.body = value!;
              break;
            case 'Rating':
              dto.rating = value!;
          }
        },
        validator: (value) {
          // Perform validation
          if(value == null || value.isEmpty) {
            return 'Please enter a ' + label.toLowerCase();
          } else {
            return null;
          }
        }
    ),
  );
}