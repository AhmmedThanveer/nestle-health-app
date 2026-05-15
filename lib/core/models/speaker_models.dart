enum SpeakerCategory { chairpersons, speakers, nestleSpeakers }

class Speaker {
  final String name;
  final String bio;
  final String imageUrl;
  final SpeakerCategory category;

  const Speaker({
    required this.name,
    required this.bio,
    required this.imageUrl,
    required this.category,
  });
}

class SpeakersData {
  static const List<Speaker> all = [
    // ── Chairpersons ─────────────────────────────────────────────
    Speaker(
      name: 'Dr. Abdulrahman Al Nemri',
      bio:
          'Professor of Pediatrics and Neonatology, College of Medicine, King Saud University / Consultant in Neonatology, King Saud University Medical City, Riyadh / Vice President of the Saudi Society of Neonatology / External examiner and visiting consultant for several Arab universities.',
      imageUrl: 'https://i.pravatar.cc/300?img=52',
      category: SpeakerCategory.chairpersons,
    ),
    Speaker(
      name: 'Dr. Ali Al Binali',
      bio:
          'Consultant Pediatric Cardiologist with over 20 years of experience. Former Head of Pediatric Cardiology at King Fahd Hospital, Jeddah. Fellow of the Royal College of Physicians and Surgeons of Canada.',
      imageUrl: 'https://i.pravatar.cc/300?img=69',
      category: SpeakerCategory.chairpersons,
    ),
    Speaker(
      name: 'Dr. Hatem El Shorbagy',
      bio:
          'Professor of Internal Medicine and Gastroenterology. Director of the Digestive Disease Center at Cairo University. Board Member of the Arab Organization for Gastroenterology.',
      imageUrl: 'https://i.pravatar.cc/300?img=57',
      category: SpeakerCategory.chairpersons,
    ),
    Speaker(
      name: 'Dr. Mohammed M.S. Jan',
      bio:
          'Professor and Consultant of Pediatric Neurology, Faculty of Medicine, King Abdulaziz University, Jeddah. Member of the Child Neurology Society and the American Academy of Neurology.',
      imageUrl: 'https://i.pravatar.cc/300?img=12',
      category: SpeakerCategory.chairpersons,
    ),

    // ── Speakers ─────────────────────────────────────────────────
    Speaker(
      name: 'Dr. Sarah Al-Rashid',
      bio:
          'Specialist in Clinical Nutrition and Dietetics. MSc Nutrition, University of Leeds. Senior Dietitian at King Faisal Specialist Hospital, Riyadh.',
      imageUrl: 'https://i.pravatar.cc/300?img=47',
      category: SpeakerCategory.speakers,
    ),
    Speaker(
      name: 'Dr. Khalid Al-Mutairi',
      bio:
          'Consultant Neonatologist, King Abdullah Specialist Children\'s Hospital, Riyadh. FRCPC. Research interests: neonatal nutrition and premature infant outcomes.',
      imageUrl: 'https://i.pravatar.cc/300?img=15',
      category: SpeakerCategory.speakers,
    ),
    Speaker(
      name: 'Dr. Fatima Al-Zoabi',
      bio:
          'Pediatric Gastroenterologist and Nutrition Specialist. Consultant at National Guard Health Affairs, Riyadh. Fellow of the European Society for Paediatric Gastroenterology.',
      imageUrl: 'https://i.pravatar.cc/300?img=32',
      category: SpeakerCategory.speakers,
    ),
    Speaker(
      name: 'Dr. Omar Al-Harbi',
      bio:
          'Consultant Endocrinologist and Diabetologist, Prince Sultan Military Medical City. Expert in paediatric diabetes management and metabolic disorders.',
      imageUrl: 'https://i.pravatar.cc/300?img=33',
      category: SpeakerCategory.speakers,
    ),

    // ── Nestlé Speakers ──────────────────────────────────────────
    Speaker(
      name: 'Dr. Marie Dupont',
      bio:
          'Global Medical Director – Infant Nutrition, Nestlé Health Science. MD PhD, University of Lausanne. Expert in early-life nutrition and long-term health outcomes.',
      imageUrl: 'https://i.pravatar.cc/300?img=5',
      category: SpeakerCategory.nestleSpeakers,
    ),
    Speaker(
      name: 'Dr. James Mitchell',
      bio:
          'Head of Clinical Nutrition Research, Nestlé Institute of Health Sciences. 15 years of research in gut microbiome and immune development in early childhood.',
      imageUrl: 'https://i.pravatar.cc/300?img=8',
      category: SpeakerCategory.nestleSpeakers,
    ),
  ];

  static List<Speaker> byCategory(SpeakerCategory category) =>
      all.where((s) => s.category == category).toList();
}
