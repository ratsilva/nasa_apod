import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:storage_service/src/storage/hive/path_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late PathProvider pathProvider;

  setUp(() {
    pathProvider = DefaultPathProvider();

    PathProviderPlatform.instance = FakePathProviderPlatform();
  });

  test("get documents directory", () async {
    final result = await pathProvider.getDocumentsDirectory();

    expect(result.path, "fakePath");
  });

  test("get application support directory", () async {
    final result = await pathProvider.getApplicationSupportDirectory();

    expect(result.path, "fakePath");
  });

  test("get temporary directory", () async {
    final result = await pathProvider.getTemporaryDirectory();

    expect(result.path, "fakePath");
  });
}

///
class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  String _fakePath = 'fakePath';

  @override
  Future<String?> getTemporaryPath() async {
    return _fakePath;
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return _fakePath;
  }

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return _fakePath;
  }
}
