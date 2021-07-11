import 'package:cloud_firestore/cloud_firestore.dart';

class Invite {
  final Timestamp createdAt;
  final String id;
  final String senderID;
  final String senderName;
  final String receiverID;
  final String inviteForID;
  final String inviteForName;
  final bool isAccepted;

  Invite(
      {this.id,
      this.receiverID,
      this.senderID,
      this.senderName,
      this.inviteForID,
      this.inviteForName,
      this.createdAt,
      this.isAccepted = false});
}
