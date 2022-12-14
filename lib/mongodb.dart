import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_db/constant.dart';
import 'package:mongo_db/model.dart';

class MongoDatabase {
  static var userCollectionName, db;

  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    userCollectionName = db.collection(COLLECTION_NAME);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollectionName.find().toList();
    return arrData;
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = await userCollectionName.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something wrong while inserting data.";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
