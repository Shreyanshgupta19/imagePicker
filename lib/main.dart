
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 6-Corner Container Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: '6-Corner Container Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      this._image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ContainerWithSixCorners(image: _image), // Pass _image as a parameter
            CustomButton(
              onClick: getImage,
            ),
          ],
        ),
      ),
    );
  }
}

Widget CustomButton({
  required VoidCallback onClick,
}){
  return Container(
    child: ElevatedButton(
      onPressed: onClick,
      child: Text("Select the pic"),
    ),
  );
}

class ContainerWithSixCorners extends StatelessWidget {
  final File? image;

  ContainerWithSixCorners({required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 200,
          child: Stack(
            children: [
              ClipPath(
                clipper: SixCornerClipper(),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: image != null ? FileImage(image!) : AssetImage('assets/images/player.jpg') as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 1,
                      width: 199,
                      height: 170,
                      child: SvgPicture.asset('assets/svg/customshape.svg'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SixCornerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(70.8689 * 2, 2.05162 * 2);
    path.cubicTo(73.5145 * 2, 2.05162 * 2, 76.0524 * 2, 3.10002 * 2, 77.9266 * 2, 4.96723 * 2);
    path.lineTo(95.0928 * 2, 22.0688 * 2);
    path.cubicTo(96.9764 * 2, 23.9452 * 2, 98.0351 * 2, 26.4945 * 2, 98.0351 * 2, 29.1532 * 2);
    path.lineTo(98.0351 * 2, 73.4944 * 2);
    path.cubicTo(98.0351 * 2, 79.0172 * 2, 93.558 * 2, 83.4944 * 2, 88.0351 * 2, 83.4944 * 2);
    path.lineTo(27.8917 * 2, 83.4944 * 2);
    path.cubicTo(24.8053 * 2, 83.4944 * 2, 21.8918 * 2, 82.0692 * 2, 19.9973 * 2, 79.6327 * 2);
    path.lineTo(4.50473 * 2, 59.708 * 2);
    path.cubicTo(3.14001 * 2, 57.9529 * 2, 2.3991 * 2, 55.793 * 2, 2.3991 * 2, 53.5697 * 2);
    path.lineTo(2.3991 * 2, 12.0516 * 2);
    path.cubicTo(2.3991 * 2, 6.52876 * 2, 6.87625 * 2, 2.0516 * 2, 12.3991 * 2, 2.0516 * 2);
    path.lineTo(70.8689 * 2, 2.05162 * 2);
    path.lineTo(0, size.height / 2 * 2);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

