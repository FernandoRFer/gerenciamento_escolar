class RequestSettings {
  static String baseURL = "localhost:8081";
  static Map<String, String> headerTypeJson = {
    'Content-Type': 'application/json'
  };
  static bool isMock = false;

  static getEnvironmentvariable() {
    const environmentisMock = bool.fromEnvironment("IS_MOCK");
    if (baseURL.isNotEmpty) isMock = environmentisMock == true;
  }
}
