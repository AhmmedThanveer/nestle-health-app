import 'package:cloud_firestore/cloud_firestore.dart';

/// One-shot utility — call once to seed speakers + agenda, then remove.
/// Usage: await FirestoreSeeder.seed('YOUR_EVENT_ID');
abstract final class FirestoreSeeder {
  static Future<void> seed(String eventId) async {
    final db = FirebaseFirestore.instance;
    final batch = db.batch();
    final id = eventId.trim();

    // ── Speakers ─────────────────────────────────────────────────────────────
    final speakersRef = db.collection('speakers');
    final speakerDocs = _speakerData(id);
    for (int i = 0; i < speakerDocs.length; i++) {
      batch.set(speakersRef.doc(), {...speakerDocs[i], 'order': i});
    }

    // ── Agenda ───────────────────────────────────────────────────────────────
    final agendaRef = db.collection('agenda');
    final agendaDocs = _agendaData(id);
    for (int i = 0; i < agendaDocs.length; i++) {
      batch.set(agendaRef.doc(), {...agendaDocs[i], 'order': i + 1});
    }

    await batch.commit();
  }

  // ── Speaker data ────────────────────────────────────────────────────────────

  static List<Map<String, dynamic>> _speakerData(String eventId) => [
        // Chairpersons
        {
          'eventId': eventId,
          'name': 'Dr. Abdulrahman Al Nemri',
          'bio':
              'Professor of Pediatrics and Neonatology, College of Medicine, King Saud University / Consultant in Neonatology, King Saud University Medical City, Riyadh / Vice President of the Saudi Society of Neonatology / External examiner and visiting consultant for several Arab universities.',
          'imageUrl': 'https://i.pravatar.cc/300?img=52',
          'category': 'chairpersons',
        },
        {
          'eventId': eventId,
          'name': 'Dr. Ali Al Binali',
          'bio':
              'Consultant Pediatric Cardiologist with over 20 years of experience. Former Head of Pediatric Cardiology at King Fahd Hospital, Jeddah. Fellow of the Royal College of Physicians and Surgeons of Canada.',
          'imageUrl': 'https://i.pravatar.cc/300?img=69',
          'category': 'chairpersons',
        },
        {
          'eventId': eventId,
          'name': 'Dr. Hatem El Shorbagy',
          'bio':
              'Professor of Internal Medicine and Gastroenterology. Director of the Digestive Disease Center at Cairo University. Board Member of the Arab Organization for Gastroenterology.',
          'imageUrl': 'https://i.pravatar.cc/300?img=57',
          'category': 'chairpersons',
        },
        {
          'eventId': eventId,
          'name': 'Dr. Mohammed M.S. Jan',
          'bio':
              'Professor and Consultant of Pediatric Neurology, Faculty of Medicine, King Abdulaziz University, Jeddah. Member of the Child Neurology Society and the American Academy of Neurology.',
          'imageUrl': 'https://i.pravatar.cc/300?img=12',
          'category': 'chairpersons',
        },
        // Speakers
        {
          'eventId': eventId,
          'name': 'Dr. Sarah Al-Rashid',
          'bio':
              'Specialist in Clinical Nutrition and Dietetics. MSc Nutrition, University of Leeds. Senior Dietitian at King Faisal Specialist Hospital, Riyadh.',
          'imageUrl': 'https://i.pravatar.cc/300?img=47',
          'category': 'speakers',
        },
        {
          'eventId': eventId,
          'name': 'Dr. Khalid Al-Mutairi',
          'bio':
              'Consultant Neonatologist, King Abdullah Specialist Children\'s Hospital, Riyadh. FRCPC. Research interests: neonatal nutrition and premature infant outcomes.',
          'imageUrl': 'https://i.pravatar.cc/300?img=15',
          'category': 'speakers',
        },
        {
          'eventId': eventId,
          'name': 'Dr. Fatima Al-Zoabi',
          'bio':
              'Pediatric Gastroenterologist and Nutrition Specialist. Consultant at National Guard Health Affairs, Riyadh. Fellow of the European Society for Paediatric Gastroenterology.',
          'imageUrl': 'https://i.pravatar.cc/300?img=32',
          'category': 'speakers',
        },
        {
          'eventId': eventId,
          'name': 'Dr. Omar Al-Harbi',
          'bio':
              'Consultant Endocrinologist and Diabetologist, Prince Sultan Military Medical City. Expert in paediatric diabetes management and metabolic disorders.',
          'imageUrl': 'https://i.pravatar.cc/300?img=33',
          'category': 'speakers',
        },
        // Nestlé Speakers
        {
          'eventId': eventId,
          'name': 'Dr. Marie Dupont',
          'bio':
              'Global Medical Director – Infant Nutrition, Nestlé Health Science. MD PhD, University of Lausanne. Expert in early-life nutrition and long-term health outcomes.',
          'imageUrl': 'https://i.pravatar.cc/300?img=5',
          'category': 'nestleSpeakers',
        },
        {
          'eventId': eventId,
          'name': 'Dr. James Mitchell',
          'bio':
              'Head of Clinical Nutrition Research, Nestlé Institute of Health Sciences. 15 years of research in gut microbiome and immune development in early childhood.',
          'imageUrl': 'https://i.pravatar.cc/300?img=8',
          'category': 'nestleSpeakers',
        },
      ];

  // ── Agenda data ─────────────────────────────────────────────────────────────

  static List<Map<String, dynamic>> _agendaData(String eventId) => [
        // ── Day 1 ──────────────────────────────────────────────────────────────
        {
          'eventId': eventId,
          'dayLabel': 'Day 1',
          'dayDate': '8 May 2026',
          'halls': [
            {
              'name': 'Hall A',
              'fullName':
                  'Hall A : Immunity, Allergy & GIT (AL SUMO - G Floor)',
              'moderators': 'Dr. Hatem El Shorbagy / Dr. Muath Al Turaiki',
              'sessions': [
                {'startTime': '08:00', 'endTime': '09:00', 'topic': 'Registration', 'speaker': 'All'},
                {'startTime': '09:00', 'endTime': '09:35', 'topic': 'Revealing Facts on Human Milk Oligosaccharides in Early Life', 'speaker': 'Dr. Mike Posner (Nestlé, Germany)'},
                {'startTime': '09:35', 'endTime': '09:45', 'topic': 'Q&A', 'speaker': 'All'},
                {'startTime': '09:45', 'endTime': '10:20', 'topic': 'The Role of Microbiome in Immune Development', 'speaker': 'Dr. Hani Tamim (KSA)'},
                {'startTime': '10:20', 'endTime': '10:30', 'topic': 'Q&A', 'speaker': 'All'},
                {'startTime': '10:30', 'endTime': '10:45', 'topic': 'Coffee Break', 'speaker': 'All'},
                {'startTime': '10:45', 'endTime': '11:20', 'topic': 'Allergy Prevention in Early Life: New Insights', 'speaker': 'Dr. Ahmad Al-Farsi (UAE)'},
                {'startTime': '11:20', 'endTime': '11:30', 'topic': 'Q&A', 'speaker': 'All'},
                {'startTime': '11:30', 'endTime': '12:00', 'topic': 'Panel Discussion', 'speaker': 'All'},
                {'startTime': '12:00', 'endTime': '13:00', 'topic': 'Lunch Break', 'speaker': 'All'},
              ],
            },
            {
              'name': 'Hall B',
              'fullName':
                  'Hall B : Development Milestones (Brain & Growth) (AL HADEEL - G Floor)',
              'moderators': 'Dr. Faisal Al-Otaibi / Dr. Sara Mahmoud',
              'sessions': [
                {'startTime': '09:00', 'endTime': '09:35', 'topic': 'Brain Development and Nutrition in the First 1000 Days', 'speaker': 'Dr. John Smith (UK)'},
                {'startTime': '09:35', 'endTime': '09:45', 'topic': 'Q&A', 'speaker': 'All'},
                {'startTime': '09:45', 'endTime': '10:20', 'topic': 'Growth Monitoring and Intervention Strategies', 'speaker': 'Dr. Layla Hassan (KSA)'},
                {'startTime': '10:20', 'endTime': '10:30', 'topic': 'Q&A', 'speaker': 'All'},
                {'startTime': '10:30', 'endTime': '10:45', 'topic': 'Coffee Break', 'speaker': 'All'},
                {'startTime': '10:45', 'endTime': '11:20', 'topic': 'Nutrigenomics and Personalised Infant Nutrition', 'speaker': 'Dr. Sara Mahmoud (KSA)'},
                {'startTime': '11:20', 'endTime': '11:30', 'topic': 'Q&A', 'speaker': 'All'},
              ],
            },
            {
              'name': 'Hall C',
              'fullName':
                  'Hall C : From Theory to Practice (Interactive Sessions) (AL SUMO - 1st Floor)',
              'moderators': 'Dr. Khalid Al-Rashid / Dr. Noor Al-Ghamdi',
              'sessions': [
                {'startTime': '09:00', 'endTime': '10:30', 'topic': 'Interactive Workshop: Nutrition Assessment Tools in Clinical Practice', 'speaker': 'Dr. Ibrahim Al-Zahrani (KSA)'},
                {'startTime': '10:30', 'endTime': '10:45', 'topic': 'Coffee Break', 'speaker': 'All'},
                {'startTime': '10:45', 'endTime': '12:00', 'topic': 'Case Studies in Paediatric Allergy Management', 'speaker': 'Dr. Noor Al-Ghamdi (KSA)'},
              ],
            },
          ],
        },

        // ── Day 2 ──────────────────────────────────────────────────────────────
        {
          'eventId': eventId,
          'dayLabel': 'Day 2',
          'dayDate': '9 May 2026',
          'halls': [
            {
              'name': 'Main Auditorium',
              'fullName': 'Main Auditorium',
              'moderators':
                  'Dr. Abdulrahman Al-Nemri / Dr. Wajeeh Al-Dekhail',
              'sessions': [
                {'startTime': '08:30', 'endTime': '09:30', 'topic': 'Registration', 'speaker': 'All'},
                {'startTime': '09:30', 'endTime': '09:30', 'topic': 'Welcoming', 'speaker': 'Aseel Shawli (Nestlé, KSA)'},
                {'startTime': '09:30', 'endTime': '09:35', 'topic': 'Revealing Facts on Human Milk Oligosaccharides in Early Life', 'speaker': 'Dr. Mike Posner (Nestlé, Germany)'},
                {'startTime': '09:35', 'endTime': '09:45', 'topic': 'Q&A', 'speaker': 'All'},
                {'startTime': '09:45', 'endTime': '10:20', 'topic': 'Emerging Role of Probiotics in Gastrointestinal Health in Infants', 'speaker': 'Dr. Jubara Alallah (KSA)'},
                {'startTime': '10:20', 'endTime': '10:30', 'topic': 'Q&A', 'speaker': 'All'},
                {'startTime': '10:30', 'endTime': '10:45', 'topic': 'Coffee Break', 'speaker': 'All'},
                {'startTime': '10:45', 'endTime': '11:20', 'topic': 'Nutrition and Immunity: Clinical Perspectives', 'speaker': 'Dr. Rania Al-Qassim (KSA)'},
                {'startTime': '11:20', 'endTime': '11:30', 'topic': 'Q&A', 'speaker': 'All'},
                {'startTime': '11:30', 'endTime': '12:00', 'topic': 'Panel Discussion', 'speaker': 'All'},
                {'startTime': '12:00', 'endTime': '13:00', 'topic': 'Lunch Break', 'speaker': 'All'},
                {'startTime': '13:00', 'endTime': '13:35', 'topic': 'Advanced Topics in Paediatric Nutrition', 'speaker': 'Dr. Yara Mahmoud (KSA)'},
                {'startTime': '13:35', 'endTime': '13:45', 'topic': 'Q&A', 'speaker': 'All'},
                {'startTime': '13:45', 'endTime': '14:20', 'topic': 'Evidence-Based Approaches to Infant Feeding', 'speaker': 'Dr. Omar Abdullah (UAE)'},
                {'startTime': '14:20', 'endTime': '14:30', 'topic': 'Q&A', 'speaker': 'All'},
                {'startTime': '14:30', 'endTime': '15:00', 'topic': 'Closing Ceremony', 'speaker': 'All'},
              ],
            },
          ],
        },
      ];
}
