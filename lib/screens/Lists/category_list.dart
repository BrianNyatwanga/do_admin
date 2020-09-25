import 'package:do_locks_admin/helpers/style.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
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
      body: Container(
        height: 400,
        child: ListView(
            //children: getCategoryContainer(),
            ),
      ),
    );
  }

  Widget getCategoryContainer(String categoryName) {
    return new Container(
      margin: EdgeInsets.only(right: 10, left: 10, bottom: 20),
      height: 180,
      width: 140,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          new BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Text(
            categoryName, /*style: titileStyleLighterBlack*/
          ),
          Container(
            padding: EdgeInsets.only(top: 30),
            height: 100,
            width: 70,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              //child:  jobCatToIcon[categoryName],
              elevation: 10,
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
