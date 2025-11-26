import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shorten_my_link/models/link_model.dart';
import 'package:shorten_my_link/models/types.dart';
import 'package:shorten_my_link/repositories/storage_repository.dart';

class ApiService {
  final String _baseUrl = 'https://url-shortener-server.onrender.com/api/alias';

  final Dio dio;
  final StorageRepository storageRepository;

  ApiService({Dio? dio, StorageRepository? storageRepository})
    : dio = dio ?? Dio(),
      storageRepository = storageRepository ?? StorageRepository();

  Future<Result<String>> getLink(String alias) async {
    try {
      final response = await dio.get('$_baseUrl/$alias');
      return Right(response.data['url'] as String);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Result<AliasModel>> registerShortLink(String link) async {
    try {
      final response = await dio.post(_baseUrl, data: {'url': link});
      final aliasModel = AliasModel.fromJson(response.data);
      await storageRepository.add(aliasModel.alias, aliasModel.toJsonString());
      return Right(aliasModel);
    } catch (e) {
      return Left(e.toString());
    }
  }

  List<AliasModel> getLinks() {
    final storedData = storageRepository.values().reversed;
    return storedData
        .map((e) => AliasModel.fromJsonString(e))
        .toList(growable: false);
  }

  void deleteLink(AliasModel aliasModel) {
    storageRepository.delete(aliasModel.alias);
  }
}
