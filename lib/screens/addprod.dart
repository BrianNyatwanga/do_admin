import 'dart:io';

import 'package:do_locks_admin/helpers/style.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:do_locks_admin/services/product.dart';
import 'package:provider/provider.dart';
import 'package:do_locks_admin/providers/products_provider.dart';
import '../services/category.dart';
import '../services/brand.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  ProductService productService = ProductService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController quatityController = TextEditingController();
  final priceController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory;
  String _currentBrand;

  List<String> selectedSizes = <String>[];
  List<String> colors = <String>[];

  File _image1;
  // File _image2;
  // File _image3;
  bool isLoading = false;

  @override
  void initState() {
    _getCategories();
    _getBrands();
  }

  List<DropdownMenuItem<String>> getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(categories[i].data()['category']),
                value: categories[i].data()['category']));
      });
    }
    return items;
  }

  List<DropdownMenuItem<String>> getBrandosDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < brands.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(brands[i].data()['brand']),
                value: brands[i].data()['brand']));
      });
    }
    return items;
  }

//BUILD CONTEXT
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            color: black,
          ),
        ),
        title: Text(
          "Add product",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading
              ? CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 120,
                              child: OutlineButton(
                                  borderSide: BorderSide(
                                      color: grey.withOpacity(0.5), width: 2.5),
                                  onPressed: () {
                                    _selectImage(
                                      ImagePicker.pickImage(
                                          source: ImageSource.gallery),
                                    );
                                  },
                                  child: _displayChild1()),
                            ),
                          ),
                        ),
                      ],
                    ),

//COLORS
                    Text('Available Colors'),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
//BLACK
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              if (productProvider.selectedColors
                                  .contains('black')) {
                                productProvider.removeColor('black');
                              } else {
                                productProvider.addColors('black');
                              }
                              setState(() {
                                colors = productProvider.selectedColors;
                              });
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                  color: productProvider.selectedColors
                                          .contains('black')
                                      ? red
                                      : grey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: black,
                                ),
                              ),
                            ),
                          ),
                        ),
//RED
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              if (productProvider.selectedColors
                                  .contains('red')) {
                                productProvider.removeColor('red');
                              } else {
                                productProvider.addColors('red');
                              }
                              setState(() {
                                colors = productProvider.selectedColors;
                              });
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                  color: productProvider.selectedColors
                                          .contains('red')
                                      ? Colors.blue
                                      : grey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: Colors.red[900],
                                ),
                              ),
                            ),
                          ),
                        ),
//BROWN
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              if (productProvider.selectedColors
                                  .contains('brown')) {
                                productProvider.removeColor('brown');
                              } else {
                                productProvider.addColors('brown');
                              }
                              setState(() {
                                colors = productProvider.selectedColors;
                              });
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                  color: productProvider.selectedColors
                                          .contains('brown')
                                      ? red
                                      : grey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: Colors.brown[900],
                                ),
                              ),
                            ),
                          ),
                        ),
//BLUE
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              if (productProvider.selectedColors
                                  .contains('blue')) {
                                productProvider.removeColor('blue');
                              } else {
                                productProvider.addColors('blue');
                              }
                              setState(() {
                                colors = productProvider.selectedColors;
                              });
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                  color: productProvider.selectedColors
                                          .contains('blue')
                                      ? red
                                      : grey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue[900],
                                ),
                              ),
                            ),
                          ),
                        ),
//PINK
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              if (productProvider.selectedColors
                                  .contains('pink')) {
                                productProvider.removeColor('pink');
                              } else {
                                productProvider.addColors('pink');
                              }
                              setState(() {
                                colors = productProvider.selectedColors;
                              });
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                  color: productProvider.selectedColors
                                          .contains('pink')
                                      ? red
                                      : grey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: Colors.pink[100],
                                ),
                              ),
                            ),
                          ),
                        ),
//WHITE
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              if (productProvider.selectedColors
                                  .contains('white')) {
                                productProvider.removeColor('white');
                              } else {
                                productProvider.addColors('white');
                              }
                              setState(() {
                                colors = productProvider.selectedColors;
                              });
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                  color: productProvider.selectedColors
                                          .contains('white')
                                      ? red
                                      : grey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
