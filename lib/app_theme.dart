import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:remoteconfig/remote_config.dart';

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key});

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  final FirebaseRemoteConfig config = FirebaseRemoteConfig.instance;
  double _fontSize = 20;
  Color color = Colors.black;

  Future<void> _fetchRemoteConfig() async {
    await config.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(minutes: 1),
        minimumFetchInterval: Duration(seconds: 20)));
    await config.fetchAndActivate();
    setState(() {
      _fontSize = config.getDouble('font_size');
      color = config.getString("title_color")as Color;
    });
  }


  @override
  void initState() {
    _fetchRemoteConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("size===${_fontSize}");
    log("color===${color}");
    final remoteConfig = FirebaseRemoteConfigService();
    final FirebaseRemoteConfig remoteConfigService =
        FirebaseRemoteConfig.instance;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: NetworkImage(remoteConfig.image),
        fit: BoxFit.cover,
      )),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
              child: Text(
            remoteConfig.title,
            style:  TextStyle( fontSize: _fontSize,color:color ),
          ))
        ],
      ),
    ));
  }
}
