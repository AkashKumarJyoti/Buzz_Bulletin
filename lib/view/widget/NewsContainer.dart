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
    if (widget.imgUrl.contains("https:////")) {   // Some images url are badly formatted
      setState(() {
        widget.imgUrl = widget.imgUrl.replaceAll("https:////", "https://");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            widget.imgUrl == 'images/breaking_news.jpg'     // If condition true then show this image
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'images/breaking_news.jpg',
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Padding(                                // Show FadeInImage
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        placeholder: const AssetImage('images/breaking_news.jpg'),
                        image: NetworkImage(widget.imgUrl),
                        imageErrorBuilder: (context, error, stackTrace)
                        {
                          return Image.asset('images/breaking_news.jpg');        // It will handle if the url image does not exist
                        },
                      ),
                    ),
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
                  HtmlWidget(
                      // Using HtmlWidget instead of Text because some data may contain in the form of html
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
              height: 10.0,
            ),
            const Center(child: Icon(Icons.keyboard_double_arrow_down_outlined, color: Colors.deepPurple)),
            const SizedBox(height: 10.0)
          ],
        ));
  }
}
