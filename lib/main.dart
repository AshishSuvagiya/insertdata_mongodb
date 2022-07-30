import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mongo_db/model.dart';
import 'mongodb.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Insert Data"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
              left: 15,
              top: 8,
              bottom: 8,
            ),
            child: TextField(
              controller: firstNameController,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                label: const Text("FirstName"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
              left: 15,
              top: 8,
              bottom: 8,
            ),
            child: TextField(
              controller: secondNameController,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                label: const Text("SecondName"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
              left: 15,
              top: 8,
              bottom: 8,
            ),
            child: TextField(
              controller: addressController,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                label: const Text("Address"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  fakeData();
                },
                child: const Text(
                  "Generate Data",
                ),
              ),
              const SizedBox(
                width: 103,
              ),
              ElevatedButton(
                onPressed: () {
                  if (firstNameController.text.isNotEmpty &&
                      secondNameController.text.isNotEmpty &&
                      addressController.text.isNotEmpty) {
                    insertData(
                      firstNameController.text,
                      secondNameController.text,
                      addressController.text,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("PLEASE ENTER ANY INPUT"),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Insert Data",
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> insertData(String fName, String lName, String address) async {
    // var _id = Mongodb.ObjectId;
    final data =
        MongoDbModel(firstName: fName, lastName: lName, address: address);
    await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("DATA UPLOADED IN MONGODB.COM"),
      ),
    );
    clearAll();
  }

  void clearAll() {
    firstNameController.text = "";
    secondNameController.text = "";
    addressController.text = "";
  }

  void fakeData() {
    setState(
      () {
        firstNameController.text = faker.person.firstName();
        secondNameController.text = faker.person.lastName();
        addressController.text = faker.address.streetName() +
            ", " +
            faker.address.streetAddress() +
            ", " +
            faker.address.country();
      },
    );
  }
}
