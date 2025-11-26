import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shorten_my_link/pages/home/cubit/home_cubit.dart';
import 'package:shorten_my_link/ui/input_link.dart';

import 'input_link_test.mocks.dart';

@GenerateMocks([HomeCubit])
void main() {
  late MockHomeCubit mockHomeCubit;

  setUp(() {
    mockHomeCubit = MockHomeCubit();
    when(mockHomeCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockHomeCubit.state).thenReturn(HomeState());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<HomeCubit>.value(
          value: mockHomeCubit,
          child: const InputLink(),
        ),
      ),
    );
  }

  group('Testando InputLink Widget', () {
    testWidgets('Deve renderizar TextField e o botão de envio', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.send), findsOneWidget);
      expect(find.text('Enter your link here'), findsOneWidget);
    });

    testWidgets('Deve limpar texto quando o botão clear é pressionado', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.byType(TextField), 'https://example.com');
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();

      expect(find.text('https://example.com'), findsNothing);
    });

    testWidgets('Deve mostrar erro quando URL inválida é enviada', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.byType(TextField), 'invalid-url');
      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();

      expect(find.text('Please enter a valid URL'), findsOneWidget);
      verifyNever(mockHomeCubit.addLink(any));
    });

    testWidgets('Deve chamar addLink quando URL válida é enviada', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      const validUrl = 'https://example.com';

      await tester.enterText(find.byType(TextField), validUrl);
      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();

      verify(mockHomeCubit.addLink(validUrl)).called(1);
    });

    testWidgets('Deve mostrar erro quando campo está vazio', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();

      expect(find.text('Please enter a valid URL'), findsOneWidget);
      verifyNever(mockHomeCubit.addLink(any));
    });
  });
}
