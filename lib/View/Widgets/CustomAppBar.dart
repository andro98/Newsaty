import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsaty/View/Pages/ProfilePage.dart';
import 'package:newsaty/ViewModel/AuthProvider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isHome;

  CustomAppBar(this.title, this.isHome);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      leading: (isHome)
          ? IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu),
            )
          : null,
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
          },
          child: ClipOval(
            child: FadeInImage(
              image: NetworkImage(
                  Provider.of<AuthProvider>(context, listen: false)
                      .user
                      .photoUrl),
              placeholder: NetworkImage(
                'https://previews.123rf.com/images/alexis84/alexis841202/alexis84120200023/12364849-planet-earth-and-human-eye.jpg',
              ),
              height: 40.0,
              width: 40.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 1.0,
      title: Text(
        title,
        style: GoogleFonts.oswald(
          textStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}
