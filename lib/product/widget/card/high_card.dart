
import 'package:flutter/material.dart';

class HighCard extends StatelessWidget {
  const HighCard({Key? key, required this.items}) : super(key: key);

  final List<String> items;
  @override
  Widget build(BuildContext context) {
    return Text(items.join(","),style: Theme.of(context).textTheme.displayMedium);
  }
}

//todo: join metot
//join metodu listedeki String ifadeleri yanyana içindeki parametre ne ise metodun onu kullanarak aralarına birleştiriyor!
