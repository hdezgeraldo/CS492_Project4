import 'package:cs492_project4/models/journal_entry.dart';
import 'package:flutter/material.dart';
import '../db/database_manager.dart';
import '../widgets/journal_scaffold.dart';
import 'journal_entry.dart';
import 'new_entry.dart';
import '../models/journal.dart';
import '../models/journal_entry.dart';
import '../db/journal_entry_dao.dart';
import '../widgets/single_entry.dart';

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

  Widget layoutDecider() {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
            return horizontalLayout(context);
          } else {
            return verticalLayout(context);
          }
        },
      ),
    );
  }

  Widget journalList(BuildContext context){
    return layoutDecider();
  }

  Widget journalListBuilder(BuildContext context) {
    return ListView.builder(
        itemCount: journal!.entries.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text
                ('Journal Entry ${journal!.entries[index].title}',
                  style: Theme.of(context).textTheme.headline6
              ),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.book_rounded,
            size: 100.0,
          ),
          Text('Journal')
        ],
      ),
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

  Widget verticalLayout(BuildContext context) {
    return journalListBuilder(context);
  }

  Widget horizontalLayout(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: journalListBuilder(context)
          ),
          Expanded(
              child: SingleEntry(
                  title: journal!.entries[0].title,
                  body: journal!.entries[0].body)
          )
        ],
      ),
    );
  }
}
