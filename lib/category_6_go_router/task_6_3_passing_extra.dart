import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Product {
  final String name;
  final double price;
  final String description;

  const Product(this.name, this.price, this.description);
}

const productCatalog = [
  Product('MacBook Pro M3', 1999.0, 'High performance workstation laptop.'),
  Product('iPhone 15 Pro', 999.0, 'Titanium design with A17 Pro chip.'),
  Product('Sony WH-1000XM5', 399.0, 'Industry-leading noise canceling headphones.'),
];

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductCatalogScreen(),
    ),
    GoRoute(
      path: '/product-details',
      builder: (context, state) {
        // Obtain product object passed via state.extra
        final product = state.extra as Product?;
        if (product == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Missing Extra')),
            body: const Center(
              child: Text(
                'Notice: state.extra was null!\n'
                '(This occurs on Flutter Web page reload because extra is in-memory only.)',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return ProductDetailScreen(product: product);
      },
    ),
  ],
);

void main() => runApp(const Task6_3App());

class Task6_3App extends StatelessWidget {
  const Task6_3App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

class ProductCatalogScreen extends StatelessWidget {
  const ProductCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog (go_router extra demo)'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        itemCount: productCatalog.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final product = productCatalog[index];
          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              child: Icon(Icons.devices),
            ),
            title: Text(product.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Pass the Product object through extra parameter
              context.push('/product-details', extra: product);
            },
          );
        },
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.teal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Back to Catalog'),
                      onPressed: () => context.pop(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
