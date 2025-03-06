import 'package:flutter/material.dart';
import 'package:flutter_application_1/localstorage/local_storage.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/view_model/todoviewModel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  const HomeScreen({super.key, required this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final todovm = Provider.of<Todoviewmodel>(context, listen: false);
    todovm.setTodoFromLocal();
    
  }


  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todovm1 = Provider.of<Todoviewmodel>(context, listen: false);
 LocalStorage storage=LocalStorage();
    return Scaffold(
      appBar: AppBar(
        leading: Icon( Icons.note_alt, color:Colors.white),
        title: Text("Get it done :)" ,style: TextStyle(color:Colors.white),),
        backgroundColor: Colors.purple,
        actionsPadding: EdgeInsets.fromLTRB(0, 0, 30, 0),
        actions:<Widget>[TextButton(onPressed: ()=>{
            storage.setIsLoggedin(false),
            todovm1.cleartodo(),
             Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return MyApp();
                },
              ),
            ),
        }
        , child: Icon(IconData(0xe3b3, fontFamily: 'MaterialIcons'),color:Colors.white,size: 30.0,))]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<Todoviewmodel>(
              builder: (context, todovm, _) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: todovm.todolist.length,
                  padding: EdgeInsets.all(50),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    //  Card(
                    //   elevation: 6,
                    //   margin: const EdgeInsets.all(10),
                    return Padding(padding:  const EdgeInsets.symmetric(vertical: 8.0),
                    
                    child: ListTile(
                      minTileHeight: 80,
                    
                      leading: CircleAvatar(
                      backgroundColor: Colors.purple,
                      child: Text((index+1).toString() ,style: TextStyle(color:Colors.white)),
                          ),
                      shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.black),
                             ),
                      trailing:
                           IconButton(
                             onPressed: () {
                                todovm.deleteTask(index);
                               },
                              icon: Icon(Icons.delete), ),
                        
                      title: Text(todovm.todolist[index]["task_name"]),
                    ));
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        onPressed:
            () => {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Add New Task'),
                    content: TextField(
                      controller: _textFieldController,
                      decoration: InputDecoration(hintText: "Enter task"),
                      autofocus: true,
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('CANCEL'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: Text('SAVE'),
                        onPressed:
                            () => {
                              todovm1.addTask(_textFieldController.text),
                              _textFieldController.clear(),
                              Navigator.pop(context),
                            },
                      ),
                    ],
                  );
                },
              ),
            },

        child: Icon(Icons.add),
      ),
    );
  }
}
