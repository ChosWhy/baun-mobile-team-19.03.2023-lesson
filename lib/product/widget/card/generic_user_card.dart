
import 'package:flutter/material.dart';

import '../../../303/generic_learn.dart';

class GenericUserCard extends StatelessWidget {
  const GenericUserCard({Key? key, required this.user}) : super(key: key);

  final GenericUser user;
  @override
  Widget build(BuildContext context) {
    return Card(child: Text(user.name),);
  }
}
