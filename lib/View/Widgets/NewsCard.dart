import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsaty/Model/DataModels/NewsByCategory.dart';
import 'package:newsaty/View/Pages/NewsDetails.dart';

class NewsCard extends StatelessWidget {
  final Article article;

  NewsCard(this.article);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewsDetails(article)));
      },
      child: Container(
        height: 150,
        child: Card(
          color: Colors.white,
          elevation: 10.0,
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: (article.urlToImage!= null )?Image.network(
                    article.urlToImage,
                    fit: BoxFit.fill,
                    height: 150,
                  ): Center(child: Icon(Icons.info)),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(right: 8.0, top: 5.0, left: 8.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          article.title,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.oswald(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              article.source.name,
                              textDirection: TextDirection.rtl,
                              style: GoogleFonts.oswald(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0),
                              ),
                            ),
                            Text(
                              article.publishedAt.day.toString() +
                                  "/" +
                                  article.publishedAt.month.toString() +
                                  "/" +
                                  article.publishedAt.year.toString(),
                              textDirection: TextDirection.rtl,
                              style: GoogleFonts.oswald(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 10.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
