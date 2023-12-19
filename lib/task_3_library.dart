import 'dart:convert';
import 'package:crypto/crypto.dart';

extension Uuid on (String, String) {
  String generateUuid() {
    var bytes = utf8.encode(this.$1 + this.$2); // Convert the input string to bytes
    var hash = md5.convert(bytes); // Generate the MD5 hash
    return hash.toString(); // Convert the hash to a string
  }
}

class Library {
  // Just intentionally used Records here to practice this feature
  // despite of it woild be more convenient to use class
  final Map<String, (String, String)> books;
  // it has to be set however the task specifies to use List 
  final List<Reader> readers = [];
  final Set<String> issuedBooks = {};

  Library([List<(String, String)>? books])
      : books = { for ((String, String) value in books ?? []) value.generateUuid() : value };

  addBook((String, String) description) {
    books.putIfAbsent(description.generateUuid(), () => description);
  }

  removeBookByUuid(String id) {
    books.remove(id);
  }
  
  removeBookById((String, String) description) {
    books.remove(description.generateUuid());
  }

  addReader(Reader reader) {
    if (readers.contains(reader)) {
      return;
    }
    readers.add(reader);
  }

  removeReader(Reader reader) {
    readers.remove(reader);
  }

  giveBook(Reader reader, (String, String) book) {
    final String bookId = book.generateUuid();
    if (issuedBooks.contains(bookId)) {
      print('We are so sorry, book $book is issued');
      return;
    }
    addReader(reader);
    if (issuedBooks.add(bookId)) {
      reader.booksAmount++;
    }
  }

  returnBook((String, String) book) {
    issuedBooks.remove(book.generateUuid());
  }

  (String, String)? findBookByName(String name) => books.values.firstWhere((element) => element.$1 == name);

  (String, String)? findBookByAuthor(String author) => books.values.firstWhere((element) => element.$2 == author);

  Reader? findTopReader() {
    final List<Reader> sortedList = List.from(readers);
    sortedList.sort((a, b) => b.booksAmount.compareTo(a.booksAmount));
    return sortedList.firstOrNull;
  }

  @override
  String toString() {
    var libraryReport = "Books: \n";
    books.forEach((key, value) {
      libraryReport += "${issuedBooks.contains(key) ? "[X]" : "[V]" } - $value, id = $key}";
      libraryReport += "\n";
    });
    libraryReport += "Registered readers: \n";
    for (var (index, element) in readers.indexed) { 
      libraryReport += "${index + 1}. $element";
      libraryReport += "\n";
    }
    return libraryReport;
  }
}

class Reader { 
  final String name;
  DateTime? registeredAt;
  int _booksAmount = 0;
  int get booksAmount => _booksAmount;
  set booksAmount(int value) {
    if (registeredAt == null && value > 0) {
      registeredAt = DateTime.now();
    }
    _booksAmount = value;
  }


  Reader(this.name);

  @override
  String toString() {
    return "name = $name, books have been taken = $booksAmount, first book at = ${registeredAt ?? 'never'}";
  }
}
