import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card_parallax.dart';
import '../theme/colors.dart';
import '../widgets/brand_logo.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  double _currentPage = 0;

  List<Product> products = [
    Product(
      name: 'Razer DeathAdder V3',
      price: 79.99,
      image: 'assets/mouse1.webp',
      category: 'Mouse',
      description: 'Ultra-lightweight ergonomic mouse for esports.',
      colors: ['#000000', '#FFFFFF', '#7F5AF0'],
    ),
    Product(
      name: 'Keychron Q2 Pro',
      price: 149.99,
      image: 'assets/keyboard1.webp',
      category: 'Keyboard',
      description: 'Hot-swappable keyboard with wireless support.',
      colors: ['#FFFFFF', '#7F5AF0'],
    ),
    Product(
      name: 'Corsair K95 RGB Platinum',
      price: 199.99,
      image: 'assets/keyboard2.webp',
      category: 'Keyboard',
      description: 'Mechanical keyboard with dynamic RGB lighting and programmable keys.',
      colors: ['#000000', '#FFFFFF'],
    ),
    Product(
      name: 'SteelSeries Arctis 7',
      price: 149.99,
      image: 'assets/headset1.jpg',
      category: 'Audio',
      description: 'Wireless gaming headset with surround sound.',
      colors: ['#000000', '#FFFFFF'],
    ),
    Product(
      name: 'Bose QuietComfort 35 II',
      price: 299.99,
      image: 'assets/headset2.jpg',
      category: 'Audio',
      description: 'Noise-cancelling headphones with premium sound quality.',
      colors: ['#303030', '#FFFFFF'],
    ),
    Product(
      name: 'Logitech G Pro X Wireless',
      price: 129.99,
      image: 'assets/wireless1.jpg',
      category: 'Wireless',
      description: 'Professional-grade wireless gaming mouse with LIGHTSPEED technology.',
      colors: ['#000000'],
    ),
    Product(
      name: 'Apple AirPods Pro',
      price: 249.99,
      image: 'assets/wireless2.png',
      category: 'Wireless',
      description: 'Active noise cancelling wireless earbuds with transparency mode.',
      colors: ['#FFFFFF'],
    ),
    Product(
      name: 'Ducky One 2 Mini',
      price: 109.99,
      image: 'assets/mechanical1.jpg',
      category: 'Mechanical',
      description: 'Compact 60% mechanical keyboard with RGB backlighting.',
      colors: ['#FFFFFF', '#FF0000', '#000000'],
    ),
    Product(
      name: 'Anne Pro 2',
      price: 89.99,
      image: 'assets/mechanical2.jpg',
      category: 'Mechanical',
      description: 'Wireless mechanical keyboard with customizable RGB and Bluetooth.',
      colors: ['#000000', '#FFFFFF'],
    ),
    Product(
      name: 'Razer Huntsman Elite',
      price: 199.99,
      image: 'assets/rgb1.jpg',
      category: 'RGB',
      description: 'Mechanical keyboard with Razer Chroma RGB lighting.',
      colors: ['#000000', '#FFFFFF', '#7F5AF0'],
    ),
    Product(
      name: 'Corsair iCUE LS100 Smart Lighting',
      price: 79.99,
      image: 'assets/rgb2.jpg',
      category: 'RGB',
      description: 'Smart RGB lighting system with customizable effects.',
      colors: ['#000000'],
    ),
  ];

  List<Product> recentlyViewed = [
    Product(
      name: 'Logitech MX Master 3',
      price: 99.99,
      image: 'assets/mouse2.webp',
      category: 'Mouse',
      description: 'Advanced wireless mouse with ergonomic design.',
    ),
    Product(
      name: 'SteelSeries Arctis 7',
      price: 149.99,
      image: 'assets/headset1.jpg',
      category: 'Audio',
      description: 'Wireless gaming headset with surround sound.',
    ),
  ];

  final List<String> filterTags = ['Mouse', 'Keyboard', 'Audio', 'Wireless', 'Mechanical', 'RGB'];
  final Set<String> selectedTags = {};

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: 0.8);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleTag(String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);
      }
    });
  }

  List<Product> get filteredProducts {
    if (selectedTags.isEmpty) return products;
    return products.where((p) => selectedTags.contains(p.category)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: BrandLogo(size: 40),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Text(
                    'Welcome back, Alex 👋',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.primary),
                  ),
                ),

                // Filter Tags
                SizedBox(
                  height: 42,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: filterTags.length,
                    separatorBuilder: (_, __) => SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final tag = filterTags[index];
                      final isSelected = selectedTags.contains(tag);
                      return GestureDetector(
                        onTap: () => _toggleTag(tag),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary : AppColors.surface,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.6),
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    )
                                  ]
                                : null,
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              color: isSelected ? Colors.white : AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 16),

                // Featured Products Carousel
                SizedBox(
                  height: 220,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      final scale = (1 - (_currentPage - index).abs() * 0.2).clamp(0.8, 1.0);
                      return Transform.scale(
                        scale: scale,
                        child: ProductCardParallax(
                          product: product,
                          onTap: () {
                            Navigator.pushNamed(context, '/product', arguments: product);
                          },
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 24),

                // Recently Viewed
                if (recentlyViewed.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Recently Viewed',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 140,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: recentlyViewed.length,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      separatorBuilder: (_, __) => SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final product = recentlyViewed[index];
                        return ProductCardParallax(
                          product: product,
                          onTap: () {
                            Navigator.pushNamed(context, '/product', arguments: product);
                          },
                          small: true,
                        );
                      },
                    ),
                  ),
                ],

                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
