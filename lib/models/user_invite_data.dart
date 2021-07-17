import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:publist/firebase_services/auth_service.dart';
import 'invite.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInviteData extends ChangeNotifier {
  List invites = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future getUserInvites() async {
    await for (var snapshot in firestore
        .collection('invites')
        .where('receiverEmail',
            isEqualTo: await AuthService().currentUserEmail())
        .orderBy('createdAt', descending: false)
        .snapshots()) {
      if (snapshot.docs.length > inviteCount) {
        if (inviteCount == 0) {
          invites.add(Invite(
              id: snapshot.docs[inviteCount].id,
              receiverID: snapshot.docs[inviteCount].data()['receiverID'],
              senderID: snapshot.docs[inviteCount].data()['senderID'],
              senderName: snapshot.docs[inviteCount].data()['senderName'],
              inviteForID: snapshot.docs[inviteCount].data()['inviteForID'],
              inviteForName: snapshot.docs[inviteCount].data()['inviteForName'],
              createdAt: snapshot.docs[inviteCount].data()['createdAt']));
          notifyListeners();
        } else if (invites[inviteCount - 1].id !=
            snapshot.docs[inviteCount].id) {
          invites.add(Invite(
              id: snapshot.docs[inviteCount].id,
              receiverID: snapshot.docs[inviteCount].data()['receiverID'],
              senderID: snapshot.docs[inviteCount].data()['senderID'],
              senderName: snapshot.docs[inviteCount].data()['senderName'],
              inviteForID: snapshot.docs[inviteCount].data()['inviteForID'],
              inviteForName: snapshot.docs[inviteCount].data()['inviteForName'],
              createdAt: snapshot.docs[inviteCount].data()['createdAt']));
          notifyListeners();
        }
      }
    }
  }

  int get inviteCount {
    return invites.length;
  }

  Future inviteUser(
      {String userEmail, String groupID, String groupName}) async {
    await firestore.collection('invites').add({
      'createdAt': Timestamp.now(),
      'inviteForID': groupID.toString(),
      'inviteForName': groupName.toString(),
      'isAccepted': false,
      'isRejected': false,
      'receiverEmail': userEmail,
      'senderID': _auth.currentUser.uid,
      'senderName': _auth.currentUser.displayName
    });
  }
}
