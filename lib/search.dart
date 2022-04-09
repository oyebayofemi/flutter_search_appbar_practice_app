import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:search_appbar_practice_app/loading.dart';

class customSearchDelegate extends SearchDelegate {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('products');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: collectionReference.snapshots().asBroadcastStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: [
              ...snapshot.data!.docs
                  .where((QueryDocumentSnapshot<Object?> element) =>
                      element['title']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()) ||
                      element['desc']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                  .map((QueryDocumentSnapshot<Object?> data) {
                final String title = data.get('title');
                final String desc = data.get('desc');
                final String descFinal = (desc.replaceAll("\\n", "\n"));
                print(descFinal);
                print(title);

                return ListTile(
                  title: Text(title),
                  subtitle: Text(descFinal),
                );
              })
            ],
          );
        } else {
          return Loading();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: collectionReference.snapshots().asBroadcastStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: [
              ...snapshot.data!.docs
                  .where((QueryDocumentSnapshot<Object?> element) =>
                      element['title']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()) ||
                      element['desc']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                  .map((QueryDocumentSnapshot<Object?> data) {
                final String title = data.get('title');
                final String desc = data.get('desc');
                final String descFinal = (desc.replaceAll("\\n", "\n"));
                print(descFinal);
                print(title);

                return ListTile(
                  title: Text(title),
                  subtitle: Text(descFinal),
                );
              })
            ],
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
