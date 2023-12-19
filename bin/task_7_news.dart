import 'package:hw_flutter/task_7_news.dart';

void main(List<String> arguments) {
  final news = NewsRepository(Duration(seconds: 5));
  news.getNews();
}