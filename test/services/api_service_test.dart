import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shorten_my_link/models/link_model.dart';
import 'package:shorten_my_link/repositories/storage_repository.dart';
import 'package:shorten_my_link/services/api_service.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([Dio, StorageRepository])
void main() {
  late ApiService apiService;
  late MockDio mockDio;
  late MockStorageRepository mockStorageRepository;

  setUp(() {
    mockDio = MockDio();
    mockStorageRepository = MockStorageRepository();
    apiService = ApiService(
      dio: mockDio,
      storageRepository: mockStorageRepository,
    );
  });

  group('Testando ApiService', () {
    group('Testando registerShortLink', () {
      test('Deve registrar link e salvar no storage com sucesso', () async {
        const link = 'https://example.com';
        final responseData = {
          'alias': 'abc123',
          '_links': {
            'self': 'https://example-short.com',
            'short': 'https://example-short.com',
          },
        };

        when(mockDio.post(any, data: anyNamed('data'))).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 201,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        when(
          mockStorageRepository.add(any, any),
        ).thenAnswer((_) async => Future.value());

        final result = await apiService.registerShortLink(link);

        expect(result.isRight(), true);
        result.fold((error) => fail('Não deveria retornar erro'), (aliasModel) {
          expect(aliasModel.alias, 'abc123');
          expect(aliasModel.lLinks.self, 'https://example-short.com');
        });
      });

      test('Deve retornar erro', () async {
        const link = 'https://example.com';
        when(mockDio.post(any, data: anyNamed('data'))).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            message: 'Network error',
          ),
        );

        final result = await apiService.registerShortLink(link);

        expect(result.isLeft(), true);
      });
    });

    group('Testando getLinks', () {
      test('Deve retornar lista de links do storage', () {
        const jsonString =
            '{"alias":"abc123","_links":{"self":"https://url-grande-url-grande-url-grande-url-grande.com/abc123","short":"https://example-short.com"}}';
        when(mockStorageRepository.values()).thenReturn([jsonString]);

        final links = apiService.getLinks();

        expect(links, isA<List<AliasModel>>());
        expect(links.length, 1);
        expect(links.first.alias, 'abc123');
      });

      test('Deve retornar lista vazia quando storage está vazio', () {
        when(mockStorageRepository.values()).thenReturn([]);

        final links = apiService.getLinks();

        expect(links, isEmpty);
      });
    });

    group('Testando deleteLink', () {
      test('Deve deletar dado do storage', () {
        final aliasModel = AliasModel(
          alias: 'abc123',
          lLinks: LinksModel(
            self:
                'https://url-grande-url-grande-url-grande-url-grande.com/abc123',
            short: 'https://example-short.com',
          ),
        );
        when(
          mockStorageRepository.delete(any),
        ).thenAnswer((_) async => Future.value());

        apiService.deleteLink(aliasModel);

        verify(mockStorageRepository.delete('abc123')).called(1);
      });
    });
  });
}
