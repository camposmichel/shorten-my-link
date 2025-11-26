import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shorten_my_link/models/link_model.dart';
import 'package:shorten_my_link/pages/home/cubit/home_cubit.dart';
import 'package:shorten_my_link/services/api_service.dart';

import 'home_cubit_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  late HomeCubit homeCubit;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    when(mockApiService.getLinks()).thenReturn([]);
  });

  tearDown(() {
    homeCubit.close();
  });

  group('Testando HomeCubit', () {
    test('Estado inicial deve ser HomeState com lista vazia', () {
      homeCubit = HomeCubit(apiService: mockApiService);

      expect(homeCubit.state, isA<HomeState>());
      expect(homeCubit.state.aliasList, isEmpty);
    });

    blocTest<HomeCubit, HomeState>(
      'Deve carregar dados iniciais com sucesso',
      build: () {
        when(mockApiService.getLinks()).thenReturn([
          AliasModel(
            alias: 'abc123',
            lLinks: LinksModel(
              self: 'https://example.com',
              short: 'https://example-short.com',
            ),
          ),
        ]);
        return HomeCubit(apiService: mockApiService);
      },
      act: (cubit) => cubit.loadInitialData(),
      expect: () => [
        isA<HomeState>().having(
          (state) => state.aliasList.length,
          'aliasList length',
          1,
        ),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'Deve adicionar link com sucesso',
      build: () {
        final aliasModel = AliasModel(
          alias: 'abc123',
          lLinks: LinksModel(
            self:
                'https://url-grande-url-grande-url-grande-url-grande.com/abc123',
            short: 'https://example-short.com/abc123',
          ),
        );
        when(mockApiService.getLinks()).thenReturn([]);
        when(
          mockApiService.registerShortLink(any),
        ).thenAnswer((_) async => Right(aliasModel));
        return HomeCubit(apiService: mockApiService);
      },
      act: (cubit) => cubit.addLink(
        'https://url-grande-url-grande-url-grande-url-grande.com/abc123',
      ),
      expect: () => [
        isA<HomeLoadingState>(),
        isA<HomeState>().having(
          (state) => state.aliasList.length,
          'aliasList length',
          1,
        ),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'Deve emitir erro ao adicionar link',
      build: () {
        when(mockApiService.getLinks()).thenReturn([]);
        when(
          mockApiService.registerShortLink(any),
        ).thenAnswer((_) async => const Left('Erro'));
        return HomeCubit(apiService: mockApiService);
      },
      act: (cubit) => cubit.addLink('https://example.com'),
      expect: () => [
        isA<HomeLoadingState>(),
        isA<HomeErrorState>().having(
          (state) => state.message,
          'error message',
          'Erro',
        ),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'Deve deletar link com sucesso',
      build: () {
        final aliasModel = AliasModel(
          alias: 'abc123',
          lLinks: LinksModel(
            self: 'https://example.com',
            short: 'https://example-short.com',
          ),
        );
        when(mockApiService.getLinks()).thenReturn([aliasModel]);
        when(mockApiService.deleteLink(any)).thenAnswer((_) => Future.value());
        return HomeCubit(apiService: mockApiService);
      },
      seed: () => HomeState(
        aliasList: [
          AliasModel(
            alias: 'abc123',
            lLinks: LinksModel(
              self: 'https://example.com',
              short: 'https://example-short.com',
            ),
          ),
        ],
      ),
      act: (cubit) => cubit.deleteLink(0),
      expect: () => [
        isA<HomeState>().having(
          (state) => state.aliasList.length,
          'aliasList length',
          0,
        ),
      ],
    );
  });
}
