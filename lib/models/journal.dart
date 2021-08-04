import '../screens/journal_entry.dart';

class Journal {
  List<JournalEntry> entries;

  Journal({required this.entries});

  bool get isEmpty => entries.isEmpty;
}