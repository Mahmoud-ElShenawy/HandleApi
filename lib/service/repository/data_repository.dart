import 'package:utils_test/model/data_model.dart';
import 'package:utils_test/service/network/api_provider.dart';

abstract class DataRepository {
  Future<List<DataModel>> getData();
}

class DataRepositoryApi implements DataRepository {
  List<DataModel> dataList;
  ApiProvider apiProvider = ApiProvider.internal();

  @override
  Future<List<DataModel>> getData() async {
    await apiProvider
        .get(apiRoute: 'https://jsonplaceholder.typicode.com/posts')
        .then((response) => {
              dataList = (response.data as List)
                  .map((e) => DataModel.fromJson(e))
                  .toList(),
            });
    return dataList;
  }
}
