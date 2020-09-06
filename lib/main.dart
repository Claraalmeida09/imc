import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de IMC',
      theme: ThemeData(primaryColor: Colors.pink[900]),
      home: Home()));
}

class Home extends StatefulWidget {
  // static const IconData accessibility = IconData(0xe84e, fontFamily: 'MaterialIcons');

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightControler = TextEditingController();
  TextEditingController heightControler = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados';

  void _resetFields() {
    weightControler.text = '';
    heightControler.text = '';
    setState(() {
      _infoText = 'Informe seus dados';
    });
  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightControler.text);
      double height = double.parse(heightControler.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = 'Abaixo do peso (${imc.toStringAsPrecision(4)})';
      } else if (imc > 18.6 && imc < 24.9) {
        _infoText = 'Peso ideal (${imc.toStringAsPrecision(4)})';
      } else if (imc > 24.9 && imc < 29.9) {
        _infoText = 'Levemente acima do peso (${imc.toStringAsPrecision(4)})';
      } else if (imc > 29.9 && imc < 34.9) {
        _infoText = 'Obesidade Grau I (${imc.toStringAsPrecision(4)})';
      } else if (imc > 34.9 && imc < 39.9) {
        _infoText = 'Obesidade Grau II (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 40) {
        _infoText = 'Obesidade Grau III (${imc.toStringAsPrecision(4)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Calculadora de IMC',
            style: TextStyle(color: Colors.pink[100]),
          ),
          centerTitle: true,
          leading: Icon(
            Icons.accessibility,
            color: Colors.pink[100],
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.pink[100],
                ),
                onPressed: _resetFields)
          ],
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.accessibility,
                    size: 120,
                    color: Colors.pink[900],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      // hintText: '0.00',
                      labelText: 'Peso (kg)',
                    ),
                    textAlign: TextAlign.center,
                    controller: weightControler,
                    style: TextStyle(color: Colors.pink[100], fontSize: 25),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Insira seu peso';
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      // hintText: '0.00',
                      labelText: 'Altura (cm)',
                    ),
                    controller: heightControler,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.pink[100], fontSize: 25),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Insira sua altura';
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            calculate();
                          }
                        },
                        child: Text(
                          'CALCULAR',
                          style:
                              TextStyle(color: Colors.pink[100], fontSize: 20),
                        ),
                        color: Colors.pink[900],
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.pink[100], fontSize: 25),
                  )
                ],
              ),
            )));
  }
}
