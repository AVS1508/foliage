// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

// Project imports:
import 'package:foliage/api/coingecko.dart';
import 'package:foliage/api/user.dart';
import 'package:foliage/api/cryptocurrency.dart';
import 'package:foliage/components/custom_snackbar.dart';
import 'package:foliage/constants/colors.dart';
import 'package:foliage/main.dart';
import 'package:foliage/views/main/add_crypto_view.dart';

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
                          top: 5.0,
                          left: 15.0,
                          right: 15.0,
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: CustomColors.materialBlue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Coin: ${document.id}',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                "\$${getValue(document.id, document.get('amount')).toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                ),
                                onPressed: () async {
                                  await removeCryptocurrency(document.id);
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
