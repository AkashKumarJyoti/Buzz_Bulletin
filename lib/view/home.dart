import 'package:buzz_bulletin/view/widget/NewsContainer.dart';
import 'package:flutter/material.dart';
import '../controller/fetchNews.dart';
import '../model/newsArt.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isloading = true;
  late NewsArt newsArt;
  GetNews() async {
    newsArt = await FetchNews.fetchNews();
    setState(() {
      isloading = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetNews();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        onPageChanged: (value)
        {
          setState(() {
            isloading = true;
          });
          GetNews();
        },
        itemBuilder: (context, index)
        {
          return isloading ? const Center(child: SizedBox(height: 50, width: 50, child: CircularProgressIndicator())) : NewsContainer(
            imgUrl: newsArt.imgUrl,
            newsContent: newsArt.newsContent,
            newsHead: newsArt.newsHead,
            newsDesc: newsArt.newsDesc,
            newsUrl: newsArt.newsUrl,
            time: newsArt.time
          );
        }),
    );
  }
}
