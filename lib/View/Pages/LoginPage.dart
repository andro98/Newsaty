import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsaty/View/Pages/HomePage.dart';
import 'package:newsaty/ViewModel/AuthProvider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AuthProvider>(context, listen: false).isSignedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.0,
              ),
              Image.asset(
                'assets/img/icon.png',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Newsaty',
                textAlign: TextAlign.center,
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.40,
              ),
              Consumer<AuthProvider>(
                builder: (context, model, child) {
                  switch (model.authStatus) {
                    case Status.Authenticating:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case Status.Authenticated:
                      return _authPart(context);
                    case Status.UnAuthenticated:
                    default:
                      return _unAuthPart();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _authPart(context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
    return Container();
  }

  Widget _unAuthPart() {
    return Column(
      children: [
        FlatButton(
          onPressed: () {
            Provider.of<AuthProvider>(context, listen: false).signIn();
          },
          color: Colors.white,
          child: Text(
            'Continue with Google',
            textAlign: TextAlign.center,
            style: GoogleFonts.oswald(
              textStyle: TextStyle(
                color: Colors.red[300],
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          color: Colors.white,
          child: Text(
            'Continue anonymously',
            textAlign: TextAlign.center,
            style: GoogleFonts.oswald(
              textStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
