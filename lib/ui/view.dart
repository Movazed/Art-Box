import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({Key? key, required this.imagePath}) : super(key: key);

  final String imagePath;

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  final Map<String, String> bodyPartImages = {
    'Arm': 'assets/images/arm.jpg',
    'Leg': 'assets/images/leg.jpg',
    'Back': 'assets/images/back.jpg',
    'Chest': 'assets/images/chest.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Tattoo Design'),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () => _pickImage(ImageSource.camera),
          ),
          IconButton(
            icon: Icon(Icons.photo),
            onPressed: () => _pickImage(ImageSource.gallery),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/view.png'), // Path to your background image
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          _imageFile == null ? _buildBlankBodyCanvas() : _buildImageView(),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget _buildBlankBodyCanvas() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Select a body part to view the tattoo design',
            style: TextStyle(color: Colors.white, fontSize: 16), // Adjusted text color for better visibility
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 10,
            children: [
              _buildBodyPartButton('Arm', Icons.accessibility_new),
              _buildBodyPartButton('Leg', Icons.directions_run),
              _buildBodyPartButton('Back', Icons.directions_walk),
              _buildBodyPartButton('Chest', Icons.accessibility),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBodyPartButton(String label, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          _imageFile = null; // Clear previous image if any
          _imageFile = XFile(bodyPartImages[label]!);
        });
      },
      icon: Icon(icon),
      label: Text(label),
    );
  }

  Widget _buildImageView() {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            _imageFile!.path,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _imageFile = null;
              });
            },
            child: Text('Close'),
          ),
        ),
      ],
    );
  }
}
