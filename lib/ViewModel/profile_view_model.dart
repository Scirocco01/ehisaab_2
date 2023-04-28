


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileViewModel extends ChangeNotifier{
  User? user = FirebaseAuth.instance.currentUser;

  Future<List<String>> _getUserPostIds(String userId) async {
    List<String> postIds = [];

    try {
      CollectionReference userPostsRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('posts');

      QuerySnapshot snapshot = await userPostsRef.get();

      for (var doc in snapshot.docs) {
        postIds.add(doc.get('postId'));
      }
    } catch (e) {
      print('error occurred $e');
    }

    return postIds;
  }

  Future<List<String>> getImageUrlsByUserId(String userId, bool isCurrentUser) async {

    List<String> postIds = await _getUserPostIds(isCurrentUser?user!.uid:userId);

    final querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where(FieldPath.documentId, whereIn: postIds)
        .get();

    List<String> imageUrls = [];

    for (final doc in querySnapshot.docs) {
      // Assuming the field name containing the image URL is 'imageUrl'
      String? imageUrl = doc.data()['imageUrl'];
      if (imageUrl != null) {
        imageUrls.add(imageUrl);
      }
    }

    return imageUrls;
  }


  // follow a user so increment followers by one
  Future<void> updateFollowers(String followedUserID) async {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    try {

      final userDocRef = usersCollection.doc(user!.uid);
      await userDocRef.update({'following': FieldValue.increment(1)});
      print('Followers count updated successfully');

      final userDocRef2 = usersCollection.doc(followedUserID);
      await userDocRef2.update({'followers': FieldValue.increment(1)});


      DocumentReference userDocRef3 = usersCollection.doc(followedUserID);
      CollectionReference userPostsRef = userDocRef3.collection('followers');

      await userPostsRef.add({
      'followerIDs': user!.uid});
      print('Follower added successfully');


    } catch (error) {
      // Handle the error by printing it to the console
      print('Error updating followers count: $error');
    }
  }

  // follow a user so increment followers by one
  Future<void> removeFollowers(String followedUserID) async {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    try {

      final userDocRef = usersCollection.doc(user!.uid);
      await userDocRef.update({'following': FieldValue.increment(-1)});
      print('Followers count updated successfully');

      final userDocRef2 = usersCollection.doc(followedUserID);
      await userDocRef2.update({'followers': FieldValue.increment(-1)});


      DocumentReference userDocRef3 = usersCollection.doc(followedUserID);
      CollectionReference userPostsRef = userDocRef3.collection('followers');
      QuerySnapshot followerSnapshots = await userPostsRef.where('followerIDs', arrayContains: user!.uid).get();
      print('this is the user uid for deletion ${followerSnapshots.docs.length}');
      for (DocumentSnapshot followerSnapshot in followerSnapshots.docs) {
        print('this ref should be deleted ${followerSnapshot.reference.id}');
        await followerSnapshot.reference.delete();
      }
      print('Follower deleted successfully');


    } catch (error) {
      // Handle the error by printing it to the console
      print('Error updating followers count: $error');
    }
  }

  Future<bool> getFollowerIDs(String userID) async {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final followersCollectionRef = usersCollection.doc(userID).collection('followers');

    final snapshot = await followersCollectionRef.get();

    final followerIDs = snapshot.docs.map((doc) => doc['followerIDs'] as List<String>).expand((ids) => ids).toList();
    print('this is the list for followers Id $followerIDs');
    return followerIDs.contains(user!.uid);
  }


  /// signOut
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> signOut() async {
    try {
      await _auth.signOut();

      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();

      return true;

    } catch (e) {
      print('Error signing out: $e');
      return false;
    }
  }








}