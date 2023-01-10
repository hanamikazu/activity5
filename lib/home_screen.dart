import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  File? image;


  Future chooseFrom(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to choose image: $e');
    }
  }
  Future<void> _showOptionsDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Choose From: '),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              GestureDetector(
                child: const Text("Gallery", style: TextStyle(fontSize: 18),),
                onTap: (){
                  chooseFrom(ImageSource.gallery);
                }
              ),
              const Padding(padding: EdgeInsets.all(10)),
              GestureDetector(
                child: const Text("Camera", style: TextStyle(fontSize: 18)),
                onTap: (){
                  chooseFrom(ImageSource.camera);
                }
              )
            ],
          ),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Activity 5 - Martinito"),
        leading: const Icon(Icons.person),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.teal,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(30),
              alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    image != null ? ClipOval(
                        child: Image.file(image!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,))
                        : const FlutterLogo(size: 200),
                    ElevatedButton(onPressed: (){
                      _showOptionsDialog(context);
                      },style: ElevatedButton.styleFrom(backgroundColor: Colors.black54),
                        child: const Text("Choose Image", style: TextStyle(fontSize: 20),))
                  ],
                )
            ),
          Container(
            padding: const EdgeInsets.only(left: 20, top: 5, right: 20),
            child: const Text("ALATUS",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),),
          ),
          const Text("Conqueror of Demons",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
        ],
      ),
    );
  }
}
