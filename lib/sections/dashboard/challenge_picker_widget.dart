import 'package:cas_house/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/challenge.dart';

class ChallengePickerButton extends StatefulWidget {
  final Function(Challenge) onChallengeSelected;

  const ChallengePickerButton({
    super.key,
    required this.onChallengeSelected,
  });

  @override
  State<ChallengePickerButton> createState() => _ChallengePickerButtonState();
}

class _ChallengePickerButtonState extends State<ChallengePickerButton> {
  Future<List<Challenge>> fetchChallenges() async {
    final url = Uri.parse('${ApiService.baseUrl}/challenge');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode} przy ładowaniu wyzwań');
    }

    final jsonData = jsonDecode(response.body);
    if (jsonData['success'] != true) {
      throw Exception('Server zwrócił success=false');
    }

    return (jsonData['challenges'] as List)
        .map((c) => Challenge.fromJson(c))
        .toList();
  }

  Future<void> _createChallenge(
      String title, DateTime start, DateTime end) async {
    final url = Uri.parse('${ApiService.baseUrl}/challenge');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'startDate': start.toIso8601String(),
        'endDate': end.toIso8601String(),
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode} przy tworzeniu wyzwania');
    }

    final jsonData = jsonDecode(response.body);
    if (jsonData['success'] != true) {
      throw Exception('Nie udało się dodać wyzwania');
    }
  }

  void _openAddChallengeDialog() {
    String title = '';
    DateTime? startDate;
    DateTime? endDate;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('Dodaj nowe wyzwanie'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Tytuł'),
                onChanged: (v) => title = v,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  final d = await showDatePicker(
                    context: ctx,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => startDate = d);
                },
                child: Text(
                  startDate == null
                      ? 'Wybierz datę startu'
                      : 'Start: ${startDate!.toLocal().toString().split(" ")[0]}',
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  final d = await showDatePicker(
                    context: ctx,
                    initialDate: startDate ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => endDate = d);
                },
                child: Text(
                  endDate == null
                      ? 'Wybierz datę zakończenia'
                      : 'End: ${endDate!.toLocal().toString().split(" ")[0]}',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Anuluj'),
            ),
            ElevatedButton(
              onPressed:
                  (title.isNotEmpty && startDate != null && endDate != null)
                      ? () async {
                          try {
                            await _createChallenge(title, startDate!, endDate!);
                            Navigator.of(ctx).pop();
                            _openChallengePicker();
                          } catch (e) {
                            Navigator.of(ctx).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        }
                      : null,
              child: const Text('Dodaj'),
            ),
          ],
        ),
      ),
    );
  }

  void _openChallengePicker() async {
    final challenges = await fetchChallenges();
    challenges.sort((a, b) => a.endDate.compareTo(b.endDate));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SizedBox(
        height: MediaQuery.of(ctx).size.height * 0.7,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: challenges.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final ch = challenges[index];
                  final end = ch.endDate.toLocal().toString().split(' ')[0];
                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Text(
                      ch.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Ends: $end'),
                    onTap: () {
                      widget.onChallengeSelected(ch);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Dodaj nowe wyzwanie'),
                onPressed: () {
                  Navigator.pop(ctx);
                  _openAddChallengeDialog();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _openChallengePicker,
      child: const Text('Wybierz wyzwanie'),
    );
  }
}
