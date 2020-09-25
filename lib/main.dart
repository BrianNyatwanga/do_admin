import 'package:do_locks_admin/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:do_locks_admin/providers/app_states.dart';
import 'package:do_locks_admin/providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'services/auth.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: AppState()),
      ChangeNotifierProvider.value(value: ProductProvider()),
      StreamProvider<UserModel>.value(value: AuthService().user),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    ),
  ));
}
