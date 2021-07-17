import 'package:flutter/foundation.dart';
import 'package:publist/models/task.dart';
import 'dart:collection';

class UserData extends ChangeNotifier{
  String photoURL,email,name;
  void setPhotoUrl(String URL) {
    photoURL=URL;
    notifyListeners();
  }
  void setEmail(String email) {
    email=email;
    notifyListeners();
  }
  void setName(String name) {
    name=name;
    notifyListeners();
  }
  String getName() {
    return name;
  }
  String getEmail() {
    return email;
  }
  String getPhotoUrl() {
    return photoURL;
  }
}