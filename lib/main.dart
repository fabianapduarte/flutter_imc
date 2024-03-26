import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Calculadora de IMC',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String _textInfo = "";

  void _resetForm() {
    _formKey.currentState!.reset();
    pesoController.clear();
    alturaController.clear();
    setState(() {
      _textInfo = "";
    });
  }

  void _calcularIMC() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);

      if (imc < 18.6) {
        _textInfo = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _textInfo = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _textInfo = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _textInfo = "Obesidade grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _textInfo = "Obesidade grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 39.9) {
        _textInfo = "Obesidade grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
            title: const Text(
              "Calculadora de IMC",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue.shade700,
            actions: <Widget>[
              IconButton(
                  onPressed: _resetForm,
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ))
            ]),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30.0),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: Icon(Icons.account_circle, size: 130, color: Colors.blue.shade700)),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: pesoController,
                      decoration: InputDecoration(
                          labelText: 'Peso (kg)',
                          labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
                          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade700))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Insira seu peso";
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: alturaController,
                      decoration: InputDecoration(
                          labelText: 'Altura (cm)',
                          labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
                          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade700))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Insira sua altura";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: OutlinedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) _calcularIMC();
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                              padding:
                                  MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 12, horizontal: 30)),
                              side: MaterialStateProperty.all(
                                  BorderSide(color: Colors.blue.shade700, width: 1.0, style: BorderStyle.solid))),
                          child: Text('Calcular', style: TextStyle(color: Colors.blue.shade700)),
                        )),
                    Text(_textInfo,
                        textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                  ],
                ))));
  }
}
