import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsaty/Model/DataModels/NewsByCategory.dart';
import 'package:newsaty/View/Widgets/CustomAppBar.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatelessWidget {
  final Article article;

  NewsDetails(this.article);

  final titleStyle = GoogleFonts.oswald(
    textStyle: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17.0),
  );
  final contentStyle = GoogleFonts.oswald(
    textStyle: TextStyle(
        color: Colors.black, fontWeight: FontWeight.normal, fontSize: 15.0),
  );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar('Details', false),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  article.title,
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      article.urlToImage,
                      fit: BoxFit.fill,
                      height: 250,
                      width: size.width * 0.90,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Sources',
                  style: titleStyle,
                  textAlign: TextAlign.left,
                ),
                Divider(
                  color: Colors.black38,
                ),
                Text(
                  (article.author == null || article.author.isEmpty)
                      ? 'There is no Author'
                      : article.author,
                  style: contentStyle,
                  textAlign: TextAlign.left,
                ),
                Text(
                  (article.source == null || article.source.name.isEmpty)
                      ? 'There is no Author'
                      : article.source.name,
                  style: contentStyle,
                  textAlign: TextAlign.left,
                ),
                Text(
                    article.publishedAt.day.toString() +
                        "/" +
                        article.publishedAt.month.toString() +
                        "/" +
                        article.publishedAt.year.toString(),
                    textDirection: TextDirection.rtl,
                    style: contentStyle),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Description',
                  style: titleStyle,
                  textAlign: TextAlign.left,
                ),
                Divider(
                  color: Colors.black38,
                ),
                Text(
                  (article.description == null || article.description.isEmpty)
                      ? 'There is no Description'
                      : article.description,
                  style: contentStyle,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Content',
                  style: titleStyle,
                  textAlign: TextAlign.left,
                ),
                Divider(
                  color: Colors.black38,
                ),
                Text(
                  (article.content == null || article.content.isEmpty)
                      ? 'There is no Content'
                      : article.content,
                  style: contentStyle,
                  textAlign: TextAlign.left,
                ),
                FlatButton(
                  onPressed: () {
                    _launchURL(article.url);
                  },
                  child: Text(
                    'Contiue Reading ...',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                          color: Colors.blue[300],
                          fontWeight: FontWeight.normal,
                          fontSize: 15.0),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchURL(url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
