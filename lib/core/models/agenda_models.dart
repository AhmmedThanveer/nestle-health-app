// Immutable data models for the Agenda feature.
// All instances are compile-time constants — zero allocation at runtime.

class AgendaSession {
  final String startTime;
  final String endTime;
  final String topic;
  final String speaker;

  const AgendaSession({
    required this.startTime,
    required this.endTime,
    required this.topic,
    required this.speaker,
  });
}

class AgendaHall {
  final String name;      // short name shown on the selector chip
  final String fullName;  // long name shown inside the dropdown
  final String moderators;
  final List<AgendaSession> sessions;

  const AgendaHall({
    required this.name,
    required this.fullName,
    required this.moderators,
    required this.sessions,
  });
}

class AgendaDay {
  final String label; // "Day 1"
  final String date;  // "8 May 2026"
  final List<AgendaHall> halls;

  const AgendaDay({
    required this.label,
    required this.date,
    required this.halls,
  });
}

// ─── Static temporary data ────────────────────────────────────────────────────

class AgendaData {
  AgendaData._();

  static const List<AgendaDay> days = [
    // ── Day 1 ────────────────────────────────────────────────────────────────
    AgendaDay(
      label: 'Day 1',
      date: '8 May 2026',
      halls: [
        AgendaHall(
          name: 'Hall A',
          fullName: 'Hall A : Immunity, Allergy & GIT (AL SUMO - G Floor)',
          moderators:
              'Dr. Hatem El Shorbagy / Dr. Muath Al Turaiki',
          sessions: [
            AgendaSession(
              startTime: '08:00',
              endTime: '09:00',
              topic: 'Registration',
              speaker: 'All',
            ),
            AgendaSession(
              startTime: '09:00',
              endTime: '09:35',
              topic:
                  'Revealing Facts on Human Milk Oligosaccharides in Early Life',
              speaker: 'Dr. Mike Posner (Nestlé, Germany)',
            ),
            AgendaSession(
              startTime: '09:35',
              endTime: '09:45',
              topic: 'Q&A',
              speaker: 'All',
            ),
            AgendaSession(
              startTime: '09:45',
              endTime: '10:20',
              topic: 'The Role of Microbiome in Immune Development',
              speaker: 'Dr. Hani Tamim (KSA)',
            ),
            AgendaSession(
              startTime: '10:20',
              endTime: '10:30',
              topic: 'Q&A',
              speaker: 'All',
            ),
            AgendaSession(
              startTime: '10:30',
              endTime: '10:45',
              topic: 'Coffee Break',
              speaker: 'All',
            ),
            AgendaSession(
              startTime: '10:45',
              endTime: '11:20',
              topic: 'Allergy Prevention in Early Life: New Insights',
              speaker: 'Dr. Ahmad Al-Farsi (UAE)',
            ),
            AgendaSession(
              startTime: '11:20',
              endTime: '11:30',
              topic: 'Q&A',
              speaker: 'All',
            ),
            AgendaSession(
              startTime: '11:30',
              endTime: '12:00',
              topic: 'Panel Discussion',
              speaker: 'All',
            ),
            AgendaSession(
              startTime: '12:00',
              endTime: '13:00',
              topic: 'Lunch Break',
              speaker: 'All',
            ),
          ],
        ),
        AgendaHall(
          name: 'Hall B',
          fullName:
              'Hall B : Development Milestones (Brain & Growth) (AL HADEEL - G Floor)',
          moderators: 'Dr. Faisal Al-Otaibi / Dr. Sara Mahmoud',
          sessions: [
            AgendaSession(
              startTime: '09:00',
              endTime: '09:35',
              topic:
                  'Brain Development and Nutrition in the First 1000 Days',
              speaker: 'Dr. John Smith (UK)',
            ),
            AgendaSession(
              startTime: '09:35',
              endTime: '09:45',
              topic: 'Q&A',
              speaker: 'All',
            ),
            AgendaSession(
              startTime: '09:45',
              endTime: '10:20',
              topic: 'Growth Monitoring and Intervention Strategies',
              speaker: 'Dr. Layla Hassan (KSA)',
            ),
            AgendaSession(
              startTime: '10:20',
              endTime: '10:30',
              topic: 'Q&A',
              speaker: 'All',
            ),
            AgendaSession(
              startTime: '10:30',
              endTime: '10:45',
              topic: 'Coffee Break',
              speaker: 'All',
            ),
            AgendaSession(
              startTime: '10:45',
              endTime: '11:20',
              topic: 'Nutrigenomics and Personalised Infant Nutrition',
              speaker: 'Dr. Sara Mahmoud (KSA)',
            ),
            AgendaSession(
              startTime: '11:20',
              endTime: '11:30',
              topic: 'Q&A',
              speaker: 'All',
            ),
          ],
        ),
        AgendaHall(
          name: 'Hall C',
          fullName:
              'Hall C : From Theory to Practice (Interactive Sessions) (AL SUMO - 1st Floor)',
          moderators: 'Dr. Khalid Al-Rashid / Dr. Noor Al-Ghamdi',
          sessions: [
            AgendaSession(
              startTime: '09:00',
              endTime: '10:30',
              topic:
                  'Interactive Workshop: Nutrition Assessment Tools in Clinical Practice',
              speaker: 'Dr. Ibrahim Al-Zahrani (KSA)',
            ),
            AgendaSession(
              startTime: '10:30',
              endTime: '10:45',
              topic: 'Coffee Break',
              speaker: 'All',
            ),
            AgendaSession(
              startTime: '10:45',
              endTime: '12:00',
              topic: 'Case Studies in Paediatric Allergy Management',
              speaker: 'Dr. Noor Al-Ghamdi (KSA)',
            ),
          ],
        ),
      ],
    ),

    // ── Day 2 ────────────────────────────────────────────────────────────────
    AgendaDay(
      label: 'Day 2',
      date: '9 May 2026',
      halls: [
        AgendaHall(
          name: 'Main Auditorium',
          fullName: 'Main Auditorium',
          moderators:
              'Dr. Abdulrahman Al-Nemri / Dr. Wajeeh Al-Dekhail',
          sessions: [
            AgendaSession(
              startTime: '08:30',
              endTime: '09:30',
              topic: 'Registration',
              speaker: 'All',
            ),
            AgendaSession(
              startTime: '09:30',
              endTime: '09:30',
              topic: 'Welcoming',
              speaker: 'Aseel Shawli (Nestlé, KSA)',
            ),
            AgendaSession(
              startTime: '09:30',
              endTime: '09:35',
              topic:
                  'Revealing Facts on Human Milk Oligosaccharides in Early Life',
              speaker: 'Dr. Mike Posner (Nestlé, Germany)',
            ),
            AgendaSession(
              startTime: '09:35',
              endTime: '09:45',
              topic: 'Q&A',
              speaker: 'All',
            ),
            AgendaSession(
              startTime: '09:45',
              endTime: '10:20',
              topic:
                  'Emerging Role of Probiotics in Gastrointestinal Health in Infants',
              speaker: 'Dr. Jubara Alallah (KSA)',
            ),
            AgendaSession(
              startTime: '10:20',
              endTime: '10:30',
              topic: 'Q&A',
              speaker: 'All',
            ),
            AgendaSession(
              startTime: '10:30',
              endTime: '10:45',
              topic: 'Coffee Break',
              speaker: 'All',
            ),
            AgendaSession(
              startTime: '10:45',
              endTime: '11:20',
              topic: 'Nutrition and Immunity: Clinical Perspectives',
              speaker: 'Dr. Rania Al-Qassim (KSA)',
            ),
            AgendaSession(
              startTime: '11:20',
              endTime: '11:30',
              topic: 'Q&A',
              speaker: 'All',
            ),
            AgendaSession(
              startTime: '11:30',
              endTime: '12:00',
              topic: 'Panel Discussion',
              speaker: 'All',
            ),
            AgendaSession(
              startTime: '12:00',
              endTime: '13:00',
              topic: 'Lunch Break',
              speaker: 'All',
            ),
            AgendaSession(
              startTime: '13:00',
              endTime: '13:35',
              topic: 'Advanced Topics in Paediatric Nutrition',
              speaker: 'Dr. Yara Mahmoud (KSA)',
            ),
            AgendaSession(
              startTime: '13:35',
              endTime: '13:45',
              topic: 'Q&A',
              speaker: 'All',
            ),
            AgendaSession(
              startTime: '13:45',
              endTime: '14:20',
              topic:
                  'Evidence-Based Approaches to Infant Feeding',
              speaker: 'Dr. Omar Abdullah (UAE)',
            ),
            AgendaSession(
              startTime: '14:20',
              endTime: '14:30',
              topic: 'Q&A',
              speaker: 'All',
            ),
            AgendaSession(
              startTime: '14:30',
              endTime: '15:00',
              topic: 'Closing Ceremony',
              speaker: 'All',
            ),
          ],
        ),
      ],
    ),
  ];
}
