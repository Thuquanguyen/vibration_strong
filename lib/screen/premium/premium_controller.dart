import 'dart:async';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import '../../core/base/base_controller.dart';
import '../../core/common/app_func.dart';
import '../../core/local_storage/localStorageHelper.dart';
import '../../core/model/package_model.dart';
import '../../core/model/purchasable_product.dart';
import '../../in_app_manage.dart';
import '../../routes/app_pages.dart';

class PremiumController extends BaseController {
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  final iapConnection = IAPConnection.instance;
  List<PurchasableProduct> products = [];
  RxList<PackageModel> packages = <PackageModel>[
    PackageModel(title: 'Popular', unit: 'Weekly', price: '69.000 đ'),
    PackageModel(
        title: 'Extra\n10 Days',
        unit: 'Monthly',
        price: '289.000 đ',
        isSelected: true),
    PackageModel(title: 'Best Price', unit: 'Lifetime', price: '579.000 đ'),
  ].obs;
  RxInt indexSelected = 1.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    final purchaseUpdated = iapConnection.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _onPurchaseUpdate,
      onDone: _updateStreamOnDone,
      onError: _updateStreamOnError,
    );
    loadPurchases();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _subscription.cancel();
    super.onClose();
  }

  void onChangeSelected(int index) {
    for (int i = 0; i < packages.length; i++) {
      packages[i].isSelected = false;
    }
    packages[index].isSelected = true;
    indexSelected.value = index;
    packages.refresh();
  }

  Future<void> loadPurchases() async {
    final available = await iapConnection.isAvailable();
    if (!available) {
      print("Not avaiable");
      // storeState = StoreState.notAvailable;
      // notifyListeners();
      return;
    }
    const ids = <String>{
      "premium_weekly",
      "phone_vibration_strong",
      "premium_lifetime",
    };
    final response = await iapConnection.queryProductDetails(ids);
    for (var element in response.notFoundIDs) {

      print('Purchase $element not found');
    }
    products = response.productDetails
        .map((e) => PurchasableProduct(e))
        .toList()
        .reversed
        .toList();
    products.swap(1, 2);
    if(products.length >= 3){
      for (int i = 0; i < products.length; i++) {
        packages[i].price = products[i].price;
      }
      packages.refresh();
    }
  }

  getTitle(){
    if(indexSelected.value == 0){
      return 'You have 1 week to use the advanced features of the app.';
    }else if(indexSelected.value == 1){
      return 'You have 1 month to use the advanced features of the app. In addition, you get an additional 10 days discount.';
    }
    return 'You get to use advanced features for life.';
  }

  Future<void> buy() async {

    final purchaseParam =
    PurchaseParam(productDetails: products[indexSelected.value].productDetails);
    print("product = ${products[indexSelected.value].id}");
    switch (products[indexSelected.value].id) {
      case 'premium_weekly':
      case 'phone_vibration_strong':
      case 'premium_lifetime':
        await iapConnection.buyConsumable(purchaseParam: purchaseParam);
        break;
      default:
        throw ArgumentError.value(products[indexSelected.value].productDetails,
            '${products[indexSelected.value].id} is not a known product');
    }
  }

  void openPrivacy() {
    Get.toNamed(Routes.PRIVACY);
  }

  void openTerm() {
    Get.toNamed(Routes.TERM);
  }

  void restore() {
    print("Restore");
    iapConnection.restorePurchases();
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach(_handlePurchase);
    // Handle purchases here
  }

  void _handlePurchase(PurchaseDetails purchaseDetails) {
    // print('STATUSSSS = ${purchaseDetails.status}');
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    if (purchaseDetails.status == PurchaseStatus.purchased) {
      switch (purchaseDetails.productID) {
        case 'premium_weekly':
          SharePreferencesHelper.setString(KEY_PURCHASE,
              dateFormat.format(DateTime.now().add(const Duration(days: 7))));
          Get.offAllNamed(Routes.SPLASH);
          // print("purchase premium_weekly success");
          break;
        case 'phone_vibration_strong':
          SharePreferencesHelper.setString(KEY_PURCHASE,
              dateFormat.format(DateTime.now().add(const Duration(days: 40))));
          Get.offAllNamed(Routes.SPLASH);
          // print("purchase premium_monthly success");
          break;
        case 'premium_lifetime':
          SharePreferencesHelper.setString(KEY_PURCHASE,
              dateFormat.format(DateTime.now().add(const Duration(days: 365))));
          Get.offAllNamed(Routes.SPLASH);
          // print("purchase premium_lifetime success");
          break;
      }
    } else if (purchaseDetails.status == PurchaseStatus.canceled) {
      print("purchase cancel success");
    } else if (purchaseDetails.status == PurchaseStatus.restored) {
      AppFunc.showAlertDialog(Get.context!,
          message: "Vibration PurchaseStatus Restored");
    } else if (purchaseDetails.status == PurchaseStatus.error) {
      AppFunc.showAlertDialog(Get.context!,
          message: "An error occurred, please try again!");
    }
    if (purchaseDetails.pendingCompletePurchase) {
      iapConnection.completePurchase(purchaseDetails);
    }
  }

  void _updateStreamOnDone() {
    _subscription.cancel();
  }

  void _updateStreamOnError(dynamic error) {
    //Handle error here
  }
}
extension SwappableList<E> on List<E> {
  void swap(int first, int second) {
    final temp = this[first];
    this[first] = this[second];
    this[second] = temp;
  }
}