import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:publist/firebase_services/auth_service.dart';
import 'package:publist/firebase_services/data_service.dart';
import 'invite.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInviteData extends ChangeNotifier {
  List invites = [];
  bool isAlreadyMember = false;

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
          invites.add(
            Invite(
              id: snapshot.docs[inviteCount].id,
              receiverEmail: snapshot.docs[inviteCount].data()['receiverID'],
              senderID: snapshot.docs[inviteCount].data()['senderID'],
              senderName: snapshot.docs[inviteCount].data()['senderName'],
              inviteForID: snapshot.docs[inviteCount].data()['inviteForID'],
              inviteForName: snapshot.docs[inviteCount].data()['inviteForName'],
              createdAt: snapshot.docs[inviteCount].data()['createdAt'],
              isAccepted: snapshot.docs[inviteCount].data()['isAccepted'],
              isRejected: snapshot.docs[inviteCount].data()['isRejected'],
            ),
          );

          notifyListeners();
        } else if (invites[inviteCount - 1].id !=
            snapshot.docs[inviteCount].id) {
          invites.add(Invite(
            id: snapshot.docs[inviteCount].id,
            receiverEmail: snapshot.docs[inviteCount].data()['receiverID'],
            senderID: snapshot.docs[inviteCount].data()['senderID'],
            senderName: snapshot.docs[inviteCount].data()['senderName'],
            inviteForID: snapshot.docs[inviteCount].data()['inviteForID'],
            inviteForName: snapshot.docs[inviteCount].data()['inviteForName'],
            createdAt: snapshot.docs[inviteCount].data()['createdAt'],
            isAccepted: snapshot.docs[inviteCount].data()['isAccepted'],
            isRejected: snapshot.docs[inviteCount].data()['isRejected'],
          ));
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

  Future acceptInvite({Invite currentInvite}) async {
    var dummy = await DataService().getCollectionByIdQuery(
        collection: 'groups', documentID: currentInvite.inviteForID);

    /// groupMembers bir map oldu??u i??in direkt ekleme yap??nca o data var m?? yok mu kontrol??n?? kendi yap??yor.
    /// Ancak groupMemberIDs bir list oldu??undan bu kontrol?? yapmak i??in a??a????daki gibi bir for ??evirmek gerek.
    /// B??ylece daveti kabul eden kullan??c?? zaten ??yeyse, iki kere yaz??lmam???? olacak.
    for (var memberID in dummy['groupMemberIDs']) {
      if (memberID == _auth.currentUser.uid) {
        isAlreadyMember = true;

        break;
      }
    }

    if (!isAlreadyMember) {
      dummy['groupMembers'][_auth.currentUser.uid] =
          _auth.currentUser.displayName;
      dummy['groupMemberIDs'].add(_auth.currentUser.uid);

      await DataService().updateDataByID(
          collectionPath: 'invites',
          docID: currentInvite.id,
          field: 'isAccepted',
          value: true);

      await DataService().updateDataByID(
          collectionPath: 'groups',
          docID: currentInvite.inviteForID,
          field: 'groupMemberIDs',
          value: dummy['groupMemberIDs']);

      await DataService().updateDataByID(
          collectionPath: 'groups',
          docID: currentInvite.inviteForID,
          field: 'groupMembers',
          value: dummy['groupMembers']);
    }

    for (int i = 0; i < invites.length; i++) {
      if (invites[i].id == currentInvite.id) {
        invites.removeAt(i);
      }
    }
    notifyListeners();
    await firestore.collection('invites').doc(currentInvite.id).delete();
  }

  Future<void> rejectInvite({Invite currentInvite}) async {
    //TODO - UI g??ncellemesi i??in bir ??eyler eklemek gerekecek. getUserGroups() fonksiyonunu modifiye edip onu burada ??a????rabilirim.
    await firestore.collection('invites').doc(currentInvite.id).delete();
    for (int i = 0; i < invites.length; i++) {
      if (invites[i].id == currentInvite.id) {
        invites.removeAt(i);
      }
    }
    notifyListeners();
  }
}
