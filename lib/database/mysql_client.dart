
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class MysqlClient{
  Future <List<String>> mysqlClientConnection() async{
    final conn = await MySQLConnection.createConnection(
      host: "172.168.35.107",
      port: 3306,
      userName: "root",
      password: "Exralabs@20",
      databaseName: "mysqlbbse", // optional
    );

// actually connect to database
    await conn.connect();

    var result = await conn.execute("SELECT name FROM names");
    List<String> names =[];

    for (final row in result.rows) {
      Map<String,dynamic> data = row.assoc();
      names.add(data["name"]);
    }
    await conn.close();
    return names;
  }

  void uploadData(String data, BuildContext context) async {
    // Connect to the MySQL database
    var conn = await MySQLConnection.createConnection(
      host: "172.168.35.107",
      port: 3306,
      userName: "root",
      password: "Exralabs@20",
      databaseName: "mysqlbbse", // optional
    );
    print(data);
    try {
      await conn.connect();
      // Execute an INSERT query
      final result = await conn.execute(
        "INSERT INTO names(name) VALUES (:name)",
        {
          "name": data,
        },
      );

      // Check if the query was successful
      if (result.affectedRows.toInt() > 0) {
        print("Data inserted successfully!");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$data Inserted successfully"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 5),
          ),
        );
      } else {
        print("Failed to insert data.");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      // Close the connection
      await conn.close();
    }
  }
  void deleteData(String data, BuildContext context) async {
    // Connect to the MySQL database
    var conn = await MySQLConnection.createConnection(
      host: "172.168.35.107",
      port: 3306,
      userName: "root",
      password: "Exralabs@20",
      databaseName: "mysqlbbse", // optional
    );
    try {
      await conn.connect();
      // Execute an INSERT query
      final result = await conn.execute(
        "DELETE FROM names WHERE name = :name",
        {
          "name": data,
        },
      );
      // Check if the query was successful
      if (result.affectedRows.toInt() > 0) {
        print("Data deleted successfully!");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$data deleted successfully"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          ),
        );
      } else {
        print("Failed to delete data.");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      // Close the connection
      await conn.close();
    }
  }
}