import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shoppo/models/cart_model.dart';
import 'package:shoppo/models/products.dart';
import 'package:shoppo/provider/counter_provider.dart';
import 'package:shoppo/screens/detail_of_product.dart';
import 'package:shoppo/sotrage/card_info.dart';


class EditProduct extends StatefulWidget {
  final Makeup product;

  EditProduct(this.product);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  late Makeup makeup;
  var favoridProducts = [];
  var shopList = [];
  late bool flag = true;
  late CardModel card;
  String query = '';
 Counter counterController = Get.put(Counter());
  String updatedName=" ";
  String updatedPrice=" ";

  String? orjName;
  String? orjPrice;
String? imagephath;
  var prdNameController = TextEditingController();
  var prdPriceController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  void onListen() => setState(() {});
File? image;

  Future pickImage() async{
    try {
      XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if(file !=null){
        imagephath=file.path;
        setState(() {

        });
      }


      // final image= await _picker.pickImage(source: ImageSource.gallery);
      // if(image ==null) return;
      // final imageTemporary  = File(image.path);
      // setState(() {
      //   this.image = imageTemporary;
      // });
    } on PlatformException catch (e) {
      print("Failed to pick image:  $e");
    }

  }

  @override
  void initState() {
    super.initState();
    card = CardPreferences.getCard();
    orjName= widget.product.name;
    orjPrice= widget.product.price;
    prdNameController.addListener(onListen);
    prdPriceController.addListener(onListen);


  }

  @override
  void dispose() {
    prdNameController.removeListener(onListen);
    prdPriceController.removeListener(onListen);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
counterController.changeName(orjName!);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (imagephath!=null) ?
            Image.file(File(imagephath!)):
            Container(
                height: 180,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: GestureDetector(
                  child: image!= null ?Image.file(image!,width: 100,height: 100,) :Image.network(
                    widget.product.imageLink ?? "",
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailProduct(widget.product)));
                  },
                )),
            SizedBox(height: 8),
            (counterController.productChangedName == null)
                ? Container()
                : Text(

              counterController.productChangedName,
              maxLines: 2,
              // style: TextStyle(
              //     fontFamily: 'avenir', fontWeight: FontWeight.w800),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            if (widget.product.rating != null)
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.product.rating.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('\$${orjPrice}',
                      style: TextStyle(fontSize: 18, fontFamily: 'avenir')),
                  IconButton(onPressed: (){showDialog(
                      context: context,
                      builder: (context)=>SimpleDialog(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('chose image'),
                            IconButton(onPressed: ()=> pickImage(), icon: Icon(Icons.image_search)),
                          ],
                        )
                        ,
                        TextFormField(
                        controller:prdNameController,
                        decoration: InputDecoration(
                          hintText: 'Enter product name',
                          prefixIcon: Icon(Icons.approval),
                          suffixIcon: prdNameController.text.isEmpty
                              ? Container(width: 0)
                              : IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => prdNameController.clear(),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                          onChanged: (value){
                            setState(() {
                              updatedName=value;
                            });
                          },

                      ),
                        TextFormField(
                          controller:prdPriceController,
                          decoration: InputDecoration(
                            hintText: 'Enter product price',
                            prefixIcon: Icon(Icons.monetization_on_outlined),
                            suffixIcon: prdPriceController.text.isEmpty
                                ? Container(width: 0)
                                : IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => prdPriceController.clear(),
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                          onChanged: (value){
                            setState(() {
                              updatedPrice=value;
                            });
                          },
                        ),
                
                        ElevatedButton(onPressed: (){setState(() {
                          orjName=updatedName;
                          orjPrice=updatedPrice;
                          
                          counterController.changeName(updatedName);
                        });
                        Navigator.pop(context);
                        }, child: Text("update"))
                      ],)

                  );}, icon: Icon(Icons.edit))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
