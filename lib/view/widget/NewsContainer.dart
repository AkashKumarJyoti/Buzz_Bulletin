import 'package:buzz_bulletin/view/detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class NewsContainer extends StatefulWidget {
  String imgUrl;
  String newsHead;
  String newsDesc;
  String newsContent;
  String newsUrl;
  String time;

  NewsContainer(
      {Key? key,
      required this.imgUrl,
      required this.newsDesc,
      required this.newsContent,
      required this.newsHead,
      required this.newsUrl,
      required this.time})
      : super(key: key);

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  @override
  void initState() {
    super.initState();
    widget.imgUrl.contains("https:////")
        ? widget.imgUrl.replaceAll("https:////", "https://")
        : widget.imgUrl;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            widget.imgUrl == 'images/breaking_news.jpg'
                ? Image.asset('images/breaking_news.jpg',
                    height: 350, width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover
            )
                : FadeInImage(
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    placeholder: const AssetImage('images/breaking_news.jpg'),
                    image: NetworkImage(
                        widget.imgUrl), // Use the corrected URL here
                  ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Published at -: "),
                      Text(widget.time,
                          style: const TextStyle(color: Colors.deepPurple))
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  HtmlWidget(       // Using HtmlWidget instead of Text because some data may contain in the form of html
                      widget.newsHead.length > 70
                          ? "${widget.newsHead.substring(0, 70)}...."
                          : widget.newsHead,
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 10.0),
                  HtmlWidget(widget.newsDesc,
                      textStyle:
                          const TextStyle(fontSize: 12, color: Colors.black38)),
                  const SizedBox(height: 10.0),
                  HtmlWidget(
                      widget.newsContent != "--"
                          ? widget.newsContent.length > 250
                              ? "${widget.newsContent.substring(0, 250)}...."
                              : "${widget.newsContent.substring(0, widget.newsContent.length - 15)}...."
                          : widget.newsContent,
                      textStyle: const TextStyle(fontSize: 16.0))
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailViewScreen(newsUrl: widget.newsUrl)));
                      },
                      child: const Text("Read More")),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            )
          ],
        ));
  }
}
