import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:discovery_api_flutter/data/local/entities/ApiEntity.dart';
import 'package:discovery_api_flutter/models/ApiDTO.dart';
import 'package:discovery_api_flutter/utils/TimeTracker.dart';


class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "apis_database_flutter.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute(ApiEntity.SQL_CREATE_TABLE);
        });
  }

  likeApi(ApiDTO api) async {
    String TAG = 'LIKE_API';

    DateTime startDate;
    DateTime endDate;

    startDate = TimeTracker.getCurrentTime(TAG, 'likeApi');

    final db = await database;

    var raw = await db.rawInsert(
        'INSERT Into ${ApiEntity.TABLE_NAME} ('
            '${ApiEntity.COLUMN_NAME_SEQUENCE}, '
            '${ApiEntity.COLUMN_NAME_KIND}, '
            '${ApiEntity.COLUMN_NAME}, '
            '${ApiEntity.COLUMN_NAME_VERSION}, '
            '${ApiEntity.COLUMN_NAME_TITLE}, '
            '${ApiEntity.COLUMN_NAME_DESCRIPTION}, '
            '${ApiEntity.COLUMN_NAME_DISCOVERY_RESULT_URL}, '
            '${ApiEntity.COLUMN_NAME_DOCUMENTATION_LINK}, '
            '${ApiEntity.COLUMN_NAME_PREFERRED}, '
            '${ApiEntity.COLUMN_NAME_IS_FAVORITED}'
            ')'
            ' VALUES (?,?,?,?,?,?,?,?,?,?)',
        [api.id, api.kind, api.name, api.version, api.title, api.description,
        api.discoveryRestUrl, api.documentationLink, api.preferred, api.isFavorited]);

    endDate = TimeTracker.getCurrentTime(TAG, 'apiLiked');
    TimeTracker.processingTime(TAG, startDate, endDate);

    return raw;
  }

  Future<List<ApiDTO>> getAllFavoriteApis() async {
    String TAG = 'LOCAL';

    DateTime startDate;
    DateTime endDate;

    startDate = TimeTracker.getCurrentTime(TAG, 'loadApisList');

    final db = await database;
    var res = await db.query(ApiEntity.TABLE_NAME);
    List<ApiDTO> list = res.isNotEmpty ? res.map((c) => ApiDTO.fromMap(c)).toList() : [];

    endDate = TimeTracker.getCurrentTime(TAG, 'updateApiList');
    TimeTracker.processingTime(TAG, startDate, endDate);

    return list;
  }
}