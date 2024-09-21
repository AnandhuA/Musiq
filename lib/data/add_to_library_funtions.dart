import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musiq/models/library_model.dart';

class AddToLibrary {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addLibraryItem(
      {required LibraryModel libraryModel}) async {
    try {
      if (_auth.currentUser?.email != null) {
        final userId = _auth.currentUser!.email;
        await _firestore
            .collection('users')
            .doc(userId)
            .collection(libraryModel.type)
            .doc(libraryModel.id)
            .set(libraryModel.toJson());
        print('Item added to Firestore successfully');
      } else {
        log("not login ");
      }
    } catch (e) {
      print('Error adding item to Firestore: $e');
    }
  }

  static Future<List<LibraryModel>> getAllLibraryItems(
      {required List<String> types}) async {
    try {
      if (_auth.currentUser?.email != null) {
        final userId = _auth.currentUser!.email;
        List<LibraryModel> allItems = [];

        // Fetch items from each type collection
        for (String type in types) {
          QuerySnapshot snapshot = await _firestore
              .collection('users')
              .doc(userId)
              .collection(type)
              .get();

          List<LibraryModel> items = snapshot.docs
              .map((doc) =>
                  LibraryModel.fromJson(doc.data() as Map<String, dynamic>))
              .toList();

          allItems.addAll(items); // Add fetched items to the master list
        }

        return allItems;
      }
      return [];
    } catch (e) {
      print('Error getting items from Firestore: $e');
      return [];
    }
  }


  static Future<void> deleteLibraryItem({
    required String id,
    required String type,
  }) async {
    try {
      if (_auth.currentUser?.email != null) {
        final userId = _auth.currentUser!.email;
        await _firestore
            .collection('users')
            .doc(userId)
            .collection(type)
            .doc(id)
            .delete();
        print('Item deleted from Firestore successfully');
      } else {
        print("not login");
      }
    } catch (e) {
      print('Error deleting item from Firestore: $e');
    }
  }

  static Future<bool> checkLibraryItemExists({
    required String id,
    required String type,
  }) async {
    try {
      if (_auth.currentUser?.email != null) {
        final userId = _auth.currentUser!.email;
        DocumentSnapshot docSnapshot = await _firestore
            .collection('users')
            .doc(userId)
            .collection(type)
            .doc(id)
            .get();

        return docSnapshot.exists;
      } else {
        return false;
      }
    } catch (e) {
      print('Error checking if item exists: $e');
      return false;
    }
  }
}
