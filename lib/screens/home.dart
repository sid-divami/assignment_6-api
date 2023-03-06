import 'package:flutter/material.dart';
import 'package:food_recipe/widgets/recipe_card.dart';

import '../models/recipe.api.dart';
import '../models/recipe.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe>? _recipes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    print("comes here ?");
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.restaurant_menu),
          const SizedBox(
            width: 10,
          ),
          const Text('Food Recipe')
        ],
      )),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _recipes?.length,
              itemBuilder: (context, index) {
                return RecipeCard(
                    title: _recipes?[index].name ?? "My Recipe",
                    cookTime: _recipes?[index].totalTime ?? "30 minutes",
                    rating: _recipes?[index].rating.toString() ?? "4.9",
                    thumbnailUrl: _recipes?[index].images ??
                        "https://lh3.googleusercontent.com/ei5eF1LRFkkcekhjdR_8XgOqgdjpomf-rda_vvh7jIauCgLlEWORINSKMRR6I6iTcxxZL9riJwFqKMvK0ixS0xwnRHGMY4I5Zw=s360");
              },
            ),
    );
  }
}
