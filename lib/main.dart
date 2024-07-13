import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:musiq/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await getuploadfile();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("data"),
      ),
    );
  }
}

getuploadfile() async {
  try {
    final storageRef = FirebaseStorage.instance.ref();
    final listResult = await storageRef.listAll();

    listResult.items.forEach((Reference ref) {
      log('Found file: ${ref.name}');
      ref.getDownloadURL().then((url) {
        log('File URL: $url');
      });
    });
  } catch (e) {
    log('Error: $e');
  }
}
