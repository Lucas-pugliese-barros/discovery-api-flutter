class ApiEntity {
  static String TABLE_NAME = "api";
  static String COLUMN_NAME_SEQUENCE = "sequence";
  static String COLUMN_NAME_KIND = "kind";
  static String COLUMN_NAME = "name";
  static String COLUMN_NAME_VERSION = "version";
  static String COLUMN_NAME_TITLE = "title";
  static String COLUMN_NAME_DESCRIPTION = "description";
  static String COLUMN_NAME_DISCOVERY_RESULT_URL = "discoveryRestUrl";
  static String COLUMN_NAME_DOCUMENTATION_LINK = "documentationLink";
  static String COLUMN_NAME_PREFERRED = "preferred";
  static String COLUMN_NAME_IS_FAVORITED = "favorited";

  static String WHERE_CLAUSE = "=?";

  static String SQL_CREATE_TABLE = 'CREATE TABLE ${TABLE_NAME} ('
      '${COLUMN_NAME_SEQUENCE} TEXT, '
      '${COLUMN_NAME_KIND}  TEXT, '
      '${COLUMN_NAME}  TEXT, '
      '${COLUMN_NAME_VERSION}  TEXT, '
      '${COLUMN_NAME_TITLE}  TEXT, '
      '${COLUMN_NAME_DESCRIPTION}  TEXT, '
      '${COLUMN_NAME_DISCOVERY_RESULT_URL}  TEXT, '
      '${COLUMN_NAME_DOCUMENTATION_LINK}  TEXT, '
      '${COLUMN_NAME_PREFERRED}  TEXT, '
      '${COLUMN_NAME_IS_FAVORITED}  INTEGER)';
}