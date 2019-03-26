import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:discovery_api_flutter/models/ApiDTO.dart';
import 'package:discovery_api_flutter/data/remote/ApiRemoteRepository.dart';
import 'package:discovery_api_flutter/widgets/ApiItemList.dart';
import 'package:discovery_api_flutter/utils/TimeTracker.dart';
import 'package:discovery_api_flutter/pages/FavoriteApis.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discovery Api Android',
      home: MyListScreen(),
    );
  }
}

class MyListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  var apis = new List<ApiDTO>();
  DateTime startDate;
  DateTime endDate;

  initState() {
    super.initState();

    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  _getUsers() {
    startDate = TimeTracker.getCurrentTime();
    ApiRemoteRepository.getApis().then((response) {
      setState(() {
        var data = json.decode(response.body);
        Iterable list = data['items'];
        apis = list.map((model) => ApiDTO.fromMap(model)).toList();

        endDate = TimeTracker.getCurrentTime();
        TimeTracker.processingTime(startDate, endDate);
      });
    });
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de APIs"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.playlist_play),
              tooltip: 'Liked',
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => FavoriteApis())),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: apis.length,
          itemBuilder: (context, index) {
            return new ApiItemList(apis[index]);
          },
        ));
  }
}
