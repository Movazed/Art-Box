import 'package:flutter/material.dart';
import 'login.dart'; // Import the login.dart file
import 'prompt.dart'; // Import the PromptPage

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/member.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back), // Back button icon
                color: Colors.white,
                onPressed: () {
                  // Navigate back to the login page (login.dart)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: Icon(Icons.arrow_forward), // Next button icon
                color: Colors.white,
                onPressed: () {
                  // Navigate to the PromptPage when the next button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MySecond()),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTextWithBorder(
                    'BE PREMIUM\nGET UNLIMITED\nACCESS',
                    TextStyle(
                      fontSize: 28,
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                    2.0, // Border width
                    Colors.black, // Border color
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildTextWithBorder(
                      'When you subscribe, you\'ll get instant unlimited access',
                      TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                      1.5, // Border width
                      Colors.black, // Border color
                    ),
                  ),
                  SizedBox(height: 32),
                  _buildSubscriptionButton('Basic', '\$9.99/month', 'Few Images, Very Less Storage', [Color.fromARGB(255, 199, 30, 157).withOpacity(0.5), Color.fromARGB(255, 190, 38, 196).withOpacity(0.5)]),
                  SizedBox(height: 16),
                  _buildSubscriptionButton('Premium', '\$39.99/month', 'Good Images, Good Storage', [Colors.purple.withOpacity(0.5), Colors.deepPurple.withOpacity(0.5)]),
                  SizedBox(height: 16),
                  _buildSubscriptionButton('Pro', '\$69.99/month', 'More Images, More Storage', [Color.fromARGB(255, 247, 96, 234).withOpacity(0.5), Color.fromARGB(255, 182, 48, 194).withOpacity(0.5)]),
                  SizedBox(height: 16), // Adjusted spacing between buttons and the "Subscribe Now" button
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0), // Adjusted padding for the button
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 202, 57, 221),
                        backgroundColor: Colors.purpleAccent,
                        textStyle: TextStyle(fontSize: 20, fontFamily: 'Poppins', fontStyle: FontStyle.italic),
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 64),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ), // Secondary color for gradient
                      ),
                      child: Text('Subscribe Now', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextWithBorder(String text, TextStyle style, double strokeWidth, Color strokeColor) {
    return Stack(
      children: [
        Text(
          text,
          style: style.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        Text(
          text,
          style: style,
        ),
      ],
    );
  }

  Widget _buildSubscriptionButton(String title, String price, String description, List<Color> gradientColors) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(fontSize: 16, fontFamily: 'Poppins', fontStyle: FontStyle.italic),
          padding: EdgeInsets.zero, // Remove default padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.3, 0.7], // adjust the stops for transparency effect
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            padding: EdgeInsets.all(16), // Add padding to the container
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(price, style: TextStyle(color: Colors.white)),
                SizedBox(height: 8),
                Text(description, style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
