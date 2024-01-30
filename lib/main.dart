// ignore_for_file: public_member_api_docs, sort_constructors_first
//import 'package:db003_b_try/sqldb.dart';
import 'package:db_try1mobapp1/edit_note.dart';
import 'package:flutter/material.dart';
import 'package:db_try1mobapp1/add_note.dart';
import 'package:db_try1mobapp1/add_update_delete_read_functions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseCURD databaseCURD = DatabaseCURD();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNote()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: databaseCURD.readData(),
        builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView.builder(
                // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2, crossAxisSpacing: 20, childAspectRatio: 2),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                physics: const ScrollPhysics(),
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    margin: const EdgeInsetsDirectional.only(bottom: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.amber,
                    ),
                    child: ListTile(
                      title: Text(
                        "${snapshot.data![i]['note']}",
                      ),
                      leading: Text(
                        "id = ${snapshot.data![i]['id']}",
                      ),
                      trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            databaseCURD.delete(id: snapshot.data![i]['id']);
                            setState(() {});
                          }),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditNote(
                                    note: snapshot.data![i]['note'],
                                    id: snapshot.data![i]['id'])));
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
