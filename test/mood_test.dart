import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '/Users/kavehfaghani/Uni/project/hopebox/lib/main.dart';
import 'package:my_app/mood_rating.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/main.dart';
import 'package:my_app/landing_page.dart';
import 'package:my_app/mood_rating.dart';



void main() {

  testWidgets('Able to access mood rating from landing page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MaterialApp(
      home: new LandingPage(

      ),
    ));

    // Ensure that we are on our landing page
    expect(find.text('e'), findsNothing);
    expect(find.byIcon(Icons.cloud), findsNWidgets(4));
    expect(find.text('Enter Your Mood'), findsOneWidget);

    // Go to the Mood Entry Page
    await tester.tap(find.text('Enter Your Mood'));
    await tester.pumpAndSettle();


    // Ensure that emoji's are set up on mood entry page
    expect(find.byIcon(Icons.sentiment_very_dissatisfied), findsOneWidget);
    expect(find.byIcon(Icons.sentiment_neutral), findsOneWidget);


    // Ensure that no emoji is highlighted
    Icon selectedIcon = tester.widget(find.byIcon(Icons.sentiment_neutral));
    expect(selectedIcon.color, Colors.grey);
    print('Passed Test 1');

  });


  testWidgets('Test Highlighting colour of emoji', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MaterialApp(
      home: new LandingPage(

      ),
    ));

    // Ensure that we are on our landing page
    expect(find.text('e'), findsNothing);
    expect(find.byIcon(Icons.cloud), findsNWidgets(4));
    expect(find.text('Enter Your Mood'), findsOneWidget);

    // Go to the Mood Entry Page
    await tester.tap(find.text('Enter Your Mood'));
    await tester.pumpAndSettle();

    // Ensure that emoji's are set up on mood entry page
    expect(find.byIcon(Icons.sentiment_very_dissatisfied), findsOneWidget);
    expect(find.byIcon(Icons.sentiment_neutral), findsOneWidget);


    // Ensure that no emoji is highlighted
    Icon neutralEmoji = tester.widget(find.byIcon(Icons.sentiment_neutral));
    expect(neutralEmoji.color, Colors.grey);

    // Go to the Mood Entry Page
    await tester.tap(find.byIcon(Icons.sentiment_neutral));
    await tester.pumpAndSettle();

    // Ensure the emoji changes colour
    Icon neutralEmoji1 = tester.widget(find.byIcon(Icons.sentiment_neutral));
    expect(neutralEmoji1.color, Colors.amber);

    print('Passed Test 2');

  });


  testWidgets('Test unhighlighting the colour of the emoji', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MaterialApp(
      home: new LandingPage(

      ),
    ));

    // Ensure that we are on our landing page
    expect(find.text('e'), findsNothing);
    expect(find.byIcon(Icons.cloud), findsNWidgets(4));
    expect(find.text('Enter Your Mood'), findsOneWidget);

    // Go to the Mood Entry Page
    await tester.tap(find.text('Enter Your Mood'));
    await tester.pumpAndSettle();

    // Ensure that emoji's are set up on mood entry page
    expect(find.byIcon(Icons.sentiment_very_dissatisfied), findsOneWidget);
    expect(find.byIcon(Icons.sentiment_neutral), findsOneWidget);


    // Ensure that no emoji is highlighted
    Icon neutralEmoji = tester.widget(find.byIcon(Icons.sentiment_neutral));
    Icon dissatisfiedEmoji = tester.widget(find.byIcon(Icons.sentiment_dissatisfied));
    expect(neutralEmoji.color, Colors.grey);
    expect(dissatisfiedEmoji.color, Colors.grey);


    // Go to the Mood Entry Page
    await tester.tap(find.byIcon(Icons.sentiment_neutral));
    await tester.pumpAndSettle();

    // Ensure the emoji changes colour
    Icon neutralEmoji1 = tester.widget(find.byIcon(Icons.sentiment_neutral));
    Icon dissatisfiedEmoji1 = tester.widget(find.byIcon(Icons.sentiment_dissatisfied));
    expect(neutralEmoji1.color, Colors.amber);
    expect(dissatisfiedEmoji1.color, Colors.grey);


    // Go to the Mood Entry Page
    await tester.tap(find.byIcon(Icons.sentiment_neutral));
    await tester.pumpAndSettle();

    // Change the emoji's back to grey
    Icon neutralEmoji2 = tester.widget(find.byIcon(Icons.sentiment_neutral));
    Icon dissatisfiedEmoji2 = tester.widget(find.byIcon(Icons.sentiment_dissatisfied));
    expect(neutralEmoji2.color, Colors.grey);
    expect(dissatisfiedEmoji2.color, Colors.grey);

    print('Passed Test 3');

  });



}



