import 'package:flutter/material.dart';

import 'package:discovery_api_flutter/models/ApiDTO.dart';
import 'package:discovery_api_flutter/data/local/DBProvider.dart';

import 'package:discovery_api_flutter/utils/TimeTracker.dart';

class ApiItemList extends StatefulWidget {
  String TAG_LIKE_API = 'LIKE_API';
  String TAG;

  int index;
  ApiDTO apiDTO;

  Function _onItemCreated;

  ApiItemList(String TAG, int index, ApiDTO apiDto)
      : TAG = TAG,
        index = index,
        apiDTO = apiDto,
        super(key: new ObjectKey(apiDto));

  @override
  ApiItemState createState() {
    ApiItemState item = new ApiItemState();

    if (index == 3) {
      TimeTracker.recordTime(TAG, 'apisListLoaded');
      if (_onItemCreated != null) _onItemCreated(index);
    }

    return item;
  }

  Function get onItemCreated => _onItemCreated;

  set onItemCreated(Function value) {
    _onItemCreated = value;
  }
}

class ApiItemState extends State<ApiItemList> {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new ListTile(
          onTap: null,
          title: new Row(
            children: <Widget>[
              new Expanded(
                  child: new Padding(
                      padding: EdgeInsets.only(top: 2.0, bottom: 1.0),
                      child: new Text(
                        '${widget.index.toString()} ${widget.apiDTO.name}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ))),
              new Checkbox(
                  key: Key(widget.index.toString()),
                  value: widget.apiDTO.isFavorited,
                  onChanged: (bool value) {
                    setState(() {
                      widget.apiDTO.isFavorited = value;

                      if (widget.apiDTO.isFavorited) {
                        if (widget.index == 0)
                          TimeTracker.recordTime(
                              widget.TAG_LIKE_API, 'likeApi');

                        DBProvider.db.likeApi(widget.apiDTO);

                        if (widget.index == 0)
                          TimeTracker.recordTime(
                              widget.TAG_LIKE_API, 'apiLiked');
                      }
                    });
                  })
            ],
          ),
          subtitle: new Padding(
            padding: EdgeInsets.only(top: 1.0, bottom: 3.0),
            child: Text(widget.apiDTO.description,
                style: TextStyle(fontSize: 16.5)),
          ),
        ),
        Divider()
      ],
    );
  }
}
