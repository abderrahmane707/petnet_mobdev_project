enum AnimalStatus { available, pending, adopted }

class Animal {
  final String id;
  final String name;
  final String species; // Dog, Cat, Bird, Rabbit...
  final String sex;
  final String size;
  final String ageLabel; // "2 years", "8 months"
  final double distanceKm;
  final AnimalStatus status;
  final bool isUrgent;
  final String? condition; // "Injured", "Abandoned"
  final String image;
  final String shelterName;
  final String location;
  final int waitingDays;
  final String health;
  final String temperament;
  final String story;

  const Animal({
    required this.id,
    required this.name,
    required this.species,
    required this.sex,
    required this.size,
    required this.ageLabel,
    required this.distanceKm,
    required this.image,
    required this.shelterName,
    required this.location,
    this.status = AnimalStatus.available,
    this.isUrgent = false,
    this.condition,
    this.waitingDays = 0,
    this.health = '',
    this.temperament = '',
    this.story = '',
  });

  String get distanceLabel => distanceKm == distanceKm.roundToDouble()
      ? '${distanceKm.toInt()} km'
      : '$distanceKm km';
}

extension AnimalFilters on Animal {
  /// Used by the species / category chips (All, Dogs, Cats, Birds, Other, Injured).
  bool matchesChip(String chip) {
    switch (chip) {
      case 'Dogs':
        return species == 'Dog';
      case 'Cats':
        return species == 'Cat';
      case 'Birds':
        return species == 'Bird';
      case 'Injured':
        return condition == 'Injured';
      case 'Other':
        return !['Dog', 'Cat', 'Bird'].contains(species);
      default:
        return true;
    }
  }
}