import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:adstacks_dashboard/main.dart';

void main() {
  testWidgets('Dashboard smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AdStacksDashboardApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
