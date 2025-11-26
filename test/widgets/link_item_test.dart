import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shorten_my_link/models/link_model.dart';
import 'package:shorten_my_link/pages/home/cubit/home_cubit.dart';
import 'package:shorten_my_link/ui/link_item.dart';

import 'link_item_test.mocks.dart';

@GenerateMocks([HomeCubit])
void main() {
  late MockHomeCubit mockHomeCubit;
  late AliasModel testAliasModel;

  setUp(() {
    mockHomeCubit = MockHomeCubit();
    when(mockHomeCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockHomeCubit.state).thenReturn(HomeState());

    testAliasModel = AliasModel(
      alias: 'abc123',
      lLinks: LinksModel(
        self: 'https://url-grande-url-grande-url-grande-url-grande.com/abc123',
        short: 'https://example.com',
      ),
    );
  });

  Widget createWidgetUnderTest({required int index}) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<HomeCubit>.value(
          value: mockHomeCubit,
          child: LinkItem(index: index, aliasModel: testAliasModel),
        ),
      ),
    );
  }

  group('LinkItem Widget', () {
    testWidgets('Deve renderizar informações do link', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(index: 0));

      expect(
        find.text(
          'https://url-grande-url-grande-url-grande-url-grande.com/abc123',
        ),
        findsOneWidget,
      );
      expect(find.text('abc123'), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);
    });

    testWidgets('Deve ter cor alternada baseada no index', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(index: 0));
      final containerEven = tester.widget<Container>(
        find.byType(Container).first,
      );

      await tester.pumpWidget(createWidgetUnderTest(index: 1));
      final containerOdd = tester.widget<Container>(
        find.byType(Container).first,
      );

      expect(containerEven.color, Colors.white);
      expect(containerOdd.color, isNot(Colors.white));
    });

    testWidgets('Deve chamar deleteLink quando o botão delete é pressionado', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(index: 0));

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pump();

      verify(mockHomeCubit.deleteLink(0)).called(1);
    });

    testWidgets('Deve mostrar SnackBar ao deletar link', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(index: 0));

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pump();

      expect(find.text('Deleted link: abc123'), findsOneWidget);
    });

    testWidgets('Deve copiar link ao tocar no item', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(index: 0));

      await tester.tap(find.byType(ListTile));
      await tester.pump();

      expect(find.textContaining('Copied to clipboard'), findsOneWidget);
    });
  });
}
