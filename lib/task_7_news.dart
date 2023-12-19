import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const apiUrl =
    "https://newsapi.org/v2/top-headlines?country=us&apiKey=53e0d661caf74746a9ad4f7059e587de";
const String cacheFilePath = "news_cache.json";

class NewsRepository {
  static Uri uri = Uri.parse(apiUrl);

  final Duration cachePeriod;

  NewsRepository(this.cachePeriod);

  getNews() async {
    print("Checking news in cache");
    var news = await getFromCache();
    if (news == null) {
      print("Cache is empty, fetching news from api");
      news = await makeNewsShot();
      saveNews(news);
    } else {
      print("Cache is valid, got news from cache");
    }
    print(news);
  }

  Future<bool> saveNews(NewsData news) async {
    File cacheFile = File(cacheFilePath);
    final encodedNews = json.encode(news);
    await cacheFile.writeAsString(encodedNews);
    return true;
  }

  Future<NewsData> makeNewsShot() async {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return NewsData.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load news data');
    }
  }

  Future<NewsData?> getFromCache() async {
    NewsData? parsedCache;
    try {
      File cachedFile = File(cacheFilePath);
      String cachedString = await cachedFile.readAsString();
      final data = NewsData.fromJson(json.decode(cachedString));
      if (DateTime.now().microsecondsSinceEpoch - data.fetched < cachePeriod.inMicroseconds) {
        print(DateTime.now().microsecondsSinceEpoch - data.fetched);
        print(Duration(microseconds: DateTime.now().microsecondsSinceEpoch - data.fetched));
        print(cachePeriod.inMicroseconds);
        print(cachePeriod);
        parsedCache = data;
      }
    } catch (err) {
      parsedCache = null;
    }
    return parsedCache;
  }
}

class NewsData {
  final String status;
  final int totalResults;
  final List<ArticleData> articles;
  final int fetched;

  NewsData(this.status, this.totalResults, this.articles, this.fetched);

  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      json['status'],
      json['totalResults'].toInt(),
      json['articles']
          .map<ArticleData>((articleData) => ArticleData.fromJson(articleData))
          .toList(),
      json['fetched'] ?? DateTime.now().microsecondsSinceEpoch,
    );
  }

  @override
  String toString() {
    var printNews = "FRESH $totalResults NEWS \n";
    for (final article in articles) {
      print(article);
    }
    return printNews;
  }

  Map toJson() => {
        'status': status,
        'totalResults': totalResults,
        'articles': articles,
        'fetched': fetched,
      };
}

class ArticleData {
  final String? author;
  final String? title;
  final String? description;

  ArticleData(this.author, this.title, this.description);

  factory ArticleData.fromJson(Map<String, dynamic> json) {
    return ArticleData(json['author'], json['title'], json['description']);
  }

  @override
  String toString() {
    var article = "${title ?? "Unknown"} by ${author ?? "Unknown"} \n";
    article += description ?? "No description";
    article += "\n ---------------------- \n";
    return article;
  }

  Map toJson() => {
        'author': author,
        'title': title,
        'description': description,
      };
}
