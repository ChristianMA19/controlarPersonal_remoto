import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Create account for support with email and password"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (kIsWeb)
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      Image.asset(
                        'lib/assets/images/support.png', // Ruta de la imagen
                      ),
                      // You can add any content you want to show here
                    ],
                  ),
                ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Enter account information',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 200,
                      ),
                      Container(
                         margin: const EdgeInsets.only(right: 30,left: 30),
                        child:TextFormField(
                        key: const Key('TextFormFieldSignUpName'),
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                      )),
                      Container(
                        margin: const EdgeInsets.only(right: 30,left: 30),
                        child:TextFormField(
                        key: const Key('TextFormFieldSignUpEmail'),
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter email";
                          } else if (!value.contains('@')) {
                            return "Enter valid email address";
                          }
                          return null;
                        },
                      ),
                      ),
                      
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 30,left: 30),
                        child:TextFormField(
                        key: const Key('TextFormFieldSignUpPassword'),
                        controller: _passwordController,
                        decoration:
                            const InputDecoration(labelText: "Password"),
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter password";
                          } else if (value.length < 6) {
                            return "Password should have at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      ),
                      
                      const SizedBox(
                        height: 20,
                      ),
                      OutlinedButton(
                          key: const Key('ButtonSignUpSubmit'),
                          onPressed: () {
                            // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                            FocusScope.of(context).requestFocus(FocusNode());
                            final form = _formKey.currentState;
                            form!.save();
                            if (form.validate()) {
                              Get.back();
                            } else {
                              const snackBar = SnackBar(
                                content: Text('Validation nok'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                         }
                          },
                          child: const Text("Submit")),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

