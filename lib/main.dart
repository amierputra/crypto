// ignore_for_file: prefer_const_constructors

import 'package:crypto/widget/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:crypto/services/api_client.dart';
import 'dart:core';

// ignore: prefer_const_constructors
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiClient client = ApiClient();

  Color mainColor = Colors.amber;
  Color secondColor = Colors.red;
  List<String> crypto = [];
  String from = "";
  String to = "";

  late double rate = 0.0;
  String result = "";

  @override
  void initState() {
    super.initState();
    (() async {
      List<String> list = await client.getExchangeRates();
      setState(() {
        crypto = list;
      });
    })();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                width: 200,
                child: const Text(
                  "Bitcoin Converter",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Input value to convert",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0,
                            color: secondColor,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customDropDown(crypto, from, (val) {
                            setState(() {
                              from = val;
                            });
                          }),
                          FloatingActionButton(
                            onPressed: () {
                              String temp = from;
                              setState(() {
                                from = to;
                                to = temp;
                              });
                            },
                            child: const Icon(Icons.swap_horiz),
                            elevation: 0.0,
                            backgroundColor: secondColor,
                          ),
                          customDropDown(crypto, to, (val) {
                            setState(() {
                              to = val;
                            });
                          }),
                        ],
                      ),
                      SizedBox(height: 50.0),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Result",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              result,
                              style: TextStyle(
                                color: secondColor,
                                fontSize: 36.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
