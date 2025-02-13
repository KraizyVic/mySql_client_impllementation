import 'package:django1/utilities/buttons.dart';
import 'package:flutter/material.dart';

import '../database/mysql_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future <List<String>> getNames;
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _textFieldNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    getNames = MysqlClient().mysqlClientConnection();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MySql Connect"),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
          future: getNames,
          builder: (context,snapshot){
            if(snapshot.hasData){
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: (){
                            setState(() {
                              snapshot.data!.clear();
                              getNames = MysqlClient().mysqlClientConnection();
                            });
                          },
                          icon: Icon(Icons.restart_alt_sharp),
                        ),
                        TextField(
                          controller: _textEditingController,
                          focusNode: _textFieldNode,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                             // borderSide: BorderSide(width: 10.0, color: Colors.blueAccent),
                            ),
                            filled: true,
                            //suffix: IconButton(onPressed: (){}, icon: Icon(Icons.check)),
                            hintText: "Enter name here",
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              onPressed: ()=>_textEditingController.clear(),
                              child: Text("Clear"),
                            ),
                            SizedBox(width: 20,),
                            NamedButton(
                              voidCallback: (){
                                if(_textEditingController.text.length > 0){
                                  MysqlClient().uploadData(_textEditingController.text,context);
                                  snapshot.data!.clear();
                                  Future.delayed(Duration(seconds: 1),(){
                                    setState(() {
                                      getNames = MysqlClient().mysqlClientConnection();
                                    });
                                  }
                                  );
                                  _textEditingController.clear();
                                  _textFieldNode.unfocus();
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Please enter value"),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 5),
                                    ),
                                  );
                                }
                              },
                              buttonName:"Upload",
                              color: Colors.pink,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                            return ListTile(
                              onTap: (){},
                              title: Text(snapshot.data![index]),
                              leading: Icon(Icons.person),
                              trailing: IconButton(
                                  onPressed: (){
                                    showDialog(
                                        context: context,
                                        builder: (context){
                                          return AlertDialog(
                                            content: Container(
                                              height: 150,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text("Confirm Deletion",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                  Text("WARNING: This action is IRREVERSIBLE !!",textAlign: TextAlign.center,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      NamedButton(
                                                        voidCallback: () async {
                                                          MysqlClient().deleteData(snapshot.data![index],context);
                                                          Navigator.pop(context);
                                                          Future.delayed(
                                                              Duration(seconds: 1), (){
                                                            setState(() {
                                                              snapshot.data!.clear();
                                                              getNames = MysqlClient().mysqlClientConnection();
                                                            });
                                                          }
                                                          );
                                                        },
                                                        buttonName: "Confirm",
                                                        color: Colors.pink,
                                                      ),
                                                      SizedBox(width: 10,),
                                                      NamedButton(
                                                        voidCallback: ()=>Navigator.pop(context),buttonName: "Cancel",
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                    );
                                  },
                                  icon: Icon(Icons.delete)
                              ),
                            );
                          }
                      )
                  ),
                ],
              );
            }else if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }else{
              return Center(child: Text("Server ERROR BITCH !!!"),);
            }
          }
      ),
    );
  }
}