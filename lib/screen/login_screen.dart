import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zoom_clone/resource/auth_methods.dart';
import 'package:zoom_clone/widget/customButton.dart';
import 'package:zoom_clone/widget/customTextField.dart';
import 'package:zoom_clone/widget/showSnackBar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //login
  final FirebaseAuth _auth = FirebaseAuth.instance;
  _loginUser(String _email, String _password) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      if (cred.user != null) {
        await AuthMethods().uploadUserDetails(username: 'dummy', email: _email);
        setState(() {
          _isLoading = false;
        });
        return true;
      }
      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, e.message.toString());
    }
    return false;
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SvgPicture.asset('assets/images/signIn_bg.svg'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
              CustomTextField(
                hintText: 'Email',
                icon: const Icon(Icons.email),
                controller: _email,
                message: 'Please enter email',
              ),
              CustomTextField(
                hintText: 'Password',
                icon: const Icon(Icons.lock),
                controller: _password,
                message: 'Please enter password',
              ),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomButton(
                      color: const Color(0xff0165ff),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      text: 'Login',
                      onpress: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          bool cred =
                              await _loginUser(_email.text, _password.text);
                          if (cred) {
                            Navigator.pushNamed(context, '/home');
                          } else {
                            showSnackBar(context, 'Login Failed!!');
                          }
                        }
                      },
                    ),
              const Center(
                child: Text(
                  'Or, login with...',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    color: Colors.white,
                    height: 50,
                    width: 110,
                    text: 'Google',
                    isLogo: true,
                    onpress: () async {
                      bool cred = await AuthMethods().signInWithGoogle(context);
                      if (cred) {
                        Navigator.pushNamed(context, '/home');
                      } else {
                        showSnackBar(context, 'Login Failed!!');
                      }
                    },
                  ),
                  CustomButton(
                    color: Colors.white,
                    height: 50,
                    width: 110,
                    text: 'Facebook',
                    isLogo: true,
                    onpress: () async {
                      bool cred = await AuthMethods().signInWithFacebook();
                      if (cred) {
                        Navigator.pushNamed(context, '/home');
                      } else {
                        showSnackBar(context, 'Login Failed!!');
                      }
                    },
                    icon: 'assets/images/facebook_svg.svg',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Create New Account?'),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      ' Register',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
