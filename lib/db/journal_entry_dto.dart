class JournalEntryDTO {
  late String title;
  late String body;
  late String rating;
  late String dateTime;

  String toString() =>
      'Title: $title, Body: $body, Rating: $rating, Date: ${dateTime.toString()}';
}