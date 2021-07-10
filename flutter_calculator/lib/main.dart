import 'package:flutter/material.dart';
import 'package:flutter_calculator/src/contrants.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String equal = "0";
  String result = "0";
  String expression = "";
  double equaltionFontSize = 38.0;
  double resultFontSize = 48.0;

  kFontSize() {
    equaltionFontSize = 38.0;
    resultFontSize = 48.0;
  }

  ButtonPressed(String text) {
    setState(() {
      if (text == 'C') {
        equal = "0";
        result = "0";
        kFontSize();
      } else if (text == '=') {
        expression = equal;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '/100');
        expression = expression.replaceAll('Sqrt', 'sqrt');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cn = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cn)}';
        } on Exception catch (e) {
          result = 'Error';
        }
        kFontSize();
      } else if (text == '%') {
        equal = equal + '%';
        kFontSize();
      } else if (text == '-/+') {
        equal = '1/' + equal;
        kFontSize();
      } else if (text == 'x!') {
        equal = equal + '!';
      } else {
        if (equal == '0')
          equal = text;
        else
          equal = equal + text;
        kFontSize();
      }
    });
  }

  Widget ButtonBuild(String text, double height, TextStyle Tstyle,
      Color ButtonColor, bool corner) {
    return Container(
      height: MediaQuery.of(context).size.height * .1 * height,
      child: FlatButton(
        color: ButtonColor,
        shape: (corner == false)
            ? null
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.0),
                side: BorderSide(
                    color: ButtonBox, width: 1, style: BorderStyle.solid),
              ),
        onPressed: () => ButtonPressed(text),
        child: Text(text, style: Tstyle),
      ),
    );
  }

  // Widget CalculatorButtonBuild(
  //     String text, double height, TextStyle Tstyle, Color ButtonColor) {
  //   return Container(
  //     height: MediaQuery.of(context).size.height * .1 * height,
  //     child: FlatButton(
  //       color: ButtonColor,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(9.0),
  //         side:
  //             BorderSide(color: ButtonBox, width: 1, style: BorderStyle.solid),
  //       ),
  //       onPressed: () => ,
  //       child: Text(text, style: Tstyle),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            //color: CalculatorBox,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: CalculatorBox,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Spacer(),
                    Container(
                      child: Text(
                        '$equal',
                        style: PadStyleCalculator,
                      ),
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.all(10),
                      //color: CalculatorBox,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: CalculatorBox,
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.backspace,
                          color: Equal,
                        ),
                        onPressed: () {
                          setState(() {
                            equal = equal.substring(0, equal.length - 1);
                            if (equal.length == 0) equal = "0";
                          });
                        })
                  ],
                ),
                Container(
                  child: Text(
                    '$result',
                    style: PadStyle,
                  ),
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.all(15),
                  //color: CalculatorBox,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: Calculator,
                  ),
                ),
                Expanded(
                    child: Divider(
                  color: Colors.transparent,
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                      width: MediaQuery.of(context).size.width * .60,
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              ButtonBuild(
                                  'Sqrt', 1, buttonStyle, CalculatorBox, false),
                              ButtonBuild(
                                  '-/+', 1, buttonStyle, CalculatorBox, false),
                              ButtonBuild(
                                  '%', 1, buttonStyle, CalculatorBox, false),
                            ],
                          ),
                          TableRow(
                            children: [
                              ButtonBuild('7', 1, buttonStyleNumber,
                                  CalculatorBox, false),
                              ButtonBuild('8', 1, buttonStyleNumber,
                                  CalculatorBox, false),
                              ButtonBuild('9', 1, buttonStyleNumber,
                                  CalculatorBox, false),
                            ],
                          ),
                          TableRow(
                            children: [
                              ButtonBuild('4', 1, buttonStyleNumber,
                                  CalculatorBox, false),
                              ButtonBuild('5', 1, buttonStyleNumber,
                                  CalculatorBox, false),
                              ButtonBuild('6', 1, buttonStyleNumber,
                                  CalculatorBox, false),
                            ],
                          ),
                          TableRow(
                            children: [
                              ButtonBuild('1', 1, buttonStyleNumber,
                                  CalculatorBox, false),
                              ButtonBuild('2', 1, buttonStyleNumber,
                                  CalculatorBox, false),
                              ButtonBuild('3', 1, buttonStyleNumber,
                                  CalculatorBox, false),
                            ],
                          ),
                          TableRow(
                            children: [
                              ButtonBuild(
                                  'C', 1, buttonStyleNumber, Calculator, true),
                              ButtonBuild('0', 1, buttonStyleNumber,
                                  CalculatorBox, false),
                              ButtonBuild('.', 1, buttonStyleNumber,
                                  CalculatorBox, false),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 12.0, 0, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Calculator,
                      ),
                      width: MediaQuery.of(context).size.width * .34,
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              ButtonBuild(
                                  '÷', 1, buttonStyleNumber, Calculator, false),
                            ],
                          ),
                          TableRow(
                            children: [
                              ButtonBuild(
                                  'x', 1, buttonStyleNumber, Calculator, false),
                            ],
                          ),
                          TableRow(
                            children: [
                              ButtonBuild(
                                  '-', 1, buttonStyleNumber, Calculator, false),
                            ],
                          ),
                          TableRow(
                            children: [
                              ButtonBuild(
                                  '+', 1, buttonStyleNumber, Calculator, false),
                            ],
                          ),
                          TableRow(
                            children: [
                              ButtonBuild('=', 1, EqualStyle, Equal, true),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
