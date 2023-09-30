import 'package:intl/intl.dart';

// The data which i am getting through fetchNews method is quite complex, so to make it easily accessible we need data modelling
class NewsArt
{
  String imgUrl;
  String newsHead;
  String newsDesc;
  String newsContent;
  String newsUrl;
  String time;
  // Constructor of NewsArt
  NewsArt({required this.imgUrl, required this.newsHead, required this.newsDesc, required this.newsContent, required this.newsUrl, required this.time});

  static NewsArt fromAPItoApp(Map<String, dynamic> article)
  {
    return NewsArt(
        imgUrl: article["urlToImage"] ?? "images/breaking_news.jpg",
        newsHead: article["title"] ?? "--",    // Default value is given to prevent the app from crash when data is not available
        newsDesc: article["description"] ?? "--",
        newsContent: article["content"] ?? "--",
        newsUrl: article["url"] ?? "https://news.google.com/home?hl=en-IN&gl=IN&ceid=IN:en", // Sometimes newsUrl may be null so the default url is given
        time: timeformat(article)
    );
  }

  // It will format the date from the api data
  static String timeformat(Map<String, dynamic> article)
  {
    String timeStamp = article['publishedAt'];
    DateTime dateTime = DateTime.parse(timeStamp);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    print(formattedDate);
    return formattedDate;
  }
}