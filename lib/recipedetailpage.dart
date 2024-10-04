import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  final dynamic recipe;

  const RecipeDetailPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 8),
            Image.network(recipe['image'],
            width: 100,  // Set your desired width
            height: 100, // Set your desired height
            fit: BoxFit.cover, // This ensures the image maintains its aspect ratio
            ),
            SizedBox(height: 8),
            Text(
              recipe['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Prep time: ${recipe['prepTimeMinutes']} minutes',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            
            // Handle instructions being a List
            recipe['instructions'] is List 
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (recipe['instructions'] as List<dynamic>)
                      .map((instruction) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              instruction.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                      .toList(),
                )
              : Text(
                  recipe['instructions'],
                  style: TextStyle(fontSize: 16),
                ),
          ],
        ),
      ),
    );
  }
}
