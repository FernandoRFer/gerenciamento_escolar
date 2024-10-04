class RequestSettings {
  //Para fazer coneção atravez do emulado é necessario utilizar esse host
  static String domain = "10.0.2.2:8081";
  static Map<String, String> headerTypeJson = {
    'Content-Type': 'application/json'
  };
  static bool isMock = false;
}
