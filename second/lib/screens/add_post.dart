import 'package:dio/dio.dart';

import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:second/screens/profile_id.dart';
import 'package:second/screens/profile_screen.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:multi_image_picker/multi_image_picker.dart';



class AddPost extends StatefulWidget {

  static const id ='add_post';
  @override
  State<StatefulWidget> createState() {
    return _AddPost();
  }

}
class _AddPost extends  State<AddPost>{
//   Future <List<ProfileId>> mu ;
//   var res;
//
//
  List<ProfileId> _product;
  dynamic inr ;
   void initState(){
     super.initState();
     this.fetchProfile();
   }


  Future<dynamic> fetchProfile() async{
      http.get('https://my-volition.firebaseio.com/profile.json').then((http.Response response){
        final List<ProfileId> fetchProduct = [];
       final Map<String , dynamic > productListData = json.decode(response.body);
       print(productListData);
       productListData.forEach((String hh , dynamic ll){
         inr = ll;
       });
//       productListData.forEach((String produnId,Map<String,dynamic> innerMap ){
//         final ProfileId product =ProfileId(
//           id:  produnId,
//           name: innerMap["Nname"],
//           family: innerMap["Nfamily"],
//           bio: innerMap["Nbio"],
//           email: innerMap["Nemail"],
//         );
//         print('product is :$product');
//         fetchProduct.add(product);
//       });
        _product = fetchProduct;
     });


//     Dio dio = new Dio(); http.Response
////     res = await http.get('https://my-volition.firebaseio.com/profile.json');
////     try{
////       Map<String , dynamic> body = jsonDecode(res.body);
////
////       List<ProfileId> posts = body
////           .map(
////             (dynamic item) => ProfileId.fromJson(item),
////       )
////           .toList();
////
////       return posts;
////
////     }
////     catch (e){
////       print('erros is:$e');
////     }

  }






  Widget buildGridView() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30,horizontal: 30),
      child: GridView.count(
        mainAxisSpacing: 20,
        crossAxisCount: 1,
        scrollDirection: Axis.vertical,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 100,
            height: 200,
          );
        }),
      ),
    );
  }


  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),

      );
    } on Exception catch (e) {
      print('errrrooooooooooooooooor');
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }


  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';

  Widget curS ;
  int curP =1;



  @override
  Widget build(BuildContext context) {

  Size size = MediaQuery.of(context).size;
  return Scaffold(
    bottomNavigationBar: BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                const Color(0xFF3C256D),
//                const Color(0xFF9DD7CA),
                const Color(0xFFEEB6B9),
              ],
              begin: Alignment.topLeft,
              end:Alignment.bottomRight,
              tileMode: TileMode.clamp),
        ),

        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,

          children: <Widget>[
            Row(
              children: <Widget>[
                MaterialButton(
                  minWidth: 40,
                  onPressed: (){
                    Navigator.pushNamed(context, profileScreen.id);
                    setState(() {
                      curS = profileScreen();
                      curP = 0;
                    });
                  },
                  child:   Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.home,
                          color: curP == 0 ? Colors.orange : Colors.grey),
                      Text('profile', style: TextStyle(
                          color: curP == 0 ? Colors.orange : Colors.grey),)
                    ],
                  ) ,
                ),

              ],
            ),
            MaterialButton(
              minWidth: 40,
              onPressed: (){
                Navigator.pushNamed(context, AddPost.id);
                setState(() {
                  curS = AddPost();
                  curP =1;
                });
              },
              child:   Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add_circle_outline,
                      color: curP == 1 ? Colors.red[300] : Colors.grey),
                  Text('add post', style: TextStyle(
                      color: curP == 1 ? Colors.red[300] : Colors.grey),)
                ],
              ) ,
            ),
          ],
        ),
      ),
    ),


  body: Padding(
    padding: const EdgeInsets.only(top:25.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        
//        Center(child: Text('Error: $_error')),
        RaisedButton(
          onPressed: loadAssets,
          color:Colors.orange,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Pick images',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
//ListView.builder(
//    itemCount: data == null ? 0 : data.length,
//  itemBuilder: (BuildContext context , int index){
//      return Container(
//        child: Center(
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            children: <Widget>[
//              Card(
//                child: Container(
//                  child: Text(data[index]),
//                  padding: EdgeInsets.all(20),
//                ),
//              )
//            ],
//          ),
//        ),
//      );
//  },
//
//),
//        FutureBuilder(
//          future: fetchProfile(),
//          builder: (BuildContext context, AsyncSnapshot<List<ProfileId>> snapshot ){
//          if(snapshot.hasData ){
//           List<ProfileId> pro = snapshot.data;
//
//           return ListView(
//             children: pro.map((ProfileId proo) => ListTile(
//               title: Text(proo.name),
//               subtitle: Text(proo.id.toString())
//               ,)).toList(),
//           );
//          }  else if (snapshot.hasError) {
//            return Text('errrrrrooooooooooor');
//
//          }
//            return Center(child: CircularProgressIndicator());
//          },
//        ),
      FlatButton(
       child: Column(
         children: <Widget>[
           Text('update'),
           Container(
             color: Colors.purpleAccent,
             width: size.width,
             child: Text('$inr',style: TextStyle(fontSize: 15),),
           ),
         ],
       ),
        onPressed:fetchProfile,
      ),





        Expanded(
          child: buildGridView(),
        )
      ],
    ),
  ),
  );

  }



  }
