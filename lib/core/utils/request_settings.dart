abstract class RequestSettings {
  static String baseURL = "http://localhost:8081";
  static Map<String, String> headerTypeJson = {
    'Content-Type': 'application/json'
  };
  static bool isMocked = false;

  static getEnvironmentvariable() {
    bool environmentisMock = const bool.fromEnvironment("MOCKED");
    isMocked = environmentisMock;
  }
}
