import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:yaml/yaml.dart';

class Environment {
  static Config config = Config.defaultConfg;

  Environment._();

  static Future<void> load({
    @visibleForTesting AssetBundle? bundle,
  }) async {
    final path = "assets/config/environment.yaml";

    bundle ??= rootBundle;
    final data = await bundle.loadString(path);

    final yaml = loadYaml(data);

    config = Config._(
      baseHost: yaml["base_host"] as String,
      apikey: yaml["api_key"] as String,
    );
  }
}

class Config {
  final String baseHost;
  final String apikey;

  const Config._({
    required this.baseHost,
    required this.apikey,
  });

  static const Config defaultConfg = Config._(
    baseHost: "notloaded",
    apikey: "notloaded",
  );
}
