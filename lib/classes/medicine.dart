import 'dart:io';

class Medicine {
  final String _groupId;
  String _name;
  File? _image;
  late int _counts;

  Medicine(this._groupId, this._name, this._image) {
    _counts = 0;
  }

  Medicine.withCount(this._groupId, this._name, this._image, this._counts);

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

  String get getGroupId => _groupId;
  String get getName => _name;
  File get getImage => _image!;
  int get getCount => _counts;

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine.withCount(
      json['groupId'],
      json['name'],
      File(json['_image']),
      json['counts'],
    );
  }
}
