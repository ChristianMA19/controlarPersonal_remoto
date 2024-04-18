import 'package:controlarpersonal_remoto/ui/pages/authentication/signup.dart';
import 'package:controlarpersonal_remoto/ui/pages/content/admin_client.dart';
import 'package:controlarpersonal_remoto/ui/pages/content/admin_sup.dart';
import 'package:controlarpersonal_remoto/ui/pages/controller/formpage.dart';
import 'package:controlarpersonal_remoto/ui/pages/controller/suppage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../authentication/login.dart';

class HomePageCord extends StatelessWidget {
  const HomePageCord(
      {Key? key, required this.loggedEmail, required this.loggedPassword})
      : super(key: key);
  final String loggedEmail;
  final String loggedPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text("Home"),
          actions: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Get.to(() => const adminSup(key: Key('adminSup')));
                    },
                    child: const Text("Admin Supports")),
                const SizedBox(width: 10),
                TextButton(
                    onPressed: () {
                      Get.to(() => const adminClient(key: Key('adminClient')));
                    },
                    child: const Text("Admin Clients")),
                IconButton(
                    key: const Key('ButtonHomeLogOff'),
                    onPressed: () {
                      Get.off(() => LoginScreen(
                            key: const Key('LoginScreen'),
                            email: loggedEmail,
                            password: loggedPassword,
                          ));
                    },
                    icon: const Icon(Icons.logout)),
                const SizedBox(width: 10),
              ],
            )
          ],
        ),
        floatingActionButton: Icons.add == null
            ? null
            : FloatingActionButton(
                key: const Key('ButtonHomeAdd'),
                onPressed: () {
                  Get.to(() => const SignUpPage(
                        key: Key('SignUpPage'),
                      ));
                },
                child: const Icon(Icons.add),
              ),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 200, right: 200, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Forms sent by support",
                  style: TextStyle(fontSize: 24)),
              const SizedBox(
                  height: 20), // Espacio entre el texto y el ListView
              Expanded(
                child: _getXlistView(),
              ),
            ],
          ),
        ));
  }

  Widget _getXlistView() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Define el color del borde
        borderRadius: BorderRadius.circular(10), // Define la forma del borde
      ),
      child: ListView.builder(
        itemCount: 20, // Número de elementos en la lista
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('form ID: $index'),
                      const SizedBox(width: 20),
                      Text('Client: $index'),
                      const SizedBox(width: 20),
                      Text('Support: $index'),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => EditarDatosPageForm(
                      key: const Key('EditarDatosPageForm'),
                      id: '$index',
                      descripcion: '$index',
                      cliente: '$index',
                      hora: '$index',
                      duracion: '$index',
                      support: '$index',
                    ));
                  },
                  child: Text('Editar'),
                ),
              ],
          ),
          onTap: () {
              Get.to(() => EditarDatosPageForm(
                      key: const Key('EditarDatosPageForm'),
                      id: '$index',
                      descripcion: '$index',
                      cliente: '$index',
                      hora: '$index',
                      duracion: '$index',
                      support: '$index',
                    ));
            },
          );
        },
      ),
    );
  }
}
