import 'package:flutter/material.dart';

void main() => runApp(const FirstLab());

class FirstLab extends StatefulWidget {
  const FirstLab({Key? key}) : super(key: key);

  @override
  State<FirstLab> createState() => _FirstLabState();
}

class _FirstLabState extends State<FirstLab> {
  var _text = "";
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(44.4, 8.0, 44.4, 8.0),
                  child: TextField(
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                    controller: _controller,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_text, style: const TextStyle(fontSize: 24)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () => setState(() {
                        _text = _controller.text;
                      }),
                      child: const Text(
                        "Отобразить",
                        style: TextStyle(fontSize: 24),
                      )),
                )
              ],
            ),
          )),
    );
  }
}
