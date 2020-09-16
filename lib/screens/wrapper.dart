//LISTENS TO AUTH CHANGES
import 'package:do_locks_admin/models/user.dart';
import 'package:do_locks_admin/screens/admin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

//return either home or Auth
    if (user == null) {
      return Authenticate();
    } else {
      return Admin();
    }
  }
}
