import 'package:flutter/material.dart';

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
      theme: ThemeData(
        primaryColor: Color(0xFF8BC34A),
        primaryColorDark: Color(0xFF689F38),
        primaryColorLight: Color(0xFFDCEDC8),
        accentColor: Color(0xFFCDDC39)
      )
    );
  }
}

class FavoriteApisScreen extends StatefulWidget {
  @override
  createState() => _FavoriteApisState();
}

class _FavoriteApisState extends State<FavoriteApisScreen> {
  String TAG = 'LIST_LOCAL';

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
              endDate = TimeTracker.getCurrentTime(TAG, 'ApisListLoaded');
              TimeTracker.processingTime(TAG, startDate, endDate);
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return new ApiItemList(index, snapshot.data[index]);
                },
              );
            } else {
              startDate = TimeTracker.getCurrentTime(TAG, 'addingApisToList');
              return Center(child: CircularProgressIndicator());
            }
          },
        )
    );
  }
}
