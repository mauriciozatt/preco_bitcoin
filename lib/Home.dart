import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _Resultado = '0';

  _AtualizaPreco() async {
    String vUrl = "https://blockchain.info/ticker";

    http.Response vResponse = await http.get(Uri.parse(vUrl));

    if (vResponse.statusCode.toString() == "200") {
      Map<String, dynamic> vRetornoJson = json.decode(vResponse.body);

      setState(() {
        _Resultado = vRetornoJson["BRL"]["buy"].toString();
      });
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 200),
            child: Image.asset("img/bitcoin.png"),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child:
            Text(
              "R\$ ${_Resultado}",
              style: TextStyle(
                fontSize: 32,
                color: Colors.black,
                decoration: TextDecoration.none
              ),


            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 16),
              child: ElevatedButton.icon(
                onPressed: _AtualizaPreco,
                icon: Icon(Icons.update),
                label: Text("Atualizar Preço"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepOrangeAccent),
                ),
              ))
        ],
      ),
    );
  }
}
