import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_apod_app/app/integrations/environment/environment.dart';

import 'mocks/mocks.mocks.dart';

void main() {
  late AssetBundle assetBundle;
  late Config config;

  setUp(() async {
    assetBundle = MockAssetBundle();

    final environmentString = "base_host: custom_base_host\napi_key: custom_api_key";
    when(assetBundle.loadString("assets/config/environment.yaml"))
        .thenAnswer((_) => Future.value(environmentString));

    await Environment.load(bundle: assetBundle);

    config = Environment.config;
  });

  test("load Environment config from yaml", () async {
    expect(config.baseHost, "custom_base_host");
    expect(config.apikey, "custom_api_key");
    verify(assetBundle.loadString("assets/config/environment.yaml")).called(1);
  });
}
