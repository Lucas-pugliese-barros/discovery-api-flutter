import 'package:flutter/material.dart';

import 'package:discovery_api_flutter/models/ApiDTO.dart';
import 'package:discovery_api_flutter/data/local/DBProvider.dart';

class ApiItemList extends StatefulWidget {
   int index;
   ApiDTO apiDTO;

  ApiItemList(int index, ApiDTO apiDto)
      : index = index,
        apiDTO = apiDto,
        super(key: new ObjectKey(apiDto));

  @override
  ApiItemState createState() {
    return new ApiItemState();
  }
}

class ApiItemState extends State<ApiItemList> {
  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: null,
      title: new Row(
        children: <Widget>[
          new Expanded(
              child: new Text(
                '${widget.index.toString()} ${widget.apiDTO.name}}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )),
          new Checkbox(
              key: Key(widget.index.toString()),
              value:  widget.apiDTO.isFavorited,
              onChanged: (bool value) {
                setState(() {
                  widget.apiDTO.isFavorited = value;

                  if(widget.apiDTO.isFavorited)
                    DBProvider.db.likeApi(widget.apiDTO);
                });
              })
        ],
      ),
      subtitle: Text(widget.apiDTO.description, style: TextStyle(fontSize: 16)),
    );
  }
}


