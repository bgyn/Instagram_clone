import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/states/auth/constant/firebase_collection_name.dart';
import 'package:instagram_clone/states/auth/constant/firebase_field_name.dart';
import 'package:instagram_clone/states/post/typedefs/user_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/states/user_info/models/user_info_payload.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();
  Future<bool> saveUserInfo({
    required UserId userId,
    required String displayName,
    required String? email,
  }) async {
    try {
      //first check if we have the user's info from before
      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .where(FirebaseFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        //we already have this user info
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email ?? "",
        });
        return true;
      }

      //we don't have this user info
      final playload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
        email: email,
      );

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .add(playload);
      return true;
    } catch (e) {
      return false;
    }
  }
}
