import 'package:sales_app/data/database.dart';

class ProductsRepository {
  final AppDatabase database;

  ProductsRepository(this.database);

  Future<List<ProductData>> getProducts() async {
    return await database.select(database.product).get();
  }

  Future<void> addProduct(
      String name, String category, double price, int stock) {
    return database.into(database.product).insert(ProductCompanion.insert(
        name: name, category: category, price: price, stock: stock));
  }

  Future<void> updateProduct(ProductData product, String name, String category,
      double price, int stock) async {
    await database.update(database.product).replace(product.copyWith(
        name: name, category: category, price: price, stock: stock));
  }

  Future<void> deleteProduct(ProductData product) async {
    await database.delete(database.product).delete(product);
  }
}
