import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zoom_clone/widget/customButton.dart';
import 'package:zoom_clone/widget/customTextField.dart';
import 'package:zoom_clone/widget/showSnackBar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  // sign Up
  final FirebaseAuth _auth = FirebaseAuth.instance;
  _signUp(String email, String password) async {
    UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (cred.user != null) {
      setState(() {
        _isLoading = false;
      });
      return true;
    }
    setState(() {
      _isLoading = false;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black54,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SvgPicture.asset('assets/images/signUP_bg.svg'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'SignUp',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
              CustomTextField(
                hintText: 'Full Name',
                icon: const Icon(Icons.person),
                controller: _name,
                message: 'Please enter name',
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
                      text: 'Register',
                      onpress: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          bool cred =
                              await _signUp(_email.text, _password.text);
                          if (cred) {
                            Navigator.pushNamed(context, '/home');
                          } else {
                            showSnackBar(context, 'Register Failed !!');
                          }
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
