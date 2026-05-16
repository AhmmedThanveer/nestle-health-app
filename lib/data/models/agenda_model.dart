import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/models/agenda_models.dart';

class AgendaDayModel extends AgendaDay {
  const AgendaDayModel({
    required super.label,
    required super.date,
    required super.halls,
  });

  factory AgendaDayModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>? ?? {};
    final hallsList = (d['halls'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(_parseHall)
        .toList();

    return AgendaDayModel(
      label: d['dayLabel'] as String? ?? '',
      date: d['dayDate'] as String? ?? '',
      halls: hallsList,
    );
  }

  static AgendaHall _parseHall(Map<String, dynamic> h) {
    final sessions = (h['sessions'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(_parseSession)
        .toList();

    return AgendaHall(
      name: h['name'] as String? ?? '',
      fullName: h['fullName'] as String? ?? '',
      moderators: h['moderators'] as String? ?? '',
      sessions: sessions,
    );
  }

  static AgendaSession _parseSession(Map<String, dynamic> s) => AgendaSession(
        startTime: s['startTime'] as String? ?? '',
        endTime: s['endTime'] as String? ?? '',
        topic: s['topic'] as String? ?? '',
        speaker: s['speaker'] as String? ?? '',
      );
}

