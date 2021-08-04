import 'database_manager.dart';
import '../models/journal_entry.dart';

class JournalEntryDAO {
  static Future<List<JournalEntry>> journalEntries({required DatabaseManager databaseManager}) async {
    final journalRecords = await databaseManager.journalEntries();
    return journalRecords.map( (record) {
      return JournalEntry(
          title: record['title'],
          body: record['body'],
          rating: record['rating'],
          dateTime: record['date']
      );
    }).toList();
  }
}