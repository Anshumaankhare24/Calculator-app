// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:math_expressions/math_expressions.dart';

class Claculater extends StatefulWidget {
  const Claculater({super.key});

  @override
  State<Claculater> createState() => _ClaculaterState();
}

class _ClaculaterState extends State<Claculater> {
  var arrNumber = [
    "7",
    "8",
    "9",
    "/",
    "4",
    "5",
    "6",
    "*",
    "1",
    "2",
    "3",
    "-",
    "0",
    "C",
    "=",
    "+"
  ];
  String inputText = ""; // To store the expression
  String resultText = "0"; // To display the result
  void Ontap(String value) {
    setState(() {
      if (value == "C") {
        inputText = ""; // Clear input
        resultText = "0"; // Reset result
      } else if (value == "=") {
        // Evaluate the expression
        try {
          Parser parser = Parser();
          Expression expression = parser.parse(inputText);
          ContextModel contextModel = ContextModel();
          double result =
              expression.evaluate(EvaluationType.REAL, contextModel);
          resultText = result.toString(); // Update result
        } catch (e) {
          resultText = "Error"; // Handle invalid expressions
        }
      } else {
        inputText += value; // Append button value to input
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FaIcon(
                    FontAwesomeIcons.bars,
                    color: Colors.white,
                    size: 25,
                  ),
                  Text(
                    "Calculator",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
                  ),
                  FaIcon(
                    FontAwesomeIcons.clockRotateLeft,
                    color: Colors.white,
                    size: 25,
                  )
                ],
              ),
            ),
            Container(
              height: 100, // Display area height
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.centerRight,
              child: Text(
                inputText,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            Container(
              height: 100, // Result area height
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.centerRight,
              child: Text(
                resultText,
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                padding: const EdgeInsets.all(10.0),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Ontap(arrNumber[index]),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        arrNumber[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: arrNumber.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
