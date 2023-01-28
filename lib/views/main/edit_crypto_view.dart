// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:foliage/api/cryptocurrency.dart';
import 'package:foliage/components/custom_snackbar.dart';
import 'package:foliage/constants/colors.dart';
import 'package:foliage/constants/market_data.dart';
import 'package:foliage/utils/validators.dart';

class EditCryptoView extends StatefulWidget {
  final String cryptocurrencyID;
  final String cryptocurrencyAmount;

  const EditCryptoView({Key? key, required this.cryptocurrencyID, required this.cryptocurrencyAmount}) : super(key: key);

  @override
  State<EditCryptoView> createState() => _EditCryptoViewState();
}

class _EditCryptoViewState extends State<EditCryptoView> {
  final TextEditingController _amountController = TextEditingController();
  final _editCryptoFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _amountController.text = widget.cryptocurrencyAmount;
    super.initState();
  }

  void updateButtonClick(VoidCallback onSuccess) async {
    if (_editCryptoFormKey.currentState!.validate()) {
      await updateCryptocurrency(widget.cryptocurrencyID, _amountController.text).then((tuple) {
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
            key: _editCryptoFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text(
                    '${MarketData.getCryptocurrencyName(widget.cryptocurrencyID)} \n (${MarketData.getCryptocurrencySymbol(widget.cryptocurrencyID)})',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
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
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,18}')),
                    ],
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      border: OutlineInputBorder(),
                      labelText: 'Token Amount',
                      hintText: 'Token Amount',
                    ),
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
                    onPressed: () => updateButtonClick(() {
                      Navigator.of(context).pop();
                    }),
                    child: const Text(
                      'Update Tokens in Wallet',
                      style: TextStyle(
                        fontSize: 18,
                        color: CustomColors.trueWhite,
                      ),
                    ),
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
                    color: CustomColors.cadetGrey,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
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
