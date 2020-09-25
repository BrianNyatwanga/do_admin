import 'package:do_locks_admin/services/brand.dart';
import 'package:do_locks_admin/helpers/style.dart';
import 'package:do_locks_admin/screens/Lists/brand_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Brands extends StatefulWidget {
  @override
  _BrandsState createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey[300],
      appBar: AppBar(
        backgroundColor: grey[800],
        elevation: 0,
        title: Text("Brands"),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {},
              label: Text(
                'add',
                style: TextStyle(color: white),
              ),
              icon: Icon(
                Icons.add,
                color: white,
              ))
        ],
      ),
      body: BrandList(),
    );
  }
}
