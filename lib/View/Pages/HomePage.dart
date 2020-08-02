import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsaty/Model/DataModels/NewsByCategory.dart';
import 'package:newsaty/View/Widgets/CustomAppBar.dart';
import 'package:newsaty/View/Widgets/NewsCard.dart';
import 'package:newsaty/ViewModel/NewsProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NewsProvider>(context, listen: false)
          .getHeadlinesByCategory('general');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Column(),
      ),
      appBar: CustomAppBar('Feeds', true),
      body: SafeArea(
        child: Consumer<NewsProvider>(
          builder: (context, model, child) {
            switch (model.newsByCategoryStatus) {
              case Status.Busy:
                return Container(
                    child: Center(child: CircularProgressIndicator()));
              case Status.Error:
                return Center(child: Text(model.newsByCategoryMessage));
              case Status.Success:
                if (model.newsByCategory.status == "ok")
                  return _successPart(model.newsByCategory);
                else
                  return Center(child: Text(model.newsByCategoryMessage));
                break;
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _successPart(NewsByCategory newsByCategory) {
    if (newsByCategory.articles.length == 0) {
      return Expanded(
          flex: 1,
          child: Center(
            child: Text(
              'There are no News',
              style: GoogleFonts.oswald(
                textStyle: TextStyle(
                    color: Colors.green[300],
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
          ));
    }
    return ListView.builder(
      itemBuilder: (context, i) {
        return NewsCard(newsByCategory.articles[i]);
      },
      itemCount: newsByCategory.articles.length,
    );
  }
}

/*Container(
                height: 60,
                color: Colors.white10,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Provider.of<NewsProvider>(context, listen: false)
                            .getHeadlinesByCategory(Provider.of<NewsProvider>(
                                    context,
                                    listen: false)
                                .categories[i]
                                .name);
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: 150,
                        decoration: BoxDecoration(
                            color: Provider.of<NewsProvider>(context,
                                    listen: false)
                                .categories[i]
                                .color,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Center(
                          child: Text(
                            Provider.of<NewsProvider>(context, listen: false)
                                .categories[i]
                                .name,
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: Provider.of<NewsProvider>(context, listen: false)
                      .categories
                      .length,
                ),
              ),*/
