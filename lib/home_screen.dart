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
        title: const Text('Choose From: ', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              GestureDetector(
                  child: const Text("Gallery", style: TextStyle(fontSize: 18),),
                  onTap: () async {
                    if (await Permission.storage.request().isGranted){
                      chooseFrom(ImageSource.gallery);
                    } else {
                      return;
                    }
                  }
              ),
              const Padding(padding: EdgeInsets.all(12)),
              GestureDetector(
                  child: const Text("Camera", style: TextStyle(fontSize: 18)),
                  onTap: () async {
                    if (await Permission.camera.request().isGranted) {
                      chooseFrom(ImageSource.camera);
                    } else {
                      return;
                    }
                  }
              ),
            ],
          ),
        ),
          actions: <Widget>[
            TextButton(onPressed: () {
              Navigator.of(context).pop();
              }, child: const Text("Okay",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),))
          ]
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
        body: DecoratedBox(decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/xiao.jpg"), fit: BoxFit.cover)
        ), child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    const SizedBox(height: 30,),
                    ElevatedButton(onPressed: () {
                      _showOptionsDialog(context);
                    },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black54,
                            padding: const EdgeInsets.all(12)),
                        child: const Text(
                            "Choose Image", style: TextStyle(fontSize: 20)))
                  ],
                )
            ),
            Container(
                padding: const EdgeInsets.only(left: 20, top: 5, right: 20),
                child: Column(
                  children: const [
                    Text("KYLA MARTINITO",
                      style: TextStyle(fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),),
                    SizedBox(height: 10,),
                    Text("BS in Information Technology",
                      style: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),),
                  ],
                )
            ),
            Container(
              color: Colors.white.withOpacity(0.7),
              padding: const EdgeInsets.all(30),
              margin: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Row(
                children: const [
                  SizedBox(
                    height: 8,
                  ),
                  Image(image: AssetImage('assets/instagram_PNG10.png'),
                    height: 50,
                    width: 50,),
                  Text("  aku_miyu ",
                    style: TextStyle(color: Colors.black,
                        fontSize: 18, fontWeight: FontWeight.w600),),
                  SizedBox(
                    height: 8,
                  ),
                  Image(image: AssetImage('assets/github.png'),
                    height: 70,
                    width: 70,),
                  Text("hanamikazu",
                    style: TextStyle(color: Colors.black,
                        fontSize: 18, fontWeight: FontWeight.w600),)
                ],
              ),
            ),
            ElevatedButton(onPressed: () {
              showDialog(context: context, builder: (ctx) =>
                  AlertDialog(
                    title: const Text("!! Final Output !!",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 24),),
                    content: const Text("Activity 5 - Mobile Programming",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),),
                    actions: <Widget>[
                      TextButton(onPressed: () {
                        Navigator.of(ctx).pop();
                      }, child: const Text("Okay",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),))
                    ],
                  ));
            },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black54,
                    padding: const EdgeInsets.all(12)),
                child: const Text("CLICK ME !!", style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.w500)))
          ],
        ),
        ));
  }
}
