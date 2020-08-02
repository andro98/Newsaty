import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsaty/ViewModel/AuthProvider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                ClipOval(
                  child: Image.network(
                    Provider.of<AuthProvider>(context, listen: false).user.photoUrl,
                    height: 200.0,
                    width: 200.0,
                    fit: BoxFit.fill,
                  ),
                ),
                Text(
                  Provider.of<AuthProvider>(context, listen: false).user.name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
