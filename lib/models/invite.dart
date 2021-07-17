import 'package:cloud_firestore/cloud_firestore.dart';

class Invite {
  final Timestamp createdAt;
  final String id;
  final String senderID;
  final String senderName;
  final String receiverEmail;
  final String inviteForID;
  final String inviteForName;
  final bool isAccepted;
  final bool isRejected;

  Invite(
      {this.id,
      this.receiverEmail,
      this.senderID,
      this.senderName,
      this.inviteForID,
      this.inviteForName,
      this.createdAt,
      this.isAccepted = false,
      this.isRejected = false});
}
