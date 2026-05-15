class NsmWave {
  final String title;
  final String time;
  final int capacity;
  final int registered;
  final bool isFull;

  const NsmWave({
    required this.title,
    required this.time,
    required this.capacity,
    required this.registered,
    this.isFull = false,
  });

  String get capacityLabel => '$registered/$capacity Full';
}

class NsmDay {
  final int dayNumber;
  final String date;
  final List<NsmWave> waves;

  const NsmDay({
    required this.dayNumber,
    required this.date,
    required this.waves,
  });
}

class NsmData {
  static const List<NsmDay> days = [
    NsmDay(
      dayNumber: 1,
      date: 'Friday, 8 May 2026',
      waves: [
        NsmWave(
          title: '1st wave : Move from Ritz Carlton',
          time: '11:30 Am',
          capacity: 30,
          registered: 30,
          isFull: true,
        ),
        NsmWave(
          title: '2nd wave : Move from Ritz Carlton',
          time: '1:30 Pm',
          capacity: 30,
          registered: 30,
          isFull: true,
        ),
        NsmWave(
          title: '3rd wave : Move from Ritz Carlton',
          time: '3:30 Pm',
          capacity: 30,
          registered: 30,
          isFull: true,
        ),
      ],
    ),
    NsmDay(
      dayNumber: 2,
      date: 'Saturday, 9 May 2026',
      waves: [
        NsmWave(
          title: '1st wave : Move from Ritz Carlton',
          time: '1:30 Pm',
          capacity: 30,
          registered: 30,
          isFull: true,
        ),
        NsmWave(
          title: '2nd wave : Move from Ritz Carlton',
          time: '3:30 Pm',
          capacity: 30,
          registered: 30,
          isFull: true,
        ),
      ],
    ),
  ];
}
