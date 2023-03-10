import 'package:application_state/application_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SharedPreferences? pref;
  ApplicationState? applicationState;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    pref = await SharedPreferences.getInstance();
    applicationState = ApplicationState(sharedPrefs: pref);
  });

  // Future<void> removeIsLoggedinEntry() async {
  //   await pref!.remove(keyIsLoggedin);
  // }

  test(
      'Given ApplicationState not have SharedPre param on init, expect _sharedPrefs prop auto assign (for mock testing or decrease dependency when init service)',
      () async {
    ApplicationState appState = await ApplicationState.createInstance();
    await appState.setIsLoggedin(true);
    expect(await appState.getIsLoggedin(), true);
  });
  test('expect a true value when get is logged in have true value', () async {
    pref!.setBool(keyIsLoggedin, true);
    expect(await applicationState!.getIsLoggedin(), true);
  });
  test('expect a false value when get is logged in return false', () async {
    pref!.setBool(keyIsLoggedin, false);
    expect(await applicationState!.getIsLoggedin(), false);
  });
  test('expect a false value when get is logged in not have entry', () async {
    //DONOT set entry of keyIsLoggedin
    expect(await applicationState!.getIsLoggedin(), false);
  });
  test('expect throw StorageException when get exception from sharepreference',
      () async {
    //TRYTO call exception way to test without MOCK
    pref!.setString(keyIsLoggedin, 'heyyoh');
    expect(applicationState!.getIsLoggedin(), throwsA(isA<StorageException>()));
  });
}
