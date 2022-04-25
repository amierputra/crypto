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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Text('BITCOIN CRYPTOCURRENCY',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        body: HomePage(),
      ),
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

  Color mainColor = Colors.black87;
  Color secondColor = Colors.greenAccent;

  String name = "", unit = "", desc = "";
  double value = 0.0;
  var type, base, equal;

  String selectCoin = "Bitcoin";
  List<String> coinList = [
    "Bitcoin",
    "Ether",
    "Litecoin",
    "Bitcoin Cash",
    "Binance Coin",
    "EOS",
    "XRP",
    "Lumens",
    "Chainlink",
    "Polkadot",
    "Yearn.finance",
    "US Dollar",
    "United Arab Emirates Dirham",
    "Argentine Peso",
    "Australian Dollar",
    "Bangladeshi Taka",
    "Bahraini Dinar",
    "Bermudian Dollar",
    "Brazil Real",
    "Canadian Dollar",
    "Swiss Franc",
    "Chilean Peso",
    "Chinese Yuan",
    "Czech Koruna",
    "Danish Krone",
    "Euro",
    "British Pound Sterling",
    "Hong Kong Dollar",
    "Hungarian Forint",
    "Indonesian Rupiah",
    "Israeli New Shekel",
    "Indian Rupee",
    "Japanese Yen",
    "South Korean Won",
    "Kuwaiti Dinar",
    "Sri Lankan Rupee",
    "Burmese Kyat",
    "Mexican Peso",
    "Malaysian Ringgit",
    "Nigerian Naira",
    "Norwegian Krone",
    "New Zealand Dollar",
    "Philippine Peso",
    "Pakistani Rupee",
    "Polish Zloty",
    "Russian Ruble",
    "Saudi Riyal",
    "Swedish Krona",
    "Singapore Dollar",
    "Thai Baht",
    "Turkish Lira",
    "New Taiwan Dollar",
    "Ukrainian hryvnia",
    "Venezuelan bolívar fuerte",
    "Vietnamese đồng",
    "South African Rand",
    "IMF Special Drawing Rights",
    "Silver - Troy Ounce",
    "Gold - Troy Ounce",
    "Bits",
    "Satoshi",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        body: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        height: 400.0,
                        width: 1000,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: secondColor,
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
                                        color: mainColor,
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
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        value: selectCoin,
                                      );
                                    }).toList(),
                                  ),
                                  ElevatedButton(
                                      onPressed: _loadExchange,
                                      child: const Text("Load Result")),
                                  SizedBox(height: 30.0),
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
                                          desc,
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
                        ]),
                      ),
                    )))));
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
    } else if (selectCoin == "Bitcoin Cash") {
      cointype = "bch";
    }else if (selectCoin == "Binance Coin") {
      cointype = "bnb";
    }else if (selectCoin == "EOS") {
      cointype = "eos";
    }else if (selectCoin == "XRP") {
      cointype = "xrp";
    }else if (selectCoin == "Lumens") {
      cointype = "xlm";
    }else if (selectCoin == "Chainlink") {
      cointype = "link";
    }else if (selectCoin == "Polkadot") {
      cointype = "dot";
    }else if (selectCoin == "Yearn.finance") {
      cointype = "yfi";
    }else if (selectCoin == "US Dollar") {
      cointype = "usd";
    }else if (selectCoin == "United Arab Emirates Dirham") {
      cointype = "aed";
    }else if (selectCoin == "Argentine Peso") {
      cointype = "ars";
    }else if (selectCoin == "Australian Dollar") {
      cointype = "aud";
    }else if (selectCoin == "Bangladeshi Taka") {
      cointype = "bdt";
    }else if (selectCoin == "Bahraini Dinar") {
      cointype = "bhd";
    }else if (selectCoin == "Bermudian Dollar") {
      cointype = "bmd";
    }else if (selectCoin == "Brazil Real") {
      cointype = "brl";
    }else if (selectCoin == "Canadian Dollar") {
      cointype = "cad";
    }else if (selectCoin == "Swiss Franc") {
      cointype = "chf";
    }else if (selectCoin == "Chilean Peso") {
      cointype = "clp";
    }else if (selectCoin == "Chinese Yuan") {
      cointype = "cny";
    }else if (selectCoin == "Czech Koruna") {
      cointype = "czk";
    }else if (selectCoin == "Danish Krone") {
      cointype = "dkk";
    }else if (selectCoin == "Euro") {
      cointype = "eur";
    }else if (selectCoin == "British Pound Sterling") {
      cointype = "gbp";
    }else if (selectCoin == "Hong Kong Dollar") {
      cointype = "hkd";
    }else if (selectCoin == "Hungarian Forint") {
      cointype = "huf";
    }else if (selectCoin == "Indonesian Rupiah") {
      cointype = "idr";
    }else if (selectCoin == "Israeli New Shekel") {
      cointype = "ils";
    }else if (selectCoin == "Indian Rupee") {
      cointype = "inr";
    }else if (selectCoin == "Japanese Yen") {
      cointype = "jpy";
    }else if (selectCoin == "South Korean Won") {
      cointype = "krw";
    }else if (selectCoin == "Kuwaiti Dinar") {
      cointype = "kwd";
    }else if (selectCoin == "Sri Lankan Rupee") {
      cointype = "lkr";
    }else if (selectCoin == "Burmese Kyat") {
      cointype = "mmk";
    }else if (selectCoin == "Mexican Peso") {
      cointype = "mxn";
    }else if (selectCoin == "Malaysian Ringgit") {
      cointype = "myr";
    }else if (selectCoin == "Nigerian Naira") {
      cointype = "ngn";
    }else if (selectCoin == "Norwegian Krone") {
      cointype = "nok";
    }else if (selectCoin == "New Zealand Dollar") {
      cointype = "nzd";
    }else if (selectCoin == "Philippine Peso") {
      cointype = "php";
    }else if (selectCoin == "Pakistani Rupee") {
      cointype = "pkr";
    }else if (selectCoin == "Polish Zloty") {
      cointype = "pln";
    }else if (selectCoin == "Russian Ruble") {
      cointype = "rub";
    }else if (selectCoin == "Saudi Riyal") {
      cointype = "sar";
    }else if (selectCoin == "Swedish Krona") {
      cointype = "sek";
    }else if (selectCoin == "Singapore Dollar") {
      cointype = "sgd";
    }else if (selectCoin == "Thai Baht") {
      cointype = "thb";
    }else if (selectCoin == "Turkish Lira") {
      cointype = "try";
    }else if (selectCoin == "New Taiwan Dollar") {
      cointype = "twd";
    }else if (selectCoin == "Ukrainian hryvnia") {
      cointype = "uah";
    }else if (selectCoin == "Venezuelan bolívar fuerte") {
      cointype = "vef";
    }else if (selectCoin == "Vietnamese đồng") {
      cointype = "vnd";
    }else if (selectCoin == "South African Rand") {
      cointype = "zar";
    }else if (selectCoin == "IMF Special Drawing Rights") {
      cointype = "xdr";
    }else if (selectCoin == "Silver - Troy Ounce") {
      cointype = "xag";
    }else if (selectCoin == "Gold - Troy Ounce") {
      cointype = "xau";
    }else if (selectCoin == "Bits") {
      cointype = "bits";
    }else if (selectCoin == "Satoshi") {
      cointype = "sats";
    }

    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        unit = parsedJson['rates']['$cointype']['unit'];
        value = parsedJson['rates']['$cointype']['value'];
        type = parsedJson['rates']['$cointype']['type'];

        base = double.parse(textEditingController.text);
        equal = (base * value).toStringAsFixed(2);
        desc = "$unit $equal";
      });
    } else {
      throw Exception("Failed to connect to API");
    }
  }
}
