import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:search_appbar_practice_app/loading.dart';
import 'package:search_appbar_practice_app/search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Demo(),
    );
  }
}

class Demo extends StatefulWidget {
  Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search App..'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: customSearchDelegate());
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').orderBy('title',descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot dsnapshot = snapshot.data!.docs[index];
                  print(dsnapshot.id);
                  //String uid = dsnapshot.id;
                  String desc = dsnapshot['desc'];
                  final String descFinal = (desc.replaceAll("\\n", "\n"));
                  //print(descFinal);

                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => MapSample(
                      //             uid,
                      //             dsnapshot['lalng'].latitude,
                      //             dsnapshot['lalng'].longitude)));
                    },
                    child: Card(
                      //color: Colors.grey,

                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Text(dsnapshot['title']),
                          Text(descFinal),
                        ]),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
