import 'package:core_architecture/src/engine/pagination/source/pagination_source.dart';
import 'package:core_architecture/src/engine/search/filter/matcher/filter_matcher.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<FilterMatcher>(),
  MockSpec<PaginationSource>(),
])
class Mocks {}
