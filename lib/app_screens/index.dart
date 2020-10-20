import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Controladores para capturar valores
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso: ";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal: ";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso: ";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = _infoText = "Obesidade Grau I: ";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = _infoText = "Obesidade Grau II: ";
      } else if (imc >= 40) {
        _infoText = _infoText = "Obesidade Grau III: ";
      }
      _infoText += imc.toStringAsPrecision(3).replaceAll('.', ',');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Calculadora de IMC",
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
        /* ações */
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_rounded,
                size: 120.0,
                color: Colors.teal,
              ),
              /* Input Field Number */
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Peso(kg)',
                  labelStyle: TextStyle(color: Colors.teal),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.teal, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu Peso";
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Altura (cm)',
                  labelStyle: TextStyle(color: Colors.teal),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.teal, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) return "Insira sua Altura!";
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      (_formKey.currentState.validate()) ? _calculate() : null;
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.teal,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.teal, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
