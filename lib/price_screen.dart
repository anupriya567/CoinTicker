import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'package:coin_ticker/components/coin_card.dart';

CurrencyDetail cd = CurrencyDetail();

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String dropdownvalue = 'USD';

  DropdownButton<String> AndroidDropdown() {
    List<DropdownMenuItem<String>> itemList = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      itemList.add(item);
    }

    return DropdownButton<String>(
        value: dropdownvalue,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: itemList,
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue = newValue!;
            curr = newValue;
            cd.getCurrencyData(curr);


          });
        });
  }

  CupertinoPicker IosPicker() {
    List<Text> itemList = [];
    for (String currency in currenciesList) {
      itemList.add(Text(currency));
    }

    return CupertinoPicker(
        itemExtent: 30.00,
        onSelectedItemChanged: (selectedItem) {},
        children: itemList);
  }

  String curr = "USD";
  String cost1 = "?";
  String cost2 = "?";
  String cost3 = "?";

  void getData(String curr) async{
    Map<String,String>CryptoValues = await cd.getCurrencyData(curr);
    if(CryptoValues != null)
      UpdateUI(CryptoValues);
  }
  void UpdateUI(dynamic CrytoValues) {
    try {

      setState(() {
        cost1 = CrytoValues['BTC'];
        cost2 = CrytoValues['ETH'];
        cost3 = CrytoValues['LTC'];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData("USD");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: [
              CoinCard(crypto: "BTC",cost: cost1, curr: curr),
              CoinCard(crypto: "ETH",cost: cost2, curr: curr),
              CoinCard(crypto: "LTC",cost: cost3, curr: curr),
            ],
          ),

    Container(
    height: 150.0,
    alignment: Alignment.center,
    padding: EdgeInsets.only(bottom: 30.0),
    color: Colors.lightBlue,
    child: Platform.isAndroid ? AndroidDropdown() : IosPicker(),
    )
        ],
      ),
    );
  }
}


