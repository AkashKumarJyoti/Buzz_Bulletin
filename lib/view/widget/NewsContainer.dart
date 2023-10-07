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
    var screenheight = MediaQuery.of(context).size.height;
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            // News Image
            Visibility(
              visible: screenheight >= 200,
              child: widget.imgUrl == 'images/breaking_news.jpg'     // If condition true then show this image
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'images/breaking_news.jpg',
                    height: MediaQuery.of(context).size.height/3,
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
                    height: MediaQuery.of(context).size.height/3,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    placeholder: const AssetImage('images/breaking_news.jpg'),
                    image: NetworkImage(widget.imgUrl),
                    imageErrorBuilder: (context, error, stackTrace)  // It will handle if the url image does not exist
                    {
                      return Image.asset(
                        'images/breaking_news.jpg',
                        height: MediaQuery.of(context).size.height/3,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              )
            ),
            Visibility(
                visible: screenheight >= 260,
                child: const SizedBox(height: 20.0)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  // News published date
                  Visibility(
                    visible: screenheight >= 280,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Published at -: "),
                        Text(widget.time,
                            style: const TextStyle(color: Colors.deepPurple))
                      ],
                    ),
                  ),
                  Visibility(
                      visible: screenheight >= 260,
                      child: const SizedBox(height: 4.0)),

                  // Headline
                  Visibility(
                    visible: screenheight >= 450,
                    child: HtmlWidget(
                        // Using HtmlWidget instead of Text because some data may contain in the form of html
                        widget.newsHead.length > 70
                            ? "${widget.newsHead.substring(0, 70)}...."
                            : widget.newsHead,
                        textStyle: TextStyle(
                          fontSize: screenheight/30,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Visibility(
                      visible: screenheight >= 250,
                      child: const SizedBox(height: 10.0)),

                  // News Description
                  Visibility(
                    visible: screenheight >= 455,
                    child: HtmlWidget(widget.newsDesc,
                        textStyle:
                            TextStyle(fontSize: screenheight/60, color: Colors.black38)),
                  ),
                  Visibility(
                      visible: screenheight >= 250,
                      child: const SizedBox(height: 10.0)),

                  // News Content
                  Visibility(
                    visible: screenheight >= 455,
                    child: HtmlWidget(
                        widget.newsContent != "--"
                            ? widget.newsContent.length > 250
                                ? "${widget.newsContent.substring(0, 250)}...."
                                : "${widget.newsContent.substring(0, widget.newsContent.length - 15)}...."
                            : widget.newsContent,
                        textStyle: TextStyle(fontSize: screenheight/45)),
                  )
                ],
              ),
            ),
            const Spacer(),

            // bottom part -> Read more, down arrow button
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
            Visibility(
              visible: screenheight >= 270,
              child: const SizedBox(
                height: 10.0,
              ),
            ),
            Visibility(
              visible: screenheight >= 310,
              child: const Center(child: Icon(Icons.keyboard_double_arrow_down_outlined, color: Colors.deepPurple))),
            const SizedBox(height: 10.0)
          ],
        ));
  }
}
