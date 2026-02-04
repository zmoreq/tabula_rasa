import 'package:flutter/material.dart';

class CityPage extends StatefulWidget {
  final String cityName;

  CityPage({
    required this.cityName,
  });

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cityName),
      ),
      body: Center(
        child: Text('Witamy w mieście ${widget.cityName}!'),
      ),
    );
  }
}