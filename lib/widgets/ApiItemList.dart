import 'package:flutter/material.dart';

import 'package:discovery_api_flutter/models/ApiDTO.dart';
import 'package:discovery_api_flutter/data/local/DBProvider.dart';

class ApiItemList extends StatefulWidget {
  final ApiDTO apiDTO;

  ApiItemList(ApiDTO apiDto)
      : apiDTO = apiDto,
        super(key: new ObjectKey(apiDto));

  @override
  ApiItemState createState() {
    return new ApiItemState(apiDTO);
  }
}

class ApiItemState extends State<ApiItemList> {
  final ApiDTO apiDTO;

  ApiItemState(this.apiDTO);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: null,
      title: new Row(
        children: <Widget>[
          new Expanded(
              child: new Text(
            apiDTO.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )),
          new Checkbox(
              value: apiDTO.isFavorited,
              onChanged: (bool value) {
                setState(() {
                  apiDTO.isFavorited = value;

                  if(apiDTO.isFavorited)
                    DBProvider.db.likeApi(apiDTO);
                });
              })
        ],
      ),
      subtitle: Text(apiDTO.description, style: TextStyle(fontSize: 16)),
    );
  }
}