//LENGTH
                    Text(
                      'Length',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(children: <Widget>[
                      Checkbox(
                          value: selectedSizes.contains('Ear'),
                          onChanged: (value) => changeSelectedSize('Ear')),
                      Text('Ear'),
                      Checkbox(
                          value: selectedSizes.contains('Shoulder'),
                          onChanged: (value) => changeSelectedSize('Shoulder')),
                      Text('Shoulder'),
                      Checkbox(
                          value: selectedSizes.contains('Bra-Strap'),
                          onChanged: (value) =>
                              changeSelectedSize('Bra-Strap')),
                      Text('Bra-strap'),
                    ]),
                    Row(
                      children: [
                        Checkbox(
                            value: selectedSizes.contains('Mid-Back'),
                            onChanged: (value) =>
                                changeSelectedSize('Mid-Back')),
                        Text('Mid-Back'),
                        Checkbox(
                            value: selectedSizes.contains('Waist'),
                            onChanged: (value) => changeSelectedSize('Waist')),
                        Text('Waist'),
                        Checkbox(
                            value: selectedSizes.contains('Tailbone'),
                            onChanged: (value) =>
                                changeSelectedSize('Tailbone')),
                        Text('Tailbone'),
                        Checkbox(
                            value: selectedSizes.contains('Tailbone'),
                            onChanged: (value) =>
                                changeSelectedSize('Tailbone')),
                        Text('Tailbone'),
                      ],
                    ),
//PRODUCT NAME
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: productNameController,
                        decoration: InputDecoration(hintText: 'Product name'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'You must enter the product name';
                          } else if (value.length > 10) {
                            return 'Product name cant have more than 10 letters';
                          }
                          return null;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Enter Product name with 10 chars max',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: red, fontSize: 12),
                      ),
                    ),
//DESCRIPTION TODO: add discription

//CATEGORY DROPDOWN
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Category: ',
                            style: TextStyle(color: red),
                          ),
                        ),
                        DropdownButton(
                          items: categoriesDropDown,
                          onChanged: changeSelectedCategory,
                          value: _currentCategory,
                        ),
                        //BRAND DROPDOWN
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Brand: ',
                            style: TextStyle(color: red),
                          ),
                        ),
                        DropdownButton(
                          items: brandsDropDown,
                          onChanged: changeSelectedBrand,
                          value: _currentBrand,
                        ),
                      ],
                    ),

//QUANTITY
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: quatityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Quantity',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter the quantity';
                          }
                          return null;
                        },
                      ),
                    ),
//PRICE
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Price',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter the price';
                          }
                          return null;
                        },
                      ),
                    ),
//ADD BUTTON
                    FlatButton(
                      color: red,
                      textColor: white,
                      child: Text('add product'),
                      onPressed: () {
                        validateAndUpload();
                      },
                    )
                  ],
                ),
        ),
      ),
    );
  }

//METHODS
  _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    print(data.length);
    setState(() {
      categories = data;
      categoriesDropDown = getCategoriesDropdown();
      _currentCategory = categories[0].data()['category'];
    });
  }

  _getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrands();
    print(data.length);
    setState(() {
      brands = data;
      brandsDropDown = getBrandosDropDown();
      _currentBrand = brands[0].data()['brand'];
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() => _currentCategory = selectedBrand);
  }

  void changeSelectedSize(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
      });
    } else {
      setState(() {
        selectedSizes.insert(0, size);
      });
    }
  }

  void _selectImage(Future<File> pickImage) async {
    File tempImg = await pickImage;
    setState(() => _image1 = tempImg);
  }

//DISPLAY IMAGE
  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  // Widget _displayChild3() {
  //   if (_image3 == null) {
  //     return Padding(
  //       padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
  //       child: new Icon(
  //         Icons.add,
  //         color: grey,
  //       ),
  //     );
  //   } else {
  //     return Image.file(
  //       _image3,
  //       fit: BoxFit.fill,
  //       width: double.infinity,
  //     );
  //   }
  // }

  void validateAndUpload() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      if (_image1 != null) {
        if (selectedSizes.isNotEmpty) {
          String imageUrl1;

          final FirebaseStorage storage = FirebaseStorage.instance;
          final String picture1 =
              "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task1 =
              storage.ref().child(picture1).putFile(_image1);

          StorageTaskSnapshot snapshot1 =
              await task1.onComplete.then((snapshot) => snapshot);

          task1.onComplete.then((snapshot) async {
            imageUrl1 = await snapshot1.ref.getDownloadURL();
            // imageUrl2 = await snapshot2.ref.getDownloadURL();
            // imageUrl3 = await snapshot3.ref.getDownloadURL();
            // //getting the url of the images
            // List<String> imageList = [imageUrl1, imageUrl2, imageUrl3];

            productService.uploadProduct({
              "name": productNameController.text,
              "price": double.parse(priceController.text),
              "sizes": selectedSizes,
              "colors": colors,
              "picture": imageUrl1,
              "quantity": int.parse(quatityController.text),
              "brand": _currentBrand,
              "category": _currentCategory,
            });
            _formKey.currentState.reset();
            setState(() => isLoading = false);
            Navigator.pop(context);
          });
        } else {
          setState(() => isLoading = false);
        }
      } else {
        setState(() => isLoading = false);

//        Fluttertoast.showToast(msg: 'all the images must be provided');
      }
    }
  }
}
