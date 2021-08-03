import 'package:flutter/material.dart';
import '../widgets/journal_entry_form.dart';

class NewEntry extends StatelessWidget {
  static const routeName = 'new_entry';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Journal Entry'),
      ),
      body: JournalEntryForm(),
    );
  }
}
