import 'package:flutter/material.dart';

void main() => runApp(MyCalculator());

class MyCalculator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: Calculator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  String text = '0';
  double firstNum = 0;
  double secondNum = 0;

  String result = '0';
  String finalResult = '0';

  String opr = '';
  String preOpr = '';

  String add() {
    result = (firstNum + secondNum).toString();
    firstNum = double.parse(result);
    return decimalRemove(result);
  }

  String sub() {
    result = (firstNum - secondNum).toString();
    firstNum = double.parse(result);
    return decimalRemove(result);
  }

  String mul() {
    result = (firstNum * secondNum).toString();
    firstNum = double.parse(result);
    return decimalRemove(result);
  }

  String div() {
    result = (firstNum / secondNum).toString();
    firstNum = double.parse(result);
    return decimalRemove(result);
  }


  String decimalRemove(String _result) {

    if (_result.contains('.')) {
      List<String> split = _result.split('.');
      if(!(int.parse(split[1]) > 0))
        return split[0];
    }
    return _result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("AC", Colors.grey, 1),
                button("+/-", Colors.grey, 1),
                button("%", Colors.grey, 1),
                button("÷", Colors.orange, 1)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("7", Colors.grey[800], 1),
                button("8", Colors.grey[800], 1),
                button("9", Colors.grey[800], 1),
                button("×", Colors.orange, 1)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("4", Colors.grey[800], 1),
                button("5", Colors.grey[800], 1),
                button("6", Colors.grey[800], 1),
                button("-", Colors.orange, 1)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("1", Colors.grey[800], 1),
                button("2", Colors.grey[800], 1),
                button("3", Colors.grey[800], 1),
                button("+", Colors.orange, 1)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("0", Colors.grey[800], 0),
                button(".", Colors.grey[800], 1),
                button("=", Colors.orange, 1)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget button(String btnTxt, Color color, int num) {
    if(num == 0) {
      return Container(
          padding: EdgeInsets.only(bottom: 10),
          child: RaisedButton(
            onPressed: () {
              calculate(btnTxt);
            },
            child: Text(btnTxt,
                style: TextStyle(
                    fontSize: 30
                )
            ),
            color: color,
            padding: EdgeInsets.only(left:81, top:20, right: 81, bottom: 20),
            shape: StadiumBorder(),
          )
      );
    } else {
        return Container(
          padding: EdgeInsets.only(bottom: 10),
          child: RaisedButton(
            onPressed: () {
              calculate(btnTxt);
            },
            child: Text(btnTxt,
                style: TextStyle(
                    fontSize: 30
                )
            ),
            color: color,
            padding: EdgeInsets.all(20),
            shape: CircleBorder(),
          )
      );
    }
  }

  void calculate(txtBtn) {
    if(txtBtn == 'AC') {
      text = '0';
      firstNum = 0;
      secondNum = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    }
    else if (opr == '=' && txtBtn == '=' ) {
      switch(preOpr) {
        case '+':
          finalResult =  add();
          break;
        case '-':
          finalResult = sub();
          break;
        case '×':
          finalResult = mul();
          break;
        case '÷':
          finalResult = div();
          break;
      }
    } else if(txtBtn == '+' || txtBtn == '-' || txtBtn == '×' || txtBtn == '÷' || txtBtn == '=') {

      if (firstNum == 0) {
        firstNum = double.parse(result);
      } else {
        secondNum = double.parse(result);
      }

      switch(opr){
        case '+':
          finalResult = add();
          break;
        case '-':
          finalResult = sub();
          break;
        case '×':
          finalResult = mul();
          break;
        case '÷':
          finalResult = div();
          break;
      }

      preOpr =  opr;
      opr = txtBtn;
      result = '';
    } else if (txtBtn  == '%') {
      result = (firstNum / 100).toString();
      finalResult = result;
    } else if (txtBtn == '.') {
      if(!result.contains('.'))
        result += '.';
      finalResult = result;
    } else if (txtBtn == '+/-') {

      result.startsWith('-') ? result = result.substring(1): result = '-' + result;

      finalResult = result;

    } else {
      if (result == '0')
        result = txtBtn;
      else
        result = result + txtBtn;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }
}

