// ignore_for_file: unnecessary_breaks

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'productdetailpage.dart';
import 'recipedetailpage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> products = [];
  List<dynamic> recipes = [];
  List<dynamic> carts = [];
  List<dynamic> posts = [];
  bool isLoadingProducts = true;
  bool isLoadingRecipes = true;
  bool isLoadingCarts = true;
  bool isLoadingPosts = true;

  // Track the selected index for bottom navigation
  int _selectedIndex = 0;

  // Pagination variables
  int productPage = 0; // Start from 0 for skipping
  int recipePage = 0; // Start from 0 for skipping
  int cartPage = 0; // Start from 0 for skipping
  int postPage = 0; // Start from 0 for skipping
  final int itemsPerPage = 10; // Limit items per page

  String? errorMessage; // To store error messages

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Fetch initial products
    fetchRecipes(); // Fetch initial recipes
    fetchCarts(); // Fetch initial carts
    fetchPosts(); // Fetch initial posts
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(
          'https://dummyjson.com/products?skip=${productPage * itemsPerPage}&limit=$itemsPerPage'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          products = data['products'];
          errorMessage = null;
          isLoadingProducts = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load products';
        });
      }
    } catch (e) {
      setState(() {
        isLoadingProducts = false;
        errorMessage = 'Error fetching products: $e';
      });
    }
  }

  Future<void> fetchRecipes() async {
    try {
      final response = await http.get(Uri.parse(
          'https://dummyjson.com/recipes?skip=${recipePage * itemsPerPage}&limit=$itemsPerPage'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          recipes = data['recipes'];
          errorMessage = null;
          isLoadingRecipes = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load recipes';
        });
      }
    } catch (e) {
      setState(() {
        isLoadingRecipes = false;
        errorMessage = 'Error fetching recipes: $e';
      });
    }
  }

  Future<void> fetchCarts() async {
    try {
      final response = await http.get(Uri.parse(
          'https://dummyjson.com/carts?skip=${cartPage * itemsPerPage}&limit=$itemsPerPage'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          carts = data['carts']; // Assuming 'carts' is the key for cart data
          errorMessage = null;
          isLoadingCarts = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load carts';
        });
      }
    } catch (e) {
      setState(() {
        isLoadingCarts = false;
        errorMessage = 'Error fetching carts: $e';
      });
    }
  }

  Future<void> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(
          'https://dummyjson.com/posts?skip=${postPage * itemsPerPage}&limit=$itemsPerPage'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          posts = data['posts']; // Assuming 'posts' is the key for post data
          errorMessage = null;
          isLoadingPosts = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load posts';
        });
      }
    } catch (e) {
      setState(() {
        isLoadingPosts = false;
        errorMessage = 'Error fetching posts: $e';
      });
    }
  }

  // Display products list
  Widget _getProductsList() {
    if (isLoadingProducts) {
      return Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: products
                .map((product) => Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Image.network(product['thumbnail']),
                        title: Text(product['title']),
                        subtitle: Text('\$${product['price']}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                product: product,
                              ),
                            ),
                          );
                        },
                      ),
                    ))
                .toList(),
          ),
        ),
        _buildPaginationControls(fetchProducts, productPage, 'products')
      ],
    );
  }

  // Display recipes list
  Widget _getRecipesList() {
    if (isLoadingRecipes) {
      return Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: recipes
                .map((recipe) => Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Image.network(recipe['image']),
                        title: Text(recipe['name']),
                        subtitle:
                            Text('Prep time: ${recipe['prepTime']} minutes'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetailPage(
                                recipe: recipe,
                              ),
                            ),
                          );
                        },
                      ),
                    ))
                .toList(),
          ),
        ),
        _buildPaginationControls(fetchRecipes, recipePage, 'recipes')
      ],
    );
  }

  // Display carts list
  Widget _getCartsList() {
    if (isLoadingCarts) {
      return Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: carts
                .map((cart) => Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text('Cart ID: ${cart['id']}'),
                        subtitle: Text(
                            'Items: ${cart['items']}'), // Assuming 'items' is an array
                        onTap: () {
                          // Add functionality if needed when tapping on cart item
                        },
                      ),
                    ))
                .toList(),
          ),
        ),
        _buildPaginationControls(fetchCarts, cartPage, 'carts')
      ],
    );
  }

  // Display posts list
  Widget _getPostsList() {
    if (isLoadingPosts) {
      return Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: posts
                .map((post) => Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(post['title']),
                        subtitle: Text(post['body']),
                        onTap: () {
                          // Add functionality if needed when tapping on post item
                        },
                      ),
                    ))
                .toList(),
          ),
        ),
        _buildPaginationControls(fetchPosts, postPage, 'posts')
      ],
    );
  }

  // Pagination controls for "Previous" and "Next" buttons
  Widget _buildPaginationControls(
      Future<void> Function() fetchFunction, int currentPage, String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: currentPage > 0
                ? () {
                    setState(() {
                      if (type == 'products') productPage--;
                      if (type == 'recipes') recipePage--;
                      if (type == 'carts') cartPage--;
                      if (type == 'posts') postPage--;
                      fetchFunction();
                    });
                  }
                : null,
            child: Text('Previous'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (type == 'products') productPage++;
                if (type == 'recipes') recipePage++;
                if (type == 'carts') cartPage++;
                if (type == 'posts') postPage++;
                fetchFunction();
              });
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }

  // Logout confirmation dialog
  Future<void> _confirmLogout() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        );
      },
    );
  }

  // Bottom Navigation Bar
  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (_selectedIndex) {
      case 0:
        body = _getProductsList(); // Show products list
        break;
      case 1:
        body = _getRecipesList(); // Show recipes list
        break;
      case 2:
        body = _getCartsList(); // Show carts list
        break;
      case 3:
        body = _getPostsList(); // Show posts list
        break;
      default:
        body = _getProductsList(); // Default to products
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Products & Recipes'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _confirmLogout(); // Show confirmation dialog
            },
          ),
        ],
      ),
      body: body, // Use the selected index to display the appropriate body
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Track selected index
        onTap: _onBottomNavTapped, // Update index on tap
        selectedItemColor: Colors.blue, // Color for the selected tab
        unselectedItemColor: Colors.grey, // Color for unselected tabs
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.folder), // Icon for Products
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book), // Icon for Recipes
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), // Icon for Cart
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article), // Icon for Posts
            label: 'Posts',
          ),
        ],
      ),
    );
  }
}
