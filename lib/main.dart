import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/home_screen.dart';
import 'package:flutter_application_1/view_model/todoviewModel.dart';
import 'package:flutter_application_1/localstorage/local_storage.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Todoviewmodel>(
          create: (context) => Todoviewmodel(),
        ),
      ],
      child: MaterialApp(
        title: 'TodoList',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: const MyHomePage(title: 'To Do home'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
      final LocalStorage storage = LocalStorage();

  void checkStatus()async{
      bool val=await storage.getIsLoggedin();
      if (val==true) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen(email:"");
                },
              ),
            );
          }
  }
  @override
  void initState() {   
    checkStatus(); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final todovm = Provider.of<Todoviewmodel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Get it done :)",style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          height: 400,
          width: 500,
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 129, 8, 242)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text("Login",style: TextStyle(color: Colors.purple,fontSize: 45.0),)
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  // controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a email',
                  ),
                  controller: emailController,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your password',
                  ),
                  controller: passwordController,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    elevation: 10,

                  ),

                  onPressed:() async{
                    if (emailController.text == todovm.name &&
                        passwordController.text == todovm.password) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Logged in successfully")),
                      );
                      await storage.setIsLoggedin(true);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen(email: emailController.text);
                          },
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Invalid Email or Password")),
                      );
                    }
                  },
                  child: Text("Login",style: TextStyle(fontSize: 15.0),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
