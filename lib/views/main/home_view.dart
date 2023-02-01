// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

// Project imports:
import 'package:foliage/api/cryptocurrency.dart';
import 'package:foliage/api/user.dart';
import 'package:foliage/components/custom_snackbar.dart';
import 'package:foliage/constants/colors.dart';
import 'package:foliage/constants/market_data.dart';
import 'package:foliage/main.dart';
import 'package:foliage/views/main/add_crypto_view.dart';
import 'package:foliage/views/main/edit_crypto_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _cryptocurrencyPrices = {for (var id in MarketData.getCryptocurrencyIds()) id: 0.0};

  @override
  void initState() {
    super.initState();
    getValues();
  }

  getValues() {
    CollectionReference prices = FirebaseFirestore.instance.collection('prices');
    prices.snapshots().listen((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        setState(() {
          _cryptocurrencyPrices[result.id] = result.get('price');
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('cryptocurrencies').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((document) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          left: 15.0,
                          right: 15.0,
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: CustomColors.materialBlue,
                          ),
                          child: Center(
                            child: Table(
                              columnWidths: const {
                                1: FlexColumnWidth(4),
                                2: FlexColumnWidth(6),
                                3: FlexColumnWidth(1),
                                4: FlexColumnWidth(2),
                                5: FlexColumnWidth(2),
                              },
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              children: [
                                TableRow(
                                  children: [
                                    const Padding(padding: EdgeInsets.only(right: 15.0)),
                                    Text(
                                      '${MarketData.getCryptocurrencyName(document.id)} \n (${MarketData.getCryptocurrencySymbol(document.id)})',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "\$ ${(_cryptocurrencyPrices[document.id]! * document.get('amount')).toStringAsFixed(2)} \n (${document.get('amount')})",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    const Text(''),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                      ),
                                      onPressed: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditCryptoView(
                                              cryptocurrencyID: document.id,
                                              cryptocurrencyAmount: document.get('amount').toString(),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                      ),
                                      padding: const EdgeInsets.only(
                                        right: 15.0,
                                      ),
                                      onPressed: () async {
                                        await removeCryptocurrency(document.id);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
          ),
        ),
        floatingActionButton: Container(
          child: _homeFAB(context),
        ),
      ),
    );
  }
}

Widget _homeFAB(context) {
  void logOutButtonClick(VoidCallback onSuccess) async {
    await signOut().then((tuple) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomSnackbar(
            isError: !tuple.item1,
            message: tuple.item2,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
      if (tuple.item1) {
        onSuccess.call();
      }
    });
  }

  return SpeedDial(
    animatedIcon: AnimatedIcons.menu_close,
    animatedIconTheme: const IconThemeData(size: 22.0),
    backgroundColor: CustomColors.foliageGreen,
    spacing: 15.0,
    childMargin: const EdgeInsets.all(15.0),
    visible: true,
    curve: Curves.bounceIn,
    children: [
      SpeedDialChild(
        child: const Icon(Icons.add),
        backgroundColor: CustomColors.materialBlue,
        label: 'Add Crypto',
        labelStyle: const TextStyle(fontSize: 18.0),
        labelBackgroundColor: CustomColors.materialBlue,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCryptoView(),
            ),
          );
        },
      ),
      SpeedDialChild(
        child: const Icon(Icons.logout),
        backgroundColor: CustomColors.materialBlue,
        label: 'Sign Out',
        labelStyle: const TextStyle(fontSize: 18.0),
        labelBackgroundColor: CustomColors.materialBlue,
        onTap: () => logOutButtonClick(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyApp(),
            ),
          );
        }),
      ),
      SpeedDialChild(
        child: const Icon(Icons.refresh),
        backgroundColor: CustomColors.materialBlue,
        label: 'Refresh',
        labelStyle: const TextStyle(fontSize: 18.0),
        labelBackgroundColor: CustomColors.materialBlue,
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeView(),
            ),
          );
        },
      ),
    ],
  );
}
