import 'package:flutter_test/flutter_test.dart';

import 'package:petnet_mobdev_project/main.dart';

void main() {
  testWidgets('PetNet app loads the welcome screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PetNetApp());

    expect(find.text('Welcome to PetNet'), findsOneWidget);
    expect(find.text('Get started'), findsOneWidget);
  });
}
