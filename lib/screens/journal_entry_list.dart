import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../widgets/journal_scaffold.dart';
import '../widgets/journal_entry_form.dart';
import 'journal_entry.dart';
import 'new_entry.dart';
import '../widgets/settings_drawer.dart';
import '../models/journal.dart';

class JournalEntries extends StatefulWidget {
  static const routeName = '/';

  @override
  _JournalEntriesState createState() => _JournalEntriesState();
}

class _JournalEntriesState extends State<JournalEntries> {

  late Journal journal;

  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    final Database database = await openDatabase(
      'journal.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE IF NOT EXISTS journal_entries(id INTEGER PRIMARY KEY, title TEXT, body TEXT, rating TEXT, date TEXT)');
      }
    );
    List<Map> journalRecords = await database.rawQuery('SELECT * FROM journal_entries');
    final journalEntries = journalRecords.map((record) {
      return JournalEntry(
        title: record['title'],
        body: record['body'],
        rating: record['rating'],
        dateTime: DateTime.parse(record['date']));
    }).toList();
    print('instance of $journalEntries');
    setState(() {
      journal = Journal(entries: journalEntries);
    });
  }

  Widget build(BuildContext context) {
    if(journal == null) {
      return JournalScaffold(
        title: 'Loading',
        child: Center(child: CircularProgressIndicator())
      );
    } else {
      return JournalScaffold(
          title: journal.isEmpty ? 'Welcome' : 'Journal Entries',
          child: journal.isEmpty ? welcome() : journalList(context)
      );
    }
  }

  Widget journalList(BuildContext context){
    return ListView.builder(
        itemCount: journal.entries.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text('Journal Entry ${journal.entries[index].title}'),
              subtitle: Text('${journal.entries[index].dateTime}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JournalEntry(
                      title: journal.entries[index].title,
                      body: journal.entries[index].body,
                      rating: journal.entries[index].rating,
                      dateTime: journal.entries[index].dateTime,
                    ),
                  ),
                );
              }
          );
        }
    );
  }

  Widget welcome() {
    return Center(
      child: Text('hello')
    );
  }

  FloatingActionButton addEntryFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed(NewEntry.routeName);
      },
      child: Icon(Icons.add)
    );
  }
}
