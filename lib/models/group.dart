import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  final String groupID;
  final String name;
  final String description;
  final Timestamp createdAt;

  Group({
    this.groupID,
    this.name,
    this.description,
    this.createdAt,
  });
}
