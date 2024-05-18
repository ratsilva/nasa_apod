import 'package:mockito/annotations.dart';
import 'package:nasa_picture_data/src/datasource/local_data_source.dart';
import 'package:nasa_picture_data/src/datasource/remote_data_source.dart';
import 'package:network_service/network_service.dart';
import 'package:storage_service/storage_service.dart';

@GenerateNiceMocks([
  MockSpec<StorageService>(),
  MockSpec<NetworkService>(),
  MockSpec<LocalDataSource>(),
  MockSpec<RemoteDataSource>(),
])
class Mocks {}
