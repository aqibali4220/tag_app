

class SingleToneValue {

  double currentLat=0.0;
  double currentLng=0.0;

  // String  dvToken="";


  SingleToneValue._privateConstructor();

  static SingleToneValue get instance => _instance;

  static final SingleToneValue _instance =
  SingleToneValue._privateConstructor();


  factory SingleToneValue() {
    return _instance;
  }

}
