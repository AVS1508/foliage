import 'package:flutter/material.dart';

class CustomSnackbar extends StatelessWidget {
  final bool isError;
  final String message;

  const CustomSnackbar({
    Key? key,
    required this.isError,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          height: 90,
          decoration: BoxDecoration(
            color: isError ? Colors.redAccent : Colors.greenAccent,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isError ? 'Oh snap!' : 'Success!',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ]),
        )
      ],
    );
  }
}
