import 'package:flutter/material.dart';
import 'package:space_quizz/widgets/text_utils.dart';
import 'package:space_quizz/widgets/quizz_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Card(
              elevation: 10.0,
              child: new Container(
                height: MediaQuery.of(context).size.width * 0.7,
                width: MediaQuery.of(context).size.width * 0.7,
                child: new Image.asset('assets/quizz_cover.jpg', fit: BoxFit.cover)
              ),
            ),
            new RaisedButton(
              onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                return new QuizzPage();
              }));
            },
              padding: const EdgeInsets.all(15.0),
              color: Colors.green,
              child: new TextUtils('Demarrer le Quiz', color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}