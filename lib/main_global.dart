import 'package:cas_house/models/user.dart';
import 'package:flutter/material.dart';

String apiUrl = "http://10.0.2.2:3000";
String baseUrl = 'http://localhost:3000';

// ! Chosen mode
ValueNotifier<ThemeMode> chosenMode = ValueNotifier(ThemeMode.light);

// ? Function to update chosenSection value

// Global ValueNotifier to track the currently selected view in the app.
ValueNotifier<MainViews> currentSite =
    ValueNotifier<MainViews>(MainViews.dashboard);

// Enum to define the possible views in the application.
enum MainViews { dashboard, properties, defects, payment, user }

// Define commonly used colors in the app to maintain consistency across the UI.
const Color mainDarkBlue = Color.fromARGB(255, 1, 102, 177);
const Color mainGreen = Color.fromARGB(255, 9, 222, 174);
const Color mainGrey = Color.fromARGB(255, 239, 239, 239);

// Function to convert to the correct format for parsing to double regardless of the sign
String formatDate(String date) {
  DateTime parsedDate = DateTime.parse(date);
  return "${parsedDate.day}.${parsedDate.month}.${parsedDate.year}";
}

User? loggedUser;
