import 'package:flutter/material.dart';
import 'package:space_quizz/widgets/text_utils.dart';
import 'package:space_quizz/models/question.dart';
import 'dart:async';

class QuizzPage extends StatefulWidget {
  @override
  _QuizzPageState createState() => new _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {

  Question question;

  List<Question> listQuestion = [
    new Question('La Terre est une étoile ?', false, ' La seule étoile du Système solaire est le Soleil', 'lune.jpg'),
    new Question('Une planète n\'émet pas de lumière. ?', true, 'Seules les étoiles émettent de la lumière. Les planètes n\'émettent pas de lumière, mais elles la reflètent.', 'lune.jpg'),
    new Question('La planète la plus proche de la Terre est Mars ?', false, 'C\'est Vénus la planète la plus proche de la Terre !', 'lune.jpg'),
    new Question('La lune est une planéte ?', false, 'Une planète est un corps céleste qui tourne autour d\'une étoile.', 'lune.jpg'),
    new Question('La Terre tourne autour du Soleil en 24 heures ?', false, 'Elle tourne autour du Soleil en 365 jours environ', 'lune.jpg'),
    new Question('Il existe des éclipses de Lune ?', true, 'Un éclipse lunaire est un phénomène qui arrive lorsque la Terre s\'interpose entre la Lune et le Soleil', 'lune.jpg'),
    new Question('C\'est le Soleil qui est responsable des aurores boréales ?', true, 'Provoquées par l\'interaction entre les particules chargées du vent solaire et la haute atmosphère', 'lune.jpg'),
    new Question('La température dans l\'espace est de 0°C ?', false, 'La température varie selon l\'endroit et à quel point celui-ci est exposé aux rayonnements du Soleil', 'lune.jpg'),
    new Question('Il n\'y a pas de glace dans l\'espace ?', false, 'Les comètes, par exemple, sont des objets constitués de glace et de poussière', 'lune.jpg'),
    new Question('C\'est durant l\'hiver (dans l\'hémisphère nord) que la Terre est la plus rapprochée du Soleil ?', true, 'La Terre tourne bien autour du Soleil selon une ellipse.', 'lune.jpg'),
  ];

  int index = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    question = listQuestion[index];
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.5;
    return new Scaffold(
      appBar: new AppBar(
        title: new TextUtils('Quizz | Partie', color: Colors.white),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new TextUtils('Question #${index + 1}', color:  Colors.grey[900]),
            new TextUtils('Score : $score / ${index + 1}', color: Colors.grey[900]),
            new Card(
              elevation: 10.0,
              child: new Container(
                height: size,
                width: size,
                child: new Image.asset('assets/' + question.imagePath, fit: BoxFit.cover),
              ),
            ),
            new TextUtils(question.question, color: Colors.grey[900], textScaleFactor: 1.5),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                boutonBool(true),
                boutonBool(false),
              ],
            )
          ],
        )
      ),
    );
  }

  RaisedButton boutonBool(bool b) {
    return new RaisedButton(
      elevation: 10.0,
      onPressed: (() => dialog(b)),
      color: Colors.green,
      child: TextUtils(b ? "Vrai" : "Faux", color: Colors.white),
      );
  }

  Future<Null> dialog(bool b) async {
    bool bonneResponse = (b == question.response);
    String vrai = "assets/true.png";
    String faux = "assets/false.png";
    if (bonneResponse) { score++; }
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new TextUtils(bonneResponse ? "Bravo !" : "Dommage...", textScaleFactor: 1.5, color: bonneResponse ? Colors.green : Colors.redAccent),
          contentPadding: EdgeInsets.all(18.0),
          children: <Widget>[
            new Image.asset(bonneResponse ? vrai : faux, fit: BoxFit.cover),
            new Container(height: 20.0),
            new TextUtils(question.explication, textScaleFactor: 1.1, color: Colors.grey[900]),
            new Container(height: 20.0),
            new RaisedButton(
              onPressed: () {
                Navigator.pop(context);
                getNextQuestion();
              },
              color: Colors.green,
              child: new TextUtils("Question Suivante", color: Colors.white, textScaleFactor: 1.2),
              ),
          ],
        );
      }
    );
  }

  Future<Null> alerte() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: new TextUtils('Fin du Quizz!', color: Colors.deepPurpleAccent, textScaleFactor: 1.2),
          contentPadding: EdgeInsets.all(10.0),
          content: new TextUtils("Votre score: $score/${index + 1}", color: Colors.grey[900]),
          actions: <Widget>[
            new FlatButton(
              onPressed: (() {
                Navigator.pop(buildContext);
                Navigator.pop(context);
              }),
              child: new TextUtils("Terminer", textScaleFactor: 1.4, color: Colors.deepPurpleAccent)
              ),
          ],
        );
      });
  }

  void getNextQuestion() {
    if (index < listQuestion.length - 1) {
      index++;
      setState(() {
        question = listQuestion[index];
      });
    } else {
      alerte();
    }
  }
}