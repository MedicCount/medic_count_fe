import 'dart:io';

class Medicine {
  final String _id;
  String _name;
  File _image;
  late int _counts;

  Medicine(this._id, this._name, this._image);

  void increaseCount(int amount) {
    _counts += amount;
  }

  void decreaseCount(int amount) {
    _counts -= amount;
  }
  
  set setName(String name) {
    _name = name;
  }

  set setImage(File image) {
    _image = image;
  }

  set setCount(int counts) {
    _counts = counts;
  }

  String get getId => _id;
  String get getName => _name;
  File get getImage => _image;
  int get getCount => _counts;
}
