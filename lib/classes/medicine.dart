import 'dart:io';

class Medicine {
  late String _mid;
  final String _groupId;
  String _name;
  File? _image;
  late int _counts;
  List<dynamic> labels = [];

  Medicine(this._mid, this._groupId, this._name, this._image) {
    _counts = 0;
  }

  Medicine.withCount(this._mid, this._groupId, this._name, this._image, this._counts);

  Medicine.withCountwithLabel(this._groupId, this._name, this._image, this._counts, this.labels);

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
  List<dynamic> get getLabels => labels;
  String get getMid => _mid;

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine.withCountwithLabel(
      json['groupId'],
      json['name'],
      File(json['_image']),
      json['counts'],
      json['labels'],
    );
  }
}
