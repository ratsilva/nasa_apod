import 'package:mockito/annotations.dart';
import 'package:storage_service/src/storage/hive/path_provider.dart';
import 'package:storage_service/src/storage/key_value_storage.dart';

@GenerateNiceMocks([
  MockSpec<KeyValueStorage>(),
  MockSpec<PathProvider>(),
])
class Mocks {}
