import 'package:flutter/material.dart';

void main() {
  runApp(CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CurrencyConverter(),
    );
  }
}

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController _controller = TextEditingController();
  double _convertedValue = 0.0;
  String _selectedCurrency = "EUR"; // Padrão: Euro
  final Map<String, double> _rates = {
    "EUR": 0.91, // Euro
    "BRL": 5.12, // Real Brasileiro
    "GBP": 0.79, // Libra
    "JPY": 150.75, // Iene Japonês
  };

  void convertCurrency() {
    setState(() {
      double amount = double.tryParse(_controller.text) ?? 0;
      _convertedValue = amount * _rates[_selectedCurrency]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Conversor de Moeda")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Valor em USD"),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedCurrency,
              items: _rates.keys.map((String currency) {
                return DropdownMenuItem(value: currency, child: Text(currency));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCurrency = value!;
                });
              },
            ),
            SizedBox(height: 20),
            Text("Valor Convertido: $_convertedValue $_selectedCurrency",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: convertCurrency,
              child: Text("Converter"),
            ),
          ],
        ),
      ),
    );
  }
}
