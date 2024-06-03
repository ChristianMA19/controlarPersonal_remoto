import 'package:controlarpersonal_remoto/domain/models/client.dart';
import 'package:controlarpersonal_remoto/ui/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class SignUpPageclient extends StatefulWidget {
  const SignUpPageclient({Key? key}) : super(key: key);

  @override
  State<SignUpPageclient> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPageclient> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserController userController = Get.find();

  _signup(String theName) async {
    try {
      await userController.addClient(Client(
        name: theName,
      ));

      Get.snackbar(
        "Sign Up",
        'Client added successfully',
        icon: const Icon(Icons.person, color: Colors.green),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (err) {
      logError('SignUp error $err');
      Get.snackbar(
        "Sign Up",
        'Failed to add client: $err',
        icon: const Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

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
                      // Puedes agregar cualquier contenido aquí
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
                        margin: const EdgeInsets.only(right: 30, left: 30),
                        child: TextFormField(
                          key: const Key('TextFormFieldSignUpName'),
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
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
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            await _signup(
                              _nameController.text,
                            );
                            // Reset the form after adding a client
                            form.reset();
                          } else {
                            const snackBar = SnackBar(
                              content: Text('Validation failed'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: const Text("Submit"),
                      ),
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
