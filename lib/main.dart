import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String? weightErrorText, heightErrorText;

  String infoText = "Enter your data";

  void resetFields() {
    weightController.clear();
    heightController.clear();

    setState(() {
      infoText = "Enter your data";
    });
  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        infoText = "Underweight (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        infoText = "Ideal Weight (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        infoText = "Slightly overweight (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        infoText = "Grade I obesity (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        infoText = "Grade II obesity (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        infoText = "Grade III obesity (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMC Calculator'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              resetFields();
            },
          ),
        ],
      ),

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.person_outline, size: 120, color: Colors.green),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight (Kg)',
                labelStyle: TextStyle(color: Colors.green),
                errorText: weightErrorText,
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green),
              controller: weightController,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height (cm)',
                labelStyle: TextStyle(color: Colors.green),
                errorText: heightErrorText,
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green),
              controller: heightController,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (weightController.text.isEmpty) {
                      setState(() {
                        weightErrorText = "The weight cannot by empty";
                      });

                      return;
                    } else {
                      setState(() {
                        weightErrorText = null;
                      });
                    }

                    if (heightController.text.isEmpty) {
                      setState(() {
                        heightErrorText = "The height cannot by empty";
                      });

                      return;
                    } else {
                      setState(() {
                        heightErrorText = null;
                      });
                    }

                    calculate();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text(
                    'Calculate',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
            Text(
              infoText,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
