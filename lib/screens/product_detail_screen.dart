import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/colors.dart';
import '../widgets/quantity_selector.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with SingleTickerProviderStateMixin {
  int quantity = 1;
  int selectedColorIndex = 0;
  int currentImageIndex = 0;

  final PageController _pageController = PageController();
  late TransformationController _transformationController;
  TapDownDetails? _doubleTapDetails;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    final position = _doubleTapDetails!.localPosition;
    final double scale = _transformationController.value.getMaxScaleOnAxis() > 1 ? 1.0 : 3.0;

    final matrix = Matrix4.identity();

    if (scale != 1.0) {
      matrix.translate(-position.dx * (scale - 1), -position.dy * (scale - 1));
      matrix.scale(scale);
    }

    _transformationController.value = matrix;
  }

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)!.settings.arguments as Product;
    final colors = product.colors ?? ['#7F5AF0'];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 320,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentImageIndex = index;
                  _transformationController.value = Matrix4.identity(); // reset zoom on page change
                });
              },
              children: [
                GestureDetector(
                  onDoubleTapDown: (details) => _doubleTapDetails = details,
                  onDoubleTap: _handleDoubleTap,
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    panEnabled: true,
                    scaleEnabled: true,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(product.image, fit: BoxFit.cover, width: double.infinity),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [0].map((idx) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 6),
                width: currentImageIndex == idx ? 14 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: currentImageIndex == idx ? AppColors.primary : AppColors.muted,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView(
                children: [
                  Text(product.name, style: Theme.of(context).textTheme.displayLarge),
                  SizedBox(height: 8),
                  Text('\$${product.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.primary)),
                  SizedBox(height: 16),
                  Text(product.description, style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(height: 24),
                  Text('Colors', style: Theme.of(context).textTheme.headlineSmall),
                  SizedBox(height: 12),
                  Row(
                    children: List.generate(colors.length, (index) {
                      Color color = _hexToColor(colors[index]);
                      bool selected = index == selectedColorIndex;
                      return GestureDetector(
                        onTap: () => setState(() => selectedColorIndex = index),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.only(right: 16),
                          width: selected ? 36 : 32,
                          height: selected ? 36 : 32,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: selected ? Border.all(color: AppColors.primary, width: 3) : null,
                            boxShadow: selected
                                ? [BoxShadow(color: AppColors.primary.withOpacity(0.5), blurRadius: 8)]
                                : null,
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 24),
                  Text('Quantity', style: Theme.of(context).textTheme.headlineSmall),
                  SizedBox(height: 12),

                  QuantitySelector(
                    quantity: quantity,
                    onChanged: (newQty) => setState(() => quantity = newQty),
                    min: 1,
                  ),

                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, -1))],
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Added $quantity item(s) to cart'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          ),
          child: Text('Add to Cart', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  Color _hexToColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
