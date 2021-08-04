import 'package:cs492_project4/models/journal_entry.dart';
import 'package:flutter/material.dart';
import '../db/database_manager.dart';
import '../widgets/journal_scaffold.dart';
import 'journal_entry.dart';
import 'new_entry.dart';
import '../models/journal.dart';
import '../models/journal_entry.dart';
import '../db/journal_entry_dao.dart';

class JournalEntries extends StatefulWidget {
  static const routeName = '/';

  @override
  _JournalEntriesState createState() => _JournalEntriesState();
}

class _JournalEntriesState extends State<JournalEntries> {

  Journal? journal;

  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    final databaseManager = DatabaseManager.getInstance();
    List<JournalEntry> journalEntries = await JournalEntryDAO.journalEntries(databaseManager: databaseManager);
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
          title: journal!.isEmpty ? 'Welcome' : 'Journal Entries',
          child: journal!.isEmpty ? welcome() : journalList(context)
      );
    }
  }

  Widget journalList(BuildContext context){
    return ListView.builder(
        itemCount: journal!.entries.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text('Journal Entry ${journal!.entries[index].title}'),
              subtitle: Text('${journal!.entries[index].dateTime}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JournalEntryScreen(
                      entry: journal!.entries[index],
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
