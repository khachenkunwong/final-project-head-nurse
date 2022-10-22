import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _chcknull = prefs.getString('ff_chcknull') ?? _chcknull;
    _tokenStore = prefs.getString('ff_tokenStore') ?? _tokenStore;
    _namegroup = prefs.getString('ff_namegroup') ?? _namegroup;
    _itemsduty = prefs.getString('ff_itemsduty') ?? _itemsduty;
    _myID = prefs.getString('ff_myID') ?? _myID;
    _itemsdutyupdata = prefs.getStringList('ff_itemsdutyupdata') ?? _itemsdutyupdata;
    _itemscount = prefs.getStringList('ff_itemscount') ?? _itemscount;
    _itemsdutyList = prefs.getStringList('ff_itemsdutyList') ?? _itemsdutyList;
  }

  late SharedPreferences prefs;

  String _chcknull = 'ว่าง';
  String get chcknull => _chcknull;
  set chcknull(String _value) {
    _chcknull = _value;
    prefs.setString('ff_chcknull', _value);
  }

  String _tokenStore = '';
  String get tokenStore => _tokenStore;
  set tokenStore(String _value) {
    _tokenStore = _value;
    prefs.setString('ff_tokenStore', _value);
  }

  String _namegroup = '';
  String get namegroup => _namegroup;
  set namegroup(String _value) {
    _namegroup = _value;
    prefs.setString('ff_namegroup', _value);
  }
  String _myID = '';
  String get myID => _myID;
  set myID(String _value) {
    _myID = _value;
    prefs.setString('ff_myID', _value);
  }

  String _itemsduty = '';
  String get itemsduty => _itemsduty;
  set itemsduty(String _value) {
    _itemsduty = _value;
    prefs.setString('ff_itemsduty', _value);
  }


  List<String> _itemsdutyupdata = [];
  List<String> get itemsdutyupdata => _itemsdutyupdata;
  set itemsdutyupdata(List<String> _value) {
    _itemsdutyupdata = _value;
    prefs.setStringList('ff_itemsdutyupdata', _value);
  }

  List<String> _itemscount = [];
  List<String> get itemscount => _itemscount;
  set itemscount(List<String> _value) {
    _itemscount = _value;
    prefs.setStringList('ff_itemscount', _value);
  }

  List<String> _itemsdutyList = [];
  List<String> get itemsdutyList => _itemsdutyList;
  set itemsdutyList(List<String> _value) {
    _itemsdutyList = _value;
    prefs.setStringList('ff_itemsdutyList', _value);
  }

  void addToItemsduty(String _value) {
    _itemsdutyupdata.add(_value);
    prefs.setStringList('ff_itemsdutyupdata', _itemsdutyupdata);
  }
  void insertToItemsduty(String _value , int index) {
    _itemsdutyupdata.insert(index,_value);
    prefs.setStringList('ff_itemsdutyupdata', _itemsdutyupdata);
  }

  void removeFromItemsduty(String _value) {
    _itemsdutyupdata.remove(_value);
    prefs.setStringList('ff_itemsdutyupdata', _itemsdutyupdata);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
