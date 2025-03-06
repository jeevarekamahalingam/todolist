
import 'package:flutter/material.dart';
import 'package:flutter_application_1/localstorage/local_storage.dart';

class Todoviewmodel extends ChangeNotifier{
  String name = "Admin";
  String password= "1234!";

List <Map<String,dynamic>> todolist = [];


void setTodoFromLocal ()async{
  todolist = await LocalStorage().getTodo();
  notifyListeners();
}
void cleartodo()async{
  todolist.clear();
  await LocalStorage().setTodo([]);
}

  void updatePassword(String updatedPassword){
  password = updatedPassword;
  notifyListeners();

  }

  void deleteTask(int index)async{
    todolist.removeAt(index);
    await LocalStorage().setTodo(todolist);

    notifyListeners();
  }

  void addTask(String data) async{

    todolist.add({"task_name": data});
   
    await LocalStorage().setTodo(todolist);
    todolist =await  LocalStorage().getTodo();
    notifyListeners();
  }

}
