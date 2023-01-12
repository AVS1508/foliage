import 'package:crypto_wallet/api/flutterfire.dart';
import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = [
    "bitcoin",
    "tether",
    "ethereum",
  ];

  String dropdownValue = "bitcoin";
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              value: dropdownValue,
              onChanged: (value) {
                setState(() {
                  dropdownValue = value.toString();
                });
              },
              items: coins.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  hintText: 'Amount',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Coin Amount',
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async {
                  await addCoin(dropdownValue, _amountController.text);
                  Navigator.of(context).pop();
                },
                child: const Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
