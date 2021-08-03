import 'package:flutter/material.dart';
import '../widgets/journal_scaffold.dart';

class JournalEntriesScreen extends StatelessWidget {
  static const routeName = 'journal_entries';

  final items = List<Map>.generate(10000, (i) {
    return {
      'title': 'Journal Entry $i',
      'subtitle': 'Subtitle for $i',
    };
  });

  @override
  Widget build(BuildContext context) {
    return JournalScaffold(
      title: 'Journal Entries',
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: FlutterLogo(),
              trailing: Icon(Icons.more_horiz),
              title: Text('Journal Entry ${items[index]['title']}'),
              subtitle: Text('Example ${items[index]['subtitle']}'),
              // onTap: Navigator.of(context).pushNamed()
            );
          }
      )
    );
  }
}
