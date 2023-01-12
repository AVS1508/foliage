import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/api/api_methods.dart';
import 'package:crypto_wallet/api/flutterfire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'add_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;

  @override
  void initState() {
    super.initState();
    getValues();
  }

  getValues() async {
    bitcoin = await getCoinPrice('bitcoin');
    ethereum = await getCoinPrice('ethereum');
    tether = await getCoinPrice('tether');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getValue(String id, double amount) {
      if (id == 'bitcoin') {
        return bitcoin * amount;
      } else if (id == 'ethereum') {
        return ethereum * amount;
      } else {
        return tether * amount;
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection('Coins')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((document) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 5.0,
                          left: 15.0,
                          right: 15.0,
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.blue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "Coin: ${document.id}",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "\$${getValue(document.id, document.get('Amount')).toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  await removeCoin(document.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddView(),
              ),
            );
          },
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
