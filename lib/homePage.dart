import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  var result;

  predictGender(String name) async {
    var url = "https://api.genderize.io/?name=$name";
    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    result = "Gender: ${data['gender']}";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Align children to start and end
          children: [
            Text('Gender predictor'), // Title aligned to the left
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Text('enter name to predict its gender'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter a name',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => predictGender(_nameController.text),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Color.fromARGB(
                          255, 45, 184, 49); // Color when the button is pressed
                    }
                    return const Color.fromARGB(
                        255, 11, 69, 117); // Default color
                  },
                ),
              ),
              child: const Text(
                'predict',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            if (result != null)
              Text(
                result,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
          ],
        ),
      ),
    );
  }
}
