import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:discovery_api_flutter/models/ApiDTO.dart';
import 'package:discovery_api_flutter/widgets/ApiItemList.dart';
import 'package:discovery_api_flutter/utils/TimeTracker.dart';
import 'package:discovery_api_flutter/data/local/DBProvider.dart';

class FavoriteApis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discovery Api Android',
      home: FavoriteApisScreen(),
    );
  }
}

class FavoriteApisScreen extends StatefulWidget {
  @override
  createState() => _FavoriteApisState();
}

class _FavoriteApisState extends State<FavoriteApisScreen> {
  var apis = new List<ApiDTO>();
  DateTime startDate;
  DateTime endDate;

  initState() {
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de APIs"),
        ),
        body: FutureBuilder<List<ApiDTO>>(
          future: DBProvider.db.getAllFavoriteApis(),
          builder: (BuildContext context, AsyncSnapshot<List<ApiDTO>> snapshot) {
            if (snapshot.hasData) {
              endDate = TimeTracker.getCurrentTime();
              TimeTracker.processingTime(startDate, endDate);
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return new ApiItemList(index, snapshot.data[index]);
                },
              );
            } else {
              print('no data');
              startDate = TimeTracker.getCurrentTime();
              return Center(child: CircularProgressIndicator());
            }
          },
        )
    );
  }
}
