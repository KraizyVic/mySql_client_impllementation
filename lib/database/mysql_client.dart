
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class MysqlClient{
  Future<MySQLConnection> mysqlConnection() async{
    final connection = await MySQLConnection.createConnection(
      host: "xxxx.xxxx.xxxx.xxxx",
      port: 3306,
      userName: "root",
      password: "xxxxxxxxxx",
      databaseName: "YOUR SQL DATABASE NAME",
    );
    await connection.connect();
    return connection;
  }
  Future <List<String>> mysqlClientConnection() async{
    final conn = await mysqlConnection();
    var result = await conn.execute("SELECT name FROM names");
    List<String> names =[];

    for (final row in result.rows) {
      Map<String,dynamic> data = row.assoc();
      names.add(data["name"]);
    }
    await conn.close();
    return names;
  }

  /*-----ADD RECORD TO DATABASE-----*/

  void uploadData(String data, BuildContext context) async {
    // Connect to the MySQL database
    var conn = await mysqlConnection();
    try {
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

  /*----- DELETE RECORDS-----*/

  void deleteData(String data, BuildContext context) async {
    // Connect to the MySQL database
    var conn = await mysqlConnection();
    try {
      // Execute an DELETE query
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