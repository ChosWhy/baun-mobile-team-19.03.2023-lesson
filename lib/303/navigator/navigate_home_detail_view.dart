import 'package:flutter/material.dart';

class NavigateHomeDetailView extends StatefulWidget {
  const NavigateHomeDetailView({Key? key, this.id}) : super(key: key);

  final String? id;
  @override
  State<NavigateHomeDetailView> createState() => _NavigateHomeDetailViewState();
}

class _NavigateHomeDetailViewState extends State<NavigateHomeDetailView> {

  String? _id;
  @override
  void initState() {
    super.initState();
    //todo : bu kullanım onGenerateRoute için
    var _id = widget.id;
    if(_id == null){
      Future.microtask(() {
        final _modelId = ModalRoute.of(context)?.settings.arguments;
        setState(() {
          _id = _modelId is String ? _modelId : widget.id;
        });
        print(_modelId);
      });
    }
    /*
    Future.microtask(() {
      final _modelId = ModalRoute.of(context)?.settings.arguments;
      setState(() {
        _id = _modelId is String ? _modelId : widget.id;
      });
      print(_modelId);
    });*/
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.error,
      appBar: AppBar(
        title: Text(_id ?? ""),
      ),
    );
  }
}
