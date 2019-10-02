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
      theme: ThemeData(
        primaryColor: Color(0xFF8BC34A),
        primaryColorDark: Color(0xFF689F38),
        primaryColorLight: Color(0xFFDCEDC8),
        accentColor: Color(0xFFCDDC39)
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  String TAG_REMOTE = 'REMOTE';
  String TAG_LIST_REMOTE = 'LIST_REMOTE';

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
    TimeTracker.recordTime(TAG_REMOTE, 'loadApisList');

    ApiRemoteRepository.getApis().then((response) {
      setState(() {
        var data = json.decode(response.body);
        Iterable list = data['items'];
        apis = list.map((model) => ApiDTO.fromMap(model)).toList();

        TimeTracker.recordTime(TAG_REMOTE, 'updateApiList');
        TimeTracker.recordTime(TAG_LIST_REMOTE, 'addingApisToList');
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
              key: Key('favorite_icon'),
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
          key: Key('api_list'),
          itemCount: apis.length,
          itemBuilder: (context, index) {
            return new ApiItemList(TAG_LIST_REMOTE, index, apis[index]);
          },
        ));
  }
}
