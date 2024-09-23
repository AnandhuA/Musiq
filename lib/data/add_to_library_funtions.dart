import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musiq/models/library_model.dart';
import 'package:musiq/models/song_model.dart';

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

  static Future<void> addToLastPlayedSong(SongModel song) async {
    try {
      if (_auth.currentUser?.email != null) {
        final userId = _auth.currentUser!.email;
        CollectionReference musicCollection = _firestore
            .collection('users')
            .doc(userId)
            .collection('Last Played');

        final existingSongSnapshot =
            await musicCollection.where('id', isEqualTo: song.id).get();
        if (existingSongSnapshot.docs.isNotEmpty) {
          for (var doc in existingSongSnapshot.docs) {
            await doc.reference.delete();
            log("Existing song removed: ${song.title}");
          }
        }

        Map<String, dynamic> songData = song.toJson();
        songData['addedAt'] = DateTime.now();
        await musicCollection.add(songData);

        log("Song added: ${song.title}");

        final snapshot = await musicCollection.get();
        if (snapshot.docs.length > 11) {
          await musicCollection
              .orderBy('addedAt', descending: false)
              .limit(1)
              .get()
              .then((querySnapshot) {
            for (var doc in querySnapshot.docs) {
              doc.reference.delete();
            }
          });
        }
      } else {
        log("Not logged in");
      }
    } catch (e) {
      log("Error: $e");
    }
  }

  static Future<List<SongModel>> fetchLastPlayed() async {
    List<SongModel> lastPlayedSongs = [];

    try {
      if (_auth.currentUser?.email != null) {
        final userId = _auth.currentUser!.email;
        CollectionReference musicCollection = _firestore
            .collection('users')
            .doc(userId)
            .collection('Last Played');
        final snapshot =
            await musicCollection.orderBy('addedAt', descending: true).get();

        for (var doc in snapshot.docs) {
          lastPlayedSongs
            ..add(SongModel.fromJson(doc.data() as Map<dynamic, dynamic>));
        }
      } else {
        log("Not logged in");
      }
    } catch (e) {
      log("Error fetching last played songs: $e");
    }

    return lastPlayedSongs;
  }

  static Future<void> clearLastPlayedSongs() async {
    try {
      if (_auth.currentUser?.email != null) {
        final userId = _auth.currentUser!.email;
        CollectionReference musicCollection = _firestore
            .collection('users')
            .doc(userId)
            .collection('Last Played');

        final snapshot = await musicCollection.get();
        for (var doc in snapshot.docs) {
          await doc.reference.delete();
          log("Deleted song: ${doc.id}");
        }
        log("All last played songs cleared.");
      } else {
        log("Not logged in");
      }
    } catch (e) {
      log("Error clearing last played songs: $e");
    }
  }
}
