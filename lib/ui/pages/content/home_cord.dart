import 'package:controlarpersonal_remoto/ui/pages/authentication/signup.dart';
import 'package:controlarpersonal_remoto/ui/pages/content/admin_client.dart';
import 'package:controlarpersonal_remoto/ui/pages/content/admin_sup.dart';
import 'package:controlarpersonal_remoto/ui/pages/content/listus_form.dart';
import 'package:controlarpersonal_remoto/ui/pages/content/formpage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../authentication/login.dart';

class HomePageCord extends StatefulWidget {
  HomePageCord({
    Key? key,
    required this.loggedEmail,
    required this.loggedPassword,
  }) : super(key: key);

  final String loggedEmail;
  final String loggedPassword;

  @override
  _HomePageCordState createState() => _HomePageCordState();
}

class _HomePageCordState extends State<HomePageCord> {
  String _selectedFilter = ''; // Initialize with empty string

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
                  Get.to(() => const listusform(key: Key('listusform')));
                },
                child: const Text("US List"),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () {
                  Get.to(() => const adminSup(key: Key('adminSup')));
                },
                child: const Text("Admin Supports"),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () {
                  Get.to(() => const adminClient(key: Key('adminClient')));
                },
                child: const Text("Admin Clients"),
              ),
              IconButton(
                key: const Key('ButtonHomeLogOff'),
                onPressed: () {
                  Get.off(() => LoginScreen(
                        key: const Key('LoginScreen'),
                      ));
                },
                icon: const Icon(Icons.logout),
              ),
              const SizedBox(width: 10),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('ButtonHomeAdd'),
        onPressed: () {
          Get.to(() => const SignUpPage(
                key: Key('SignUpPage'),
              ));
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 200, right: 200, top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Forms sent by support",
              style: TextStyle(fontSize: 24),
            ),
            Row(
              children: [
                const Text("Filter: "),
                DropdownButton<String>(
                  value: _selectedFilter,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedFilter = newValue!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: '',
                      child: const Text('All'),
                    ),
                    ...List.generate(
                      20,
                      (index) => DropdownMenuItem(
                        value: 'cli_$index',
                        child: Text('cli_$index'),
                      ),
                    ),
                    ...List.generate(
                      20,
                      (index) => DropdownMenuItem(
                        value: 'sup_$index',
                        child: Text('sup_$index'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _getXlistView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getXlistView() {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        final String id = _selectedFilter.isNotEmpty ? _selectedFilter : '';
        final bool shouldShow =
            id.isEmpty || id == 'cli_$index' || id == 'sup_$index';
        if (!shouldShow) {
          return SizedBox.shrink();
        }
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
                    const SizedBox(width: 20),
                    Text('Date: $index'),
                    const SizedBox(width: 20),
                    Text('Evaluation: $index'),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  _showEvaluationDialog(context, index);
                },
                child: const Text('Evaluate'),
              ),
            ],
          ),
        );
      },
    ),
  );
}

void _showEvaluationDialog(BuildContext context, int index) {
  double _rating = 0;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Evaluate Form ID: $index'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text('ID: $index', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Descripcion: $index', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Cliente: $index', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Hora: $index', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Duracion: $index', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 40,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                _rating = rating;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}

}