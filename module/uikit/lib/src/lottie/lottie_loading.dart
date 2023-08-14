import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingLottie extends StatelessWidget {
  const LoadingLottie({
    super.key,
  });

  final String _loadingLottie = "assets/lottie/lottie_theme_change.json";

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(_loadingLottie));
  }
}