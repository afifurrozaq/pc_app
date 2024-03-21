import '../entities/macros_entity.dart';

class Macros {
  int calories;
  int proteins;
  int fat;
  int carb;

  Macros({
    required this.calories,
    required this.proteins,
    required this.fat,
    required this.carb,
  });

  MacrosEntity toEntity() {
    return MacrosEntity(
      calories: calories,
      proteins: proteins,
      fat: fat,
      carb: carb,
    );
  }

  static Macros fromEntity(MacrosEntity entity) {
    return Macros(
        calories: entity.calories,
        proteins: entity.proteins,
        fat: entity.fat,
        carb: entity.carb);
  }
}
