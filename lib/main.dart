// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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
  TextEditingController textEditingController = TextEditingController();

  Color mainColor = Colors.amber;
  Color secondColor = Colors.red;

  String name = "", unit = "", desc="";
  double value = 0.0;
  var type, base, equal;

  String selectCoin = "Bitcoin";
  List<String> coinList = [
    "Bitcoin",
    "Ether",
    "Litecoin",
    "Bitcoin Cash",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondColor,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 400.0,
                    width: 1000,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: mainColor,
                    ),
                    child: Column(children: [
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Bitcoin Exchange Rate",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 20.0,
                              ),
                              TextField(
                                controller: textEditingController,
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
                              DropdownButton(
                                itemHeight: 60,
                                value: selectCoin,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectCoin = newValue.toString();
                                  });
                                },
                                items: coinList.map((selectCoin) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      selectCoin,
                                    ),
                                    value: selectCoin,
                                  );
                                }).toList(),
                              ),
                              ElevatedButton(
                                  onPressed: _loadExchange,
                                  child: const Text("Load Result")),
                              Text(
                                desc,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ))));
  }

  _loadExchange() async {
    var url = Uri.parse('https://api.coingecko.com/api/v3/exchange_rates');
    var response = await http.get(url);
    var rescode = response.statusCode;
    var cointype;

    if (selectCoin == "Bitcoin") {
      cointype = "btc";
    } else if (selectCoin == "Ether") {
      cointype = "eth";
    } else if (selectCoin == "Litecoin") {
      cointype = "ltc";
    }

    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        unit = parsedJson['rates']['$cointype']['unit'];
        value = parsedJson['rates']['$cointype']['value'];
        type = parsedJson['rates']['$cointype']['type'];

        base = double.parse(textEditingController.text);
        equal = base*value;
        desc = "$unit $equal";
        
      });
    } else {
      throw Exception("Failed to connect to API");
    }
  }
}
