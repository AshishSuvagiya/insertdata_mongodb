import 'package:flutter/material.dart';
import 'package:mongo_db/model.dart';
import 'package:mongo_db/mongodb.dart';

class MongoDbDisplay extends StatelessWidget {
  const MongoDbDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MongoDb_Display",
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: MongoDatabase.getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return displayCard(
                    MongoDbModel.fromJson(data[index]),
                    index,
                  );
                },
              );
            } else {
              return const Text("No data found");
            }
          },
        ),
      ),
    );
  }

  Widget displayCard(MongoDbModel data, int index) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$index"),
          Text("${data.firstName}"),
          Text("${data.lastName}"),
          Text("${data.address}"),
        ],
      ),
    );
  }
}
