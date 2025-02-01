import 'package:flutter/material.dart';
import 'dart:io';

class NutritionDetailsSheet extends StatelessWidget {
  final File imageFile;
  final Map<String, dynamic> nutritionData;

  const NutritionDetailsSheet({
    super.key,
    required this.imageFile,
    required this.nutritionData,
  });

  @override
  Widget build(BuildContext context) {
    final nutrition = nutritionData['nutrition'] ?? {};
    final nutrients = nutrition['nutrients'] as List<dynamic>? ?? [];

    // Helper function to find nutrient value
    double getNutrientValue(String name) {
      return nutrients
          .firstWhere(
            (n) => n['name'] == name,
            orElse: () => {'amount': 0.0},
          )['amount']
          .toDouble();
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image and Title Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Thumbnail
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          imageFile,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Title and Category
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nutritionData['category'] ?? 'Food Item',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Nutrition Facts Header
                  const Text(
                    'Nutrition Facts',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  // Nutrition Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 2,
                    children: [
                      _NutritionTile(
                        label: 'Calories',
                        value: getNutrientValue('Calories').toStringAsFixed(0),
                        unit: 'kcal',
                      ),
                      _NutritionTile(
                        label: 'Protein',
                        value: getNutrientValue('Protein').toStringAsFixed(1),
                        unit: 'g',
                      ),
                      _NutritionTile(
                        label: 'Carbs',
                        value: getNutrientValue(
                          'Carbohydrates',
                        ).toStringAsFixed(1),
                        unit: 'g',
                      ),
                      _NutritionTile(
                        label: 'Fat',
                        value: getNutrientValue('Fat').toStringAsFixed(1),
                        unit: 'g',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NutritionTile extends StatelessWidget {
  final String label;
  final String value;
  final String unit;

  const _NutritionTile({
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 4),
          Text(
            '$value $unit',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
