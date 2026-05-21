import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String _proProductId = 'dawamy_pro_monthly';

class PurchaseService {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  bool _initialized = false;

  bool get isAvailable => _initialized;

  Future<void> initialize() async {
    final available = await _inAppPurchase.isAvailable();
    _initialized = available;
  }

  Stream<List<PurchaseDetails>> get purchaseStream =>
      _inAppPurchase.purchaseStream;

  Future<ProductDetails?> getProductDetails() async {
    if (!_initialized) return null;
    final response = await _inAppPurchase.queryProductDetails(
      {_proProductId},
    );
    if (response.productDetails.isEmpty) return null;
    return response.productDetails.first;
  }

  Future<bool> purchasePro() async {
    if (!_initialized) return false;
    final details = await getProductDetails();
    if (details == null) return false;
    await _inAppPurchase.buyNonConsumable(
      purchaseParam: PurchaseParam(productDetails: details),
    );
    return true;
  }

  Future<void> restorePurchases() async {
    if (!_initialized) return;
    await _inAppPurchase.restorePurchases();
  }
}

final purchaseServiceProvider = Provider<PurchaseService>((ref) {
  return PurchaseService();
});
