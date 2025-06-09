import 'package:cas_house/api_service.dart';
import 'package:cas_house/main_global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/challenge.dart';

class ChallengePickerButton extends StatefulWidget {
  final Function(Challenge) onChallengeSelected;

  const ChallengePickerButton({super.key, required this.onChallengeSelected});

  @override
  State<ChallengePickerButton> createState() => _ChallengePickerButtonState();
}

class _ChallengePickerButtonState extends State<ChallengePickerButton> {
  Future<List<Challenge>> fetchChallenges() async {
    final response = await http.get(Uri.parse("${ApiService.baseUrl}/challenge"));
    final jsonData = jsonDecode(response.body);
    if (response.statusCode == 200 && jsonData['success']) {
      return (jsonData['challenges'] as List)
          .map((c) => Challenge.fromJson(c))
          .toList();
    } else {
      throw Exception("Failed to load challenges");
    }
  }

  void _openChallengePicker() async {
    final challenges = await fetchChallenges();

    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        itemCount: challenges.length,
        itemBuilder: (context, index) {
          final challenge = challenges[index];
          return ListTile(
            title: Text(challenge.title),
            subtitle: Text("Ends: ${challenge.endDate}"),
            onTap: () {
              widget.onChallengeSelected(challenge);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _openChallengePicker,
      label: const Text("Wybierz wyzwanie"),
    );
  }
}
