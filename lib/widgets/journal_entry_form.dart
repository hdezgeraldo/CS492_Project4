import 'package:flutter/material.dart';
import '../db/database_manager.dart';
import '../db/journal_entry_dto.dart';
import '../screens/journal_entry_list.dart';

class JournalEntryForm extends StatefulWidget {
  @override
  _JournalEntryFormState createState() => _JournalEntryFormState();
}

class _JournalEntryFormState extends State<JournalEntryForm> {
  final formKey = GlobalKey<FormState>();
  final journalEntryValues = JournalEntryDTO();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            formTextInput('Title', journalEntryValues),
            formTextInput('Body', journalEntryValues),
            formTextInput('Rating', journalEntryValues),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                cancelButton(context),
                saveButton(context)
              ],
            )
          ]
        ),
      )
    );
  }

  Widget cancelButton(BuildContext context) {
    return ElevatedButton(
        onPressed:() {
          Navigator.of(context).pop();
        },
        child: Text('Cancel')
    );
  }

  Widget saveButton(BuildContext context){
    return ElevatedButton(
        child: Text('Save Entry'),
        onPressed: () async {
          if(formKey.currentState!.validate()) {
            formKey.currentState!.save();
            addDateToJournalEntryValues();
            final databaseManager = DatabaseManager.getInstance();
            databaseManager.saveJournalEntry(dto: journalEntryValues);
            Navigator.of(context).popAndPushNamed(JournalEntries.routeName);
          }
        },
    );
  }

  void addDateToJournalEntryValues() {
    DateTime _now = DateTime.now();
    journalEntryValues.dateTime = _now.toString();
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
              dto.title = value!.toString();
              break;
            case 'Body':
              dto.body = value!.toString();
              break;
            case 'Rating':
              dto.rating = value!;
              break;
          }
        },
        validator: (value) {
          // Perform validation
          if(label == 'Rating' && value is int){

          }
          if(value == null || value.isEmpty) {
            return 'Please enter a ' + label.toLowerCase();
          } else {
            return null;
          }
        }
    ),
  );
}
