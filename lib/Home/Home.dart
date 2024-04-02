import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);
final CollectionReference category =FirebaseFirestore.instance.collection('gs://abbas-16307.appspot.com');
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    var size = MediaQuery.of(context).size;
    final double itemHeight = mheight * 0.2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Mobile models'),
      ),
      body: StreamBuilder(
        stream: category.snapshots(),
        builder:(context,AsyncSnapshot snapshot) {
          if (snapshot.hasData){
           return   GridView.count(
               childAspectRatio: (itemWidth / itemHeight),
               padding: EdgeInsets.only(
                   top: mheight * 0.026,
                   left: mwidth * 0.02,
                   right: mwidth * 0.015),
               crossAxisCount: 2,

               mainAxisSpacing: mwidth * 0.008,
               shrinkWrap: true,
               children: List.generate(
                 snapshot.data!.docs.length,
                 growable: false,
                     (index) {


                   return Card(elevation: 1.2,shape: RoundedRectangleBorder(   borderRadius: BorderRadius.circular(10),),
                       child: Container(
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: Color(0xff95BDC6).withOpacity(0.22)),
                         child: Column(
                           children: [



                           ],
                         ),
                       ),

                   );
                 },
               ));
          }
          return Text('No data found');
        },

      )
    );
  }
}
