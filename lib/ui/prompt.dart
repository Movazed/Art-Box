import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'view.dart'; // Import the view.dart file

class MySecond extends StatefulWidget {
  const MySecond({Key? key}) : super(key: key);

  @override
  State<MySecond> createState() => _MySecondState();
}

class _MySecondState extends State<MySecond> {
  var apiKey1 =
      "vk-0nRUwYZiuhOutiedxqDlH3bPLxDWRC6TstnTVcPk4HPAt"; // Replace with your actual Vyro API key
  TextEditingController controller = TextEditingController();
  var imageUrl = '';
  bool isLoading = false;
  Uint8List? imageData; // Define imageData variable

  Future<void> generateImage(String prompt) async {
    setState(() {
      isLoading = true; // Start loading
    });

    final apiKey = apiKey1; // Replace with your actual API key
    final uri = Uri.parse('https://api.vyro.ai/v1/imagine/api/generations');
    final headers = {
      'Authorization': 'Bearer $apiKey'
    };

    try {
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers)
        ..fields['prompt'] = prompt
        ..fields['style_id'] = '29' // Adjust style_id as needed
        ..fields['high_res_results'] = '1';

      var response = await http.Client().send(request);
      var responseBytes = await response.stream.toBytes(); // Read response as bytes

      // Log status code and response body for debugging
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${responseBytes.length} bytes');

      if (response.statusCode == 200) {
        setState(() {
          imageData = Uint8List.fromList(responseBytes); // Convert response bytes to Uint8List
          isLoading = false;
        });
      } else {
        // Handle error response
        handleResponse(response.statusCode, responseBytes);
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false; // Stop loading on exception
      });
    }
  }

  void handleResponse(int statusCode, Uint8List responseBody) {
    // Handle response based on status code
    // For example, you can display a Snackbar with error message
    final errorMessage = "Error: $statusCode";
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/prompt.jpg"), // Add the background image
            fit: BoxFit.cover, // Adjust as needed
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(20),
          child: Stack(
            children: [
              Positioned(
                top: 40,
                left: 16,
                child: IconButton(
                  icon: Icon(Icons.arrow_back), // Back button icon
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                top: 40,
                right: 16,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward), // Next button icon
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewPage(imagePath: '/results',)),
                    );
                  },
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Create With AI ",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 40),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    isLoading
                        ? CircularProgressIndicator()
                        : imageData != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    20), // Adjust the radius for more or less rounded corners
                                child: Image.memory(
                                  imageData!, // Use imageData
                                  width: 400,
                                  height: 400,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextField(
                      controller: controller,
                      maxLines: 6,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          filled: true, // Enables the fill color of the text field
                          fillColor: Colors.grey.shade800,
                          hintText: "Enter description of the image",
                          hintStyle: TextStyle(
                              color: Colors.white60 // Sets the hint text color to white
                              ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30.0), // Curves the button edges
                          ),
                        ),
                        onPressed: () {
                          if (!isLoading) {
                            // Prevent multiple presses
                            generateImage(controller.text);
                          }
                        },
                        child: Text(
                          isLoading ? "Generating..." : "Generate Image",
                          style: TextStyle(
                            fontSize: 19,
                            fontStyle: FontStyle.italic,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
