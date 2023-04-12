// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kiosk/main.dart';
import 'package:kiosk/utils/constants.dart';
import 'package:kiosk/widgets/action_card.dart';
import 'package:kiosk/widgets/hyper_link.dart';

void main() {

  testWidgets("description", (tester) async {
    await tester.pumpWidget(Text("here"));

    expect(find.text("here"), findsOneWidget);
  });

  // testWidgets("Testing hyperlink widget", (WidgetTester tester) async {
  //   await tester.pumpWidget(MaterialApp(
  //     home: Scaffold(
  //       body: Hyperlink(
  //           text: "Hyperlink test",
  //           onPressed: (){
  //
  //           }),
  //     )
  //   )
  //   );
  //
  //   expect(find.byElementType(Hyperlink), findsOneWidget);
  // });
  //
  // group("Testing action card", () {
  //
  //   testWidgets("Testing action card : Filled", (WidgetTester tester) async {
  //
  //     //creating a filled card
  //     await tester.pumpWidget(const ActionCard(
  //         label: "Test card",
  //         icon: Icons.add
  //     )
  //     );
  //
  //     //checking if widget exists
  //     expect(find.byIcon(Icons.add), findsOneWidget);
  //
  //     // expect((tester.firstWidget(find.byType(ActionCard)) as Material).color, blue.withOpacity(0.5));
  //   });
  // });
}
