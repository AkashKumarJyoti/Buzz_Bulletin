import 'dart:convert';
import 'dart:math';
import 'package:buzz_bulletin/model/newsArt.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class FetchNews
{
  // We pick the source randomly from the list sourcesId
  // From each source we will get 10 items(news), so total we will get 270 (27 sources are taken)
  static List sourcesId = [
    "abc-news",
    "bbc-news",
    "bbc-sport",
    "business-insider",
    "engadget",
    "entertainment-weekly",
    "espn",
    "espn-cric-info",
    "financial-post",
    "fox-news",
    "fox-sports",
    "globo",
    "google-news",
    "google-news-in",
    "medical-news-today",
    "national-geographic",
    "news24",
    "new-scientist",
    "new-york-magazine",
    "next-big-future",
    "techcrunch",
    "techradar",
    "the-hindu",
    "the-wall-street-journal",
    "the-washington-times",
    "time",
    "usa-today",
  ];

  // We make static so that it can be accessible from another file
  static Future<NewsArt> fetchNews() async
  {
    // We will pick news sources randomly from sourcesId
    final randomSourceId = Random();
    var sourceId = sourcesId[randomSourceId.nextInt(sourcesId.length)];

    var finalUrl = "https://newsapi.org/v2/top-headlines?sources=$sourceId&apiKey=b60e98b4ff5748039173136b19cc0ed7";
    Response response = await get(Uri.parse(finalUrl));
    if(response.statusCode == 200)  // It indicates that HTTP request was successful
    {
      Map body_data = jsonDecode(response.body);

      List articles = body_data["articles"];

      // Now we will randomly select the articles from the above randomly selected sourceID
      final randomArticles = Random();
      var myArticle = articles[randomArticles.nextInt(articles.length)];

      return NewsArt.fromAPItoApp(myArticle);  // Modelling the data
    }
    else
    {
      print('HTTP Error: ${response.statusCode}');
      print('Response Body: ${response.body}');
      throw Exception('Error getting News data');
    }
  }

  // word search
  static Future<NewsArt> search({required String word}) async
  {
    // We need to give 1 month before the today's date
    DateTime currentDate = DateTime.now();
    DateTime oneMonthAgo = currentDate.subtract(const Duration(days: 30));
    String formattedDate = DateFormat('yyyy-MM-dd').format(oneMonthAgo);

    // It will give the data that is related to the search word in english language
    var finalUrl = "https://newsapi.org/v2/everything?q=$word&from=$formattedDate&sortBy=publishedAt&language=en&apiKey=b60e98b4ff5748039173136b19cc0ed7";

    Response response = await get(Uri.parse(finalUrl));
    print("URL: ${Uri.encodeFull(finalUrl)}");
    if(response.statusCode == 200)
    {
      Map body_data = jsonDecode(response.body);
      List articles = body_data["articles"];
      final randomArticles = Random();
      var myArticle = articles[randomArticles.nextInt(articles.length)];
      return NewsArt.fromAPItoApp(myArticle);
    }
    else
    {
      print('HTTP Error: ${response.statusCode}');
      print('Response Body: ${response.body}');
      throw Exception("Error getting News data words");
    }
  }

  // Category wise selection of news
  static Future<NewsArt> categorySearch({required String category}) async
  {
    var finalUrl = "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=b60e98b4ff5748039173136b19cc0ed7";

    Response response = await get(Uri.parse(finalUrl));
    print("URL: ${Uri.encodeFull(finalUrl)}");
    if(response.statusCode == 200)
    {
      Map body_data = jsonDecode(response.body);
      List articles = body_data["articles"];
      final randomArticles = Random();
      var myArticle = articles[randomArticles.nextInt(articles.length)];
      return NewsArt.fromAPItoApp(myArticle);
    }
    else
    {
      throw Exception("Error getting News data category wise");
    }
  }

  // Top headlines
  static Future<NewsArt> headlines() async
  {
    var finalUrl = "https://newsapi.org/v2/top-headlines?country=in&language=en&apiKey=b60e98b4ff5748039173136b19cc0ed7";
    Response response = await get(Uri.parse(finalUrl));
    print("URL: ${Uri.encodeFull(finalUrl)}");
    if(response.statusCode == 200)
    {
      Map body_data = jsonDecode(response.body);
      List articles = body_data["articles"];
      final randomArticles = Random();
      var myArticle = articles[randomArticles.nextInt(articles.length)];
      return NewsArt.fromAPItoApp(myArticle);
    }
    else
    {
      throw Exception("Error getting News top headlines");
    }
  }
}
