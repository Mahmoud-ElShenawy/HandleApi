import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utils_test/model/data_model.dart';
import 'package:utils_test/service/repository/data_repository.dart';

final dataProvider = FutureProvider.autoDispose<List<DataModel>>(
    (ref) async => DataRepositoryApi().getData());
