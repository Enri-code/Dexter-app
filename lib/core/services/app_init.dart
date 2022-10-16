import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexter_test/core/constants/variables.dart';
import 'package:dexter_test/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class AppInit {
  static setupFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    firestore = FirebaseFirestore.instance;
  }
}
