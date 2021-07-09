import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:publist/models/group.dart';

class DataService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future createNewGroup(Group newGroup, String currentUserID) async {
    await firestore.collection('groups').add({
      'groupCreatorID': currentUserID,
      'groupName': newGroup.name,
      'groupDescription': newGroup.description,
      'groupMembers': [currentUserID],
      'groupLists': [],
      'createdAt': newGroup.createdAt
    });
  }

  Future getData(String collectionPath) async {
    // final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final outputData = await firestore.collection(collectionPath).get();
    return outputData.docs;
  }

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
