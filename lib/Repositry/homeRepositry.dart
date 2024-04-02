
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Home/home_model.dart';

class HomeRepository extends GetxController{
  static HomeRepository get instance =>Get.find();

  //variables
final _db =FirebaseFirestore.instance;

//get all
 Future<List<HomeModel>>getAllCategories()async
 {
   try{
     final snapshot = await _db.collection('Category').get();
     final list = snapshot.docs.map((document) => HomeModel.fromSnapshot(document)).toList();
     return list;  
   }
       on FirebaseException catch (e){
     throw 'Something went wrong';
       }on PlatformException catch (e){
     throw 'Something went wrong';
   }catch (e){
     throw 'Something went wrong';
   }

 }

}