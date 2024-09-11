import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Connection One',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),

    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  Database? _database;
  bool _isConnected = false;

  Future<void> _connectToDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'my_database.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE test (id INTEGER PROMARY KEY, name TEXT)',
        );
      },
    );

    setState(() {
      _isConnected = true;
    });
  }

  void _disconnectFromDatabase(){
    _database?.close();
    setState(() {
      _isConnected = false;
      _database = null;
    });    
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter DB Connection One')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: _isConnected ? null : _connectToDatabase, 
            child: const Text('Conectar a la base de datos'), 
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _isConnected ? _disconnectFromDatabase : null, 
            child: const Text('Desconectar de la base de datos'), ),
            const SizedBox(height: 20,),
            Text(_isConnected ? 'Conectado' : 'Desconectado'),
          ],
        ),
      ),
    );
  }
}

