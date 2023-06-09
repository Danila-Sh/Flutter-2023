import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const ThirdLab());
}

class ThirdLab extends StatelessWidget {
  const ThirdLab({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(100, 100, 100, 1),
          secondary: Colors.orange,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomePage(),
    ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var expression = "";
  var value = 0.0;

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, dynamic>> buttons = {
      'AC': {
        "action": () {
          value = 0.0;
          expression = "";
        },
        "color": Theme.of(context).colorScheme.secondary,
      },
      '\u232B': {
        "action": () {
          if (expression.isNotEmpty) {
            expression = expression.substring(0, expression.length - 1);
          }
        },
        "color": Theme.of(context).colorScheme.secondary,
      },
      '%': {
        "action": () {
          add("%");
        },
        "color": Theme.of(context).colorScheme.secondary,
      },
      '/': {
        "action": () {
          add("/");
        },
        "color": Theme.of(context).colorScheme.secondary,
      },
      '7': {
        "action": () {
          add("7");
        }
      },
      '8': {
        "action": () {
          add("8");
        }
      },
      '9': {
        "action": () {
          add("9");
        }
      },
      'x': {
        "action": () {
          add("*");
        },
        "color": Theme.of(context).colorScheme.secondary,
      },
      '4': {
        "action": () {
          add("4");
        }
      },
      '5': {
        "action": () {
          add("5");
        }
      },
      '6': {
        "action": () {
          add("6");
        }
      },
      '—': {
        "action": () {
          add("-");
        },
        "color": Theme.of(context).colorScheme.secondary,
      },
      '1': {
        "action": () {
          add("1");
        }
      },
      '2': {
        "action": () {
          add("2");
        }
      },
      '3': {
        "action": () {
          add("3");
        }
      },
      '+': {
        "action": () {
          add("+");
        },
        "color": Theme.of(context).colorScheme.secondary,
      },
      "": {},
      '0': {
        "action": () {
          add("0");
        }
      },
      '.': {"action": () {}, "textColor": Theme.of(context).primaryColor},
      '=': {
        "action": () {
          expression = value.toString();
        },
        "color": Theme.of(context).colorScheme.secondary,
      },
    };
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.centerRight,
              child: Text(
                "$expression = ",
                style: TextStyle(
                    fontSize: 24, color: Theme.of(context).colorScheme.primary),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.centerRight,
              child: Text(
                value == value.truncateToDouble() ? value.toInt().toString() : value.toString(),
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ]),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            crossAxisCount: 4,
            children: [
              for (var button in buttons.entries)
                button.key == ""
                    ? Container()
                    : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              button.value["action"]();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: button.value["color"] ??
                                  Theme.of(context).colorScheme.primary,
                              shape: const CircleBorder(),
                              textStyle: const TextStyle(
                                fontSize: 36,
                              )),
                          child: Text(button.key),
                        ),
                    )
            ],
          ),
        ],
      ),
    );
  }

  void add(String symbol) {
    if(expression.endsWith("/") && symbol == "0")
      {
        expression = "Ошибка";
        value = 0.0;
        return;
      }
    if (int.tryParse(symbol) == null) {
      if (!expression.contains(RegExp(r'[+\-/*]$'))) {
        expression += symbol;
      }
    } else {
      expression += symbol;
      calculate();
    }
  }

  void calculate() {
    var exp = Parser().parse(expression);
    var cm = ContextModel();
    var eval = exp.evaluate(EvaluationType.REAL, cm);
    value = eval;
  }
}
