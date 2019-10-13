import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/animation.dart';
import 'dart:ui';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}


class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator>
    with TickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  String equation = "";
  String result = "";
  String expression = "";
  String delete = "CE";
  double equationFontSize = 42.0;
  double resultFontSize = 34.0;
  String operation = "";
  double expressionDouble=0.0;
  FontWeight resultFontWeight = FontWeight.w300;
  
  

  var _alignmentRe = Alignment.centerRight;
  var _aligmentEq = Alignment.centerRight;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "";
        result = "";
        delete = "CE";
      } else if (buttonText == "CE") {
        equation = equation.substring(0, equation.length - 1);
        result = "";
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        delete = "C";
        equation = result;
        result = "";
      } else if((buttonText == "(" )||(buttonText == ")")) {
        equation = equation + buttonText;
    } else if (((buttonText.endsWith('+')) ||
              (buttonText.endsWith('-')) ||
              (buttonText.endsWith('×')) ||
              (buttonText.endsWith('÷')) ||
              (buttonText.endsWith('.'))) &&
          ((equation.endsWith('+')) ||
              (equation.endsWith('-')) ||
              (equation.endsWith('×')) ||
              (equation.endsWith('÷')) ||
              (equation.endsWith('.')))) {
        equation = equation.substring(0, equation.length - 1);
        equation += buttonText;
      } else {
        delete = "CE";
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
          expression = equation;
          expressionDouble = double.parse(equation);


          expression = expression.replaceAll('×', '*');
          expression = expression.replaceAll('÷', '/');
          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);

            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          } catch (e) {}
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeigth, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.14 * buttonHeigth,
      color: buttonColor,
      child: FlatButton(
          // backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(color: buttonColor, style: BorderStyle.none)),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  endDrawer: AnimatedContainer(
      //    duration: Duration(seconds: 2),
      //    curve: Curves.linear,
      //    height: MediaQuery.of(context).size.height * .12,
      //    width: MediaQuery.of(context).size.width * .80,
      //    child: Table(
      //               children: [
      //                 TableRow(children: [
      //                   buildButton("sin", 1, Colors.teal[400]),
      //                   buildButton("cos", 1, Colors.teal[400]),
      //                   buildButton("tan", 1, Colors.teal[400]),
      //                 ]),
      //                 TableRow(children: [
      //                   buildButton("log", 1, Colors.teal[400]),
      //                   buildButton("sqrt", 1, Colors.teal[400]),
      //                   buildButton("%", 1, Colors.teal[400]),
      //                 ]),
      //                 TableRow(children: [
      //                   buildButton("π", 1, Colors.teal[400]),
      //                   buildButton("e", 1, Colors.teal[400]),
      //                   buildButton("^", 1, Colors.teal[400]),
      //                 ]),
      //                 TableRow(children: [
      //                   buildButton("(", 1, Colors.teal[400]),
      //                   buildButton(")", 1, Colors.teal[400]),
      //                   buildButton("√", 1, Colors.teal[400]),
      //                 ]),
      //               ],
      //             ),
      //  ),
        backgroundColor: Colors.blueAccent,
        body: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.22,
              padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
              color: Colors.white,
              alignment: _aligmentEq,
              child: Text(
                equation,
                style: TextStyle(
                    fontSize: equationFontSize, color: Colors.black54),
              ),
            ),
            Container(
              alignment: _alignmentRe,
              height: MediaQuery.of(context).size.height * 0.22,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              color: Colors.white,
              child: Text(
                result,
                style: TextStyle(
                    fontSize: resultFontSize,
                    fontWeight: resultFontWeight,
                    color: Colors.black54),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton("7", 1, Colors.blueGrey[800]),
                        buildButton("8", 1, Colors.blueGrey[800]),
                        buildButton("9", 1, Colors.blueGrey[800]),
                      ]),
                      TableRow(children: [
                        buildButton("4", 1, Colors.blueGrey[800]),
                        buildButton("5", 1, Colors.blueGrey[800]),
                        buildButton("6", 1, Colors.blueGrey[800]),
                      ]),
                      TableRow(children: [
                        buildButton("1", 1, Colors.blueGrey[800]),
                        buildButton("2", 1, Colors.blueGrey[800]),
                        buildButton("3", 1, Colors.blueGrey[800]),
                      ]),
                      TableRow(children: [
                        buildButton(".", 1, Colors.blueGrey[800]),
                        buildButton("0", 1, Colors.blueGrey[800]),
                        buildButton("=", 1, Colors.blueGrey[800]),
                      ]),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        GestureDetector(
                          onLongPress: () {
                            setState(() {
                              equation = "";
                              result = "";
                              delete = "CE";
                            });
                          },
                          child: buildButton(delete, 0.8, Colors.blueGrey[600]),
                        ),
                      ]),
                      TableRow(children: [
                        buildButton("÷", 0.8, Colors.blueGrey[600]),
                      ]),
                      TableRow(children: [
                        buildButton("×", 0.8, Colors.blueGrey[600]),
                      ]),
                      TableRow(children: [
                        buildButton("-", 0.8, Colors.blueGrey[600]),
                      ]),
                      TableRow(children: [
                        buildButton("+", 0.8, Colors.blueGrey[600]),
                      ]),
                    ],
                  ),
                ),
                //  Container(
                //   width: MediaQuery.of(context).size.width * 0.05,
                //    color: Colors.teal[400],
                // ),
              ],
            ),
          ],
        ));
  }
}
