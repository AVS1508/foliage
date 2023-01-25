// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:foliage/api/cryptocurrency.dart';
import 'package:foliage/components/custom_snackbar.dart';
import 'package:foliage/constants/colors.dart';
import 'package:foliage/constants/market_data.dart';
import 'package:foliage/utils/validators.dart';

class AddCryptoView extends StatefulWidget {
  const AddCryptoView({super.key});

  @override
  State<AddCryptoView> createState() => _AddCryptoViewState();
}

class _AddCryptoViewState extends State<AddCryptoView> {
  List<String> coins = MarketData.getCryptocurrencyIds();

  String? dropdownValue;
  final TextEditingController _amountController = TextEditingController();
  final _addCryptoFormKey = GlobalKey<FormState>();

  void addButtonClick(VoidCallback onSuccess) async {
    if (_addCryptoFormKey.currentState!.validate()) {
      await addCryptocurrency(dropdownValue!, _amountController.text).then((tuple) {
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _addCryptoFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      border: OutlineInputBorder(),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    value: dropdownValue,
                    hint: const Text('Token Name'),
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value.toString();
                      });
                    },
                    items: coins.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          '${MarketData.getCryptocurrencyName(value)} (${MarketData.getCryptocurrencySymbol(value)})',
                        ),
                      );
                    }).toList(),
                    validator: (value) {
                      return (value != null) ? null : 'Select a token name.';
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    controller: _amountController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      border: OutlineInputBorder(),
                      labelText: 'Token Amount',
                      hintText: 'Token Amount',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,16}'))],
                    validator: (value) => doubleValidator(value),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: CustomColors.foliageGreen,
                  ),
                  child: MaterialButton(
                    onPressed: () => addButtonClick(() {
                      Navigator.of(context).pop();
                    }),
                    child: const Text(
                      'Add Tokens to Wallet',
                      style: TextStyle(
                        fontSize: 18,
                        color: CustomColors.trueWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
