import 'package:cloud_firestore/cloud_firestore.dart';

class HomeModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isfeatured;

  HomeModel({
    required this.id,
    required this.image,
    required this.name,
    this.parentId ='',
    required this.isfeatured
});
  static HomeModel empty()=>HomeModel(id: '', image: '', name:'', isfeatured: false);


  Map<String,dynamic>toJason(){
    return{
      'Name':name,
      'Image':image,
      'Id':id,
      'Parentid':parentId,
      'IsFeatured':isfeatured
    };
  }
  factory HomeModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null){
      final data = document.data()!;


      return HomeModel(
          id: document.id,
          image: data['Image'] ??'',
          name: data['Name']??'',
          isfeatured: data['IsFeatured']??false
      );

    }
    else{
      return HomeModel.empty();
    }
  }


}