import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class JournalEntryFields {
  late String title;
  late String body;
  late String rating;
  late String date;

  @override
  String toString(){
    return 'Title: $title, Body: $body, Rating: $rating, Date: $date';
  }
}

class JournalEntryForm extends StatefulWidget {
  @override
  _JournalEntryFormState createState() => _JournalEntryFormState();
}

class _JournalEntryFormState extends State<JournalEntryForm> {
  final formKey = GlobalKey<FormState>();
  final journalEntryValues = JournalEntryFields();

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
                ElevatedButton(
                    onPressed:() {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel')
                ),
                ElevatedButton(
                  onPressed:() async {
                    if(formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      addDateToJournalEntryValues();

                      print('printing.. $journalEntryValues');
                      await deleteDatabase('journal.db');
                      final Database database = await openDatabase(
                        'journal.db',
                        version: 1,
                        onCreate: (Database db, int version) async {
                          await db.execute('CREATE TABLE IF NOT EXISTS journal_entries(id INTEGER PRIMARY KEY, title TEXT, body TEXT, rating TEXT, date TEXT)');
                        }
                      );
                      await database.transaction( (txn) async {
                        await txn.rawInsert('INSERT INTO journal_entries(title, body, rating, date) VALUES(?, ?, ?, ?)',
                            [journalEntryValues.title, journalEntryValues.body, journalEntryValues.rating, journalEntryValues.date]);
                      });
                      print('this is saved');
                      await database.close();

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

  void addDateToJournalEntryValues() {
    DateTime _now = DateTime.now();
    journalEntryValues.date = _now.toString();
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
