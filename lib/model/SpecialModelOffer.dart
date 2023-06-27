class SpecialModelOffer {
  var _id;
  String _productName;
  var _price;
  var _off_price;
  var _off_precent;
  String _imgUrl;
  SpecialModelOffer(this._id, this._productName, this._price, this._off_price,
      this._off_precent, this._imgUrl);
  String get imgUrl => _imgUrl;
  get id => _id;
  get price => _price;
  get off_price => _off_price;
  get off_precent => _off_precent;
  String get productName => _productName;
}
