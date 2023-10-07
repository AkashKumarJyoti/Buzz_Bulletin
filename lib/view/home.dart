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
  int mainVar = 0; // Handle different categories of news
  bool isloading = true;
  late String word;
  TextEditingController searchController = TextEditingController();
  late NewsArt newsArt;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  getNews(int option) async {
    switch (option) {
      case 0:
        newsArt = await FetchNews.fetchNews();
        break;
      case 1:
        newsArt = await FetchNews.search(word: word);
        break;
      case 2:
        newsArt = await FetchNews.categorySearch(category: "business");
        break;
      case 3:
        newsArt = await FetchNews.categorySearch(category: "entertainment");
        break;
      case 4:
        newsArt = await FetchNews.categorySearch(category: "general");
        break;
      case 5:
        newsArt = await FetchNews.categorySearch(category: "health");
        break;
      case 6:
        newsArt = await FetchNews.categorySearch(category: "science");
        break;
      case 7:
        newsArt = await FetchNews.categorySearch(category: "sports");
        break;
      case 8:
        newsArt = await FetchNews.categorySearch(category: "technology");
        break;
      case 9:
        newsArt = await FetchNews.headlines();
        break;
      default:
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews(0);
    searchController.text = "All News";
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                      icon: const Icon(Icons.menu)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller: searchController,
                          style: const TextStyle(
                            color: Colors.deepPurple,
                          ),
                          decoration: InputDecoration(
                            hintText: "Search",
                            prefixIcon: const Icon(Icons.search),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.deepPurple,
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.all(8),
                          ),
                          onSubmitted: (value) {
                            setState(() {
                              mainVar = 1;
                              word = searchController.text;
                              getNews(mainVar);
                            });
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: PageView.builder(
                    scrollDirection: Axis.vertical,
                    onPageChanged: (value) {
                      setState(() {
                        isloading = true;
                      });
                      getNews(mainVar);
                    },
                    itemBuilder: (context, index) {
                      return isloading
                          ? const Center(
                              child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator()))
                          : NewsContainer(
                              imgUrl: newsArt.imgUrl,
                              newsContent: newsArt.newsContent,
                              newsHead: newsArt.newsHead,
                              newsDesc: newsArt.newsDesc,
                              newsUrl: newsArt.newsUrl,
                              time: newsArt.time);
                    }),
              ),
            ],
          ),
          drawer: drawer(),
      ),
    );
  }

  Widget drawer() {
    final screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: const Color(0xFF7986CB),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(25)),
      ),
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 10),
          Center(
            child: Visibility(
              visible: screenHeight >= 100,
              child: const Text(
                "Buzz Bulletin",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Visibility(
              visible: screenHeight >= 100,
              child: const Divider(height: 2.0, color: Colors.black)),
          tiles("All News", Icons.article, 0),
          tiles("Top Headlines", Icons.view_headline, 9),
          tiles("Business", Icons.business, 2),
          tiles("Entertainment", Icons.theater_comedy, 3),
          tiles("General", Icons.info, 4),
          tiles("Health", Icons.health_and_safety, 5),
          tiles("Science", Icons.science, 6),
          tiles("Sports", Icons.sports_esports, 7),
          tiles("Technology", Icons.tablet_android_outlined, 8),
          const SizedBox(height: 20.0),
          if (screenHeight >= 100) ...[
            const Center(
              child: Text(
                "Developed by AKJ",
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget tiles(String data, IconData icon, int number) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Visibility(
      visible: screenHeight >= 100,
      child: Expanded(
        flex: 1,
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(data,
              style: const TextStyle(fontSize: 18, color: Colors.white)),
          onTap: () {
            setState(() {
              mainVar = number;
              getNews(mainVar);
              searchController.text = data;
              scaffoldKey.currentState?.closeDrawer();
            });
          },
        ),
      ),
    );
  }
}
