import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class faceLogin extends StatelessWidget {
  faceLogin({super.key});
  bool _isloggedIn = false;
  Map _userObj = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DBestech')),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: _isloggedIn == true
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_userObj["name"]),
                  Text(_userObj["email"]),
                  TextButton(
                      onPressed: () {
                        FacebookAuth.instance.logOut().then((value) {
                          setStat() {
                            _isloggedIn = false;
                            _userObj = {};
                          }
                        });
                      },
                      child: Text('LogOut'))
                ],
              )
            : Center(
                child: ElevatedButton(
                    onPressed: () {
                      FacebookAuth.instance
                          .login(permissions: ["public_profile", "email"]).then(
                              (value) {
                        FacebookAuth.instance
                            .getUserData()
                            .then((userData) async {
                          setState() {
                            _isloggedIn = true;
                            _userObj = userData;
                          }
                        });
                      });
                    },
                    child: Text('Login with Facebook')),
              ),
      ),
    );
  }
}
