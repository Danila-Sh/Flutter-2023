import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const SecondLab());

class SecondLab extends StatefulWidget {
  const SecondLab({Key? key}) : super(key: key);

  @override
  State<SecondLab> createState() => _SecondLabState();

  Map<String, double>? prepareCoefficients(String a, String b, String c) {
    if (a.isEmpty || b.isEmpty || c.isEmpty) return null;
    var aCoef = double.tryParse(a);
    var bCoef = double.tryParse(b);
    var cCoef = double.tryParse(c);
    if (aCoef == null || bCoef == null || cCoef == null) return null;
    return {"a": aCoef, "b": bCoef, "c": cCoef};
  }

  String calculate(Map<String, double> coefs) {
    double x1, x2;
    var a = coefs["a"]!;
    var b = coefs["b"]!;
    var c = coefs["c"]!;

    /*
    1 2 3 = не имеет действ
    1 2 -3 = 1 и -3
    TODO: 1 -4 4 = х1=х2=2
    1 0 -4 = 2 и -2
    TODO: 0 1 2 = линейное -2
    0 0 4 = не имеет действ
    0 0 0 = любые х
    */

    if (a == 0) {
      if (b == 0) {
        if (c == 0) {
          return "Уравнение верно при любых значениях x.";
        }
        return "Уравнение не имеет корней среди действительных чисел.";
      }
      x2 = -c / b;
      return "Решение данного квадратного уравнения:\nx = $x2";
    }
    if (b == 0 && (-1 * c * a) < 0) {
      return "Уравнение не имеет корней среди действительных чисел.";
    }
    if (b == 0 && (-1 * c * a) > 0) {
      x1 = sqrt(-c / a);
      x2 = -sqrt(-c / a);
      return "Решение данного квадратного уравнения:\nx1 = $x1\nx2 = $x2";
    }
    if (b != 0 && c == 0) {
      return "Решение данного квадратного уравнения:\nx1 = 0.0\nx2 = 0.0";
    }

    var D = b * b - 4 * a * c;
    if (D < 0) {
      return "Уравнение не имеет корней среди действительных чисел.";
    }
    if (D == 0) {
      x1 = -b / (2 * a);
      return "Решение данного квадратного уравнения:\nx1 = x2 = $x1";
    }
    x1 = (-b + sqrt(D)) / (2 * a);
    x2 = (-b - sqrt(D)) / (2 * a);
    return "Решение данного квадратного уравнения:\nx1 = $x1\nx2 = $x2";
  }
}

class _SecondLabState extends State<SecondLab> {
  final _firstController = TextEditingController();
  final _secondController = TextEditingController();
  final _thirdController = TextEditingController();
  String _text = "";

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    _thirdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Padding(
        padding: const EdgeInsets.fromLTRB(44.4, 16.0, 44.4, 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                    label: Text("Коэффициент a:"),
                    border: OutlineInputBorder()),
                controller: _firstController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                    label: Text("Коэффициент b:"),
                    border: OutlineInputBorder()),
                controller: _secondController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                    label: Text("Коэффициент c:"),
                    border: OutlineInputBorder()),
                controller: _thirdController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () {
                    var coefs = widget.prepareCoefficients(
                        _firstController.text,
                        _secondController.text,
                        _thirdController.text);
                    if (coefs == null) {
                      _text = "Коэффициенты введены неверно.";
                    } else {
                      _text = widget.calculate(coefs);
                    }
                    setState(() {});
                  },
                  child: const Text(
                    "Вычислить",
                    style: TextStyle(fontSize: 24),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_text),
            ),
          ],
        ),
      )),
    );
  }
}
