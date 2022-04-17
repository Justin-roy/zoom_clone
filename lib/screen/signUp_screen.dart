import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zoom_clone/widget/customButton.dart';
import 'package:zoom_clone/widget/customTextField.dart';

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
              CustomButton(
                color: const Color(0xff0165ff),
                height: 50,
                width: MediaQuery.of(context).size.width,
                text: 'Register',
                onpress: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, '/home');
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
