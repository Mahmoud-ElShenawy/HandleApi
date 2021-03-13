import 'package:utils_test/model/data_model.dart';
import 'package:utils_test/service/network/api_provider.dart';
import 'package:utils_test/service/network/network_exceptions.dart';

abstract class DataRepository {
  Future<List<DataModel>> getData();
}

class DataRepositoryApi implements DataRepository {
  List<DataModel> dataList;
  ApiProvider apiProvider = ApiProvider.internal();

  @override
  Future<List<DataModel>> getData() async {
    await apiProvider.get(
        apiRoute: 'https://jsonplaceholder.typicode.com/posts',
        successResponse: (response) {
          dataList = (response.data as List)
              .map((e) => DataModel.fromJson(e))
              .toList();
        },
        errorResponse: (error) {
          NetworkExceptions.getErrorMessage(error);
        });

    return dataList;
  }
}
