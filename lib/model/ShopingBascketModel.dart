class ShopingBascketModel {
  List<String>? _imgUrls;
  List<String>? _productOffPrices;
  List<String>? _productNames;
  ShopingBascketModel(
      this._imgUrls, this._productNames, this._productOffPrices);
  List<String>? get imgUrls => _imgUrls;
  List<String>? get productOffPrices => _productOffPrices;
  List<String>? get productNames => _productNames;
}
