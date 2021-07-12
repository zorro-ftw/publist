import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:publist/firebase_services/auth_service.dart';
import 'package:publist/models/group.dart';
import 'package:publist/models/invite.dart';

class DataService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future createNewGroup(
      Group newGroup, String currentUserID, String currentUserName) async {
    Map currentMember = {currentUserID: currentUserName};

    await firestore.collection('groups').add({
      'groupCreatorID': currentUserID,
      'groupName': newGroup.name,
      'groupDescription': newGroup.description,
      'groupMemberIDs': [currentUserID],
      'groupAdmins': [currentUserID],
      'groupMembers': currentMember,
      'groupLists': [],
      'createdAt': newGroup.createdAt
    });
  }

  Future getData(String collectionPath) async {
    // final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final outputData = await firestore.collection(collectionPath).get();
    return outputData.docs;
  }

  // Future<List> getInviteStream() async {
  //   List invites = [];
  //   await for (var snapshot in firestore
  //       .collection('invites')
  //       .where('receiverID', isEqualTo: await AuthService().currentUserId())
  //       .orderBy('createdAt', descending: false)
  //       .snapshots()) {
  //     invites.add(Invite(
  //         id: snapshot.docs[invites.length].id,
  //         receiverID: snapshot.docs[invites.length].data()['receiverID'],
  //         senderID: snapshot.docs[invites.length].data()['senderID'],
  //         senderName: snapshot.docs[invites.length].data()['senderName'],
  //         inviteForID: snapshot.docs[invites.length].data()['inviteForID'],
  //         inviteForName: snapshot.docs[invites.length].data()['inviteForName'],
  //         createdAt: snapshot.docs[invites.length].data()['createdAt']));
  //   }
  //   return invites;
  // }

  Future getArrayQuery(
      {String queryString, String collection, String field}) async {
    final queryOutputData = await firestore
        .collection(collection)
        .where(field, arrayContainsAny: [queryString])
        .orderBy('createdAt', descending: false)
        .get();
    return queryOutputData.docs;
  }

  Future getArrayQueryUpdate(
      {String queryString, String collection, String field}) async {
    final queryOutputData = await firestore
        .collection(collection)
        .where(field, arrayContainsAny: [queryString]).get();
    return queryOutputData.docChanges;
  }

  Future getStringQuery(
      {String queryString, String collection, String field}) async {
    final queryOutputData = await firestore
        .collection(collection)
        .where(field, isGreaterThanOrEqualTo: queryString)
        .get();

    return queryOutputData.docs;
  }

  Future<Map> getCollectionByIdQuery(
      {String documentID, String collection}) async {
    final queryOutputData =
        await firestore.collection(collection).doc(documentID).get();

    return queryOutputData.data();
  }
}
