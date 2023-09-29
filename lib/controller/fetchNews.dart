// https://newsapi.org/v2/top-headlines?sources=google-news-in&apiKey=b60e98b4ff5748039173136b19cc0ed7
// https://newsapi.org/v2/top-headlines?country=in&language=en&apiKey=${apikey}
import 'dart:convert';
import 'dart:math';
import 'package:buzz_bulletin/model/newsArt.dart';
import 'package:http/http.dart';

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
      throw Exception("Error getting News data");
    }
  }
}