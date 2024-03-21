class MacrosEntity {
  int calories;
  int proteins;
  int fat;
  int carb;

  MacrosEntity({
    required this.calories,
    required this.proteins,
    required this.fat,
    required this.carb,
  });


  Map<String, Object?> toDocument() {
    return {
      'calories': calories,
      'proteins': proteins,
      'fat': fat,
      'carb':carb,
    };
  }

  static MacrosEntity fromDocument(Map<String, dynamic> doc) {
    return MacrosEntity(
      calories: doc['calories'],
      proteins: doc['proteins'],
      fat: doc['fat'],
      carb: doc['carb'],
    );
  }
}
