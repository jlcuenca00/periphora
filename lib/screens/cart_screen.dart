import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/colors.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Map<Product, int> cartItems = {
    Product(
      name: 'Razer DeathAdder V3',
      price: 79.99,
      image: 'assets/mouse1.webp',
      category: 'Mouse',
      description: 'Ultra-lightweight ergonomic mouse for esports.',
      colors: ['#000000', '#FFFFFF', '#7F5AF0'],
    ): 1,
    Product(
      name: 'Keychron Q2 Pro',
      price: 149.99,
      image: 'assets/keyboard1.webp',
      category: 'Keyboard',
      description: 'Hot-swappable mechanical keyboard with wireless support.',
      colors: ['#FFFFFF', '#7F5AF0'],
    ): 2,
    Product(
      name: 'Ducky One 2 Mini',
      price: 109.99,
      image: 'assets/mechanical1.jpg',
      category: 'Mechanical',
      description: 'Compact 60% mechanical keyboard with RGB backlighting.',
      colors: ['#FFFFFF', '#FF0000', '#000000'],
    ): 3,
  };

  void updateQuantity(Product product, int newQty) {
    setState(() {
      if (newQty < 1) {
        cartItems.remove(product);
      } else {
        cartItems[product] = newQty;
      }
    });
  }

  void remove(Product product) {
    setState(() {
      cartItems.remove(product);
    });
  }

  double get subtotal {
    double total = 0;
    cartItems.forEach((product, qty) {
      total += product.price * qty;
    });
    return total;
  }

  static const double shippingFee = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartItems.keys.elementAt(index);
                      final qty = cartItems[product]!;
                      return Dismissible(
                        key: Key(product.name),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 24),
                          color: AppColors.error,
                          child: Icon(Icons.delete_forever, color: Colors.white, size: 32),
                        ),
                        onDismissed: (_) => remove(product),
                        child: CartItem(
                          product: product,
                          quantity: qty,
                          onQuantityChanged: (newQty) => updateQuantity(product, newQty),
                          onRemove: () => remove(product),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(color: Colors.black54, blurRadius: 10, offset: Offset(0, -3)),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildPriceRow('Subtotal', subtotal),
                      SizedBox(height: 8),
                      _buildPriceRow('Shipping', shippingFee),
                      Divider(height: 32, color: AppColors.border),
                      _buildPriceRow('Total', subtotal + shippingFee, isTotal: true),
                      SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/checkout');
                          },
                          child: Text('Proceed to Checkout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: isTotal
                ? Theme.of(context).textTheme.headlineMedium
                : Theme.of(context).textTheme.bodyLarge),
        Text('\$${amount.toStringAsFixed(2)}',
            style: isTotal
                ? Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.primary)
                : Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
