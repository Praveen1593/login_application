

class GlobalDetails {
  static GlobalDetails? instance;

  static GlobalDetails? getInstance() {
    if (instance == null) {
      instance = GlobalDetails();
    }
    return instance;
  }

  static void reset() {
    instance = null;
  }

  var token = "";
  var phoneNumber = "";
  var id = "";


}