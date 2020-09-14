import 'package:do_locks_admin/helpers/loading.dart';
import 'package:do_locks_admin/helpers/style.dart';
import 'package:do_locks_admin/db/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
//Text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: grey[300],
            appBar: AppBar(
              backgroundColor: grey[800],
              elevation: 0,
              title: Text("DoLocks Admin"),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    label: Text(
                      'Register',
                      style: TextStyle(color: white),
                    ),
                    icon: Icon(
                      Icons.person,
                      color: white,
                    ))
              ],
            ),
            body: Container(
              padding: EdgeInsets.fromLTRB(
                20.0,
                10,
                20.0,
                0.0,
              ),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an Email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: (val) => val.length < 6
                            ? 'Enter password with 6+ chars '
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                //todo display the right error
                                error = 'something went wrong';
                              });
                            }
                          }
                        },
                        color: grey[800],
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: white),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(error, style: TextStyle(color: red, fontSize: 14.0)),
                    ],
                  )),
            ),
          );
  }
}
