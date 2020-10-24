import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: BaseConverter(),
    debugShowCheckedModeBanner: false,
  ));
}

class BaseConverter extends StatefulWidget {
  @override
  _BaseConverterState createState() => _BaseConverterState();
}

class _BaseConverterState extends State<BaseConverter> {
  var dec = TextEditingController();
  var bin = TextEditingController();
  var oct = TextEditingController();
  var hex = TextEditingController();

  @override
  void dispose() {
    dec.dispose();
    bin.dispose();
    oct.dispose();
    hex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width / 1.5,
                child: new Text(
                  "Convert Numbers",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    wordSpacing: 5,
                    color: Colors.blue[500],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Container(
                height: MediaQuery.of(context).size.height / 9,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  elevation: 8,
                  child: new Container(
                    padding: EdgeInsets.all(5.0),
                    child: new TextField(
                      maxLines: 1,
                      style: TextStyle(color: Colors.blue),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        // ignore: deprecated_member_use
                        WhitelistingTextInputFormatter(
                          RegExp(
                            '[\0, \1, \2, \3, \4, \5, \6, \7, \8, \9,]',
                          ),
                        )
                      ],
                      controller: dec,
                      onChanged: _fromDec,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text("Decimal"),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 9,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  elevation: 8,
                  child: new Container(
                    padding: EdgeInsets.all(5.0),
                    child: new TextField(
                      maxLines: 1,
                      style: TextStyle(color: Colors.blue),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        // ignore: deprecated_member_use
                        WhitelistingTextInputFormatter(
                          RegExp('[\0, \1]'),
                        )
                      ],
                      controller: bin,
                      onChanged: _fromBin,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text("Binary"),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 9,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  elevation: 8,
                  child: new Container(
                    padding: EdgeInsets.all(5.0),
                    child: new TextField(
                      maxLines: 1,
                      style: TextStyle(color: Colors.blue),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        // ignore: deprecated_member_use
                        WhitelistingTextInputFormatter(
                          RegExp('[\0, \1, \2, \3, \4, \5, \6, \7,]',
                              caseSensitive: false),
                        )
                      ],
                      controller: oct,
                      onChanged: _fromOct,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text("Octal"),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 9,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  elevation: 8,
                  child: new Container(
                    padding: EdgeInsets.all(5.0),
                    child: new TextField(
                      maxLines: 1,
                      style: TextStyle(color: Colors.blue),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [
                        // ignore: deprecated_member_use
                        WhitelistingTextInputFormatter(
                          RegExp(
                              '[\0, \1, \2, \3, \4, \5, \6, \7, \8, \9, \a, \A, \b, \B, \c, \C, \d, \D, \e, \E, \f, \F]',
                              caseSensitive: false),
                        )
                      ],
                      controller: hex,
                      onChanged: _fromHex,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text("HexaDecimal"),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
            ],
          ),
        ),
      ),
    );
  }

  void _fromDec(String text) {
    setState(() {
      if (text.isNotEmpty) {
        bin.text = _dec2bin(text);
        oct.text = _dec2oct(text);
        hex.text = _dec2hex(text);
      } else {
        _clearAll();
      }
    });
  }

  void _fromBin(String text) {
    int exp = text.length - 1;
    int res = 0;

    for (int i = 0; i < text.length; i++) {
      res += int.parse(text[i]) * pow(2, exp - i);
    }
    setState(() {
      if (text.isNotEmpty) {
        dec.text = res.toString();
        oct.text = _dec2oct(dec.text);
        hex.text = _dec2hex(dec.text);
      } else {
        _clearAll();
      }
    });
  }

  void _fromOct(String text) {
    int exp = text.length - 1;
    int res = 0;
    for (var i = 0; i < text.length; i++) {
      res += int.parse(text[i]) * pow(8, exp);
      exp--;
    }
    setState(() {
      if (text.isNotEmpty) {
        dec.text = res.toString();
        bin.text = _dec2bin(res.toString());
        hex.text = _dec2hex(res.toString());
      } else {
        _clearAll();
      }
    });
  }

  void _fromHex(String text) {
    Map<String, int> especiais = {
      "A": 10,
      "B": 11,
      "C": 12,
      "D": 13,
      "E": 14,
      "F": 15
    };
    int exp = text.length - 1;
    int res = 0;
    for (var i = 0; i < text.length; i++) {
      if (especiais.containsKey(text[i].toUpperCase())) {
        res += especiais[text[i].toUpperCase()] * pow(16, exp);
      } else {
        res += int.parse(text[i]) * pow(16, exp);
      }
      exp--;
    }
    setState(() {
      if (text.isNotEmpty) {
        dec.text = res.toString();
        bin.text = _dec2bin(dec.text);
        oct.text = _dec2oct(dec.text);
      } else {
        _clearAll();
      }
    });
  }

  void _clearAll() {
    setState(() {
      dec.text = "";
      bin.text = "";
      oct.text = "";
      hex.text = "";
    });
  }

  String _dec2bin(String text) {
    int dec = int.parse(text);
    String nBin = '';
    while (dec >= 1) {
      nBin = (dec % 2).toString() + nBin;
      dec ~/= 2;
    }
    return nBin;
  }

  String _dec2oct(String text) {
    String res = '';
    int dec = int.parse(text);
    while (dec >= 1) {
      res = (dec % 8).toString() + res;
      dec ~/= 8;
    }
    return res;
  }

  String _dec2hex(String text) {
    Map<int, String> especiais = {
      10: "A",
      11: "B",
      12: "C",
      13: "D",
      14: "E",
      15: "F"
    };
    String res = '';
    int dec = int.parse(text), aux;
    while (dec >= 1) {
      if (dec % 16 > 9) {
        aux = dec % 16;
        res = especiais[aux].toString() + res;
      } else {
        res = (dec % 16).toString() + res;
      }
      dec ~/= 16;
    }
    return res;
  }
}
