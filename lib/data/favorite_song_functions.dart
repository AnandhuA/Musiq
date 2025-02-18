import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musiq/models/song_model/song.dart';

class FavoriteSongRepo {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Future<String> addFavorite({required Song song}) async {
    try {
      if (_auth.currentUser?.email != null) {
        final userId = _auth.currentUser!.email;

        CollectionReference favoriteCollection =
            firestore.collection('users').doc(userId).collection('favorite');

        Map<String, dynamic> favoriteData = song.toJson();
        favoriteData['addedAt'] = DateTime.now().toIso8601String();

        await favoriteCollection.add(favoriteData);
        return "true";
      } else {
        if (defaultTargetPlatform != TargetPlatform.windows) {
          Fluttertoast.showToast(msg: "not login");
        }
        return "not login";
      }
    } catch (e) {
      print('Error adding favorite: $e');
      if (defaultTargetPlatform != TargetPlatform.windows) {
        Fluttertoast.showToast(msg: "Error adding favorite: $e");
      }
      return "false";
    }
  }

  static Future<bool> removeFavorite({required String songID}) async {
    try {
      if (_auth.currentUser?.email != null) {
        final userId = _auth.currentUser!.email;

        CollectionReference favoriteCollection =
            firestore.collection('users').doc(userId).collection('favorite');
        QuerySnapshot querySnapshot =
            await favoriteCollection.where('id', isEqualTo: songID).get();
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          await doc.reference.delete();
        }

        return true;
      }
      return false;
    } catch (e) {
      print('Error removing favorite: $e');
      if (defaultTargetPlatform != TargetPlatform.windows) {
        Fluttertoast.showToast(msg: "Error removing favorite: $e");
      }
      return false;
    }
  }

  static Future<List<Song>> fetchFavorites() async {
    List<Song> favoriteSongs = [];
    try {
      if (_auth.currentUser?.email != null) {
        final userId = _auth.currentUser!.email;

        CollectionReference favoriteCollection =
            firestore.collection('users').doc(userId).collection('favorite');

        QuerySnapshot querySnapshot = await favoriteCollection.get();
        for (var doc in querySnapshot.docs) {
          favoriteSongs.add(Song.fromJson(doc.data() as Map<String, dynamic>));
        }
      }
    } catch (e) {
      log('Error fetching favorites: $e');
      if (defaultTargetPlatform != TargetPlatform.windows) {
        Fluttertoast.showToast(msg: "Error fetching favorites: $e");
      }
    }
    return favoriteSongs;
  }
}
