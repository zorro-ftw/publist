class Invite {
  final String id;
  final String sender;
  final String receiver;
  final String inviteFor;
  final bool isAccepted;

  Invite(
      {this.id,
      this.receiver,
      this.sender,
      this.inviteFor,
      this.isAccepted = false});
}
