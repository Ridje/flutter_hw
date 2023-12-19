import 'package:hw_flutter/task_3_library.dart';

void main(List<String> arguments) {
  final books = [("Harry Potter", "J. Roaling"), ("The Holy Bible", "Unknown"), ("How to find friends", "S. Author")];
  final library = Library(books);

  Reader ilia = Reader("Ilia");
  Reader doe = Reader("Doe");
  Reader amarillo = Reader("Amarillo");

  library.giveBook(amarillo, books[1]);
  print(library);
  print("\n");

  library.giveBook(doe, books[1]);
  print("\n");

  library.giveBook(doe, books[0]);

  library.giveBook(ilia, books[2]);

  library.returnBook(books[1]);

  library.giveBook(ilia, books[1]);

  library.returnBook(books[0]);

  library.giveBook(ilia, books[0]);

  print(library);

  print(library.findBookByName("Harry Potter"));
  print(library.findBookByAuthor("Unknown"));

  print("Top reader is: ${library.findTopReader()}");
}