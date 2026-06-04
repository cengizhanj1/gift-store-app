import 'package:flutter_test/flutter_test.dart';

import 'package:mini_katalog_app/main.dart';

void main() {
  testWidgets('Mini Catalog home screen loads products', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MiniCatalogApp());
    expect(find.text('Mini Catalog'), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text('iPhone 15 Pro'), findsOneWidget);
  });
}
