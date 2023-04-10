class PackageModel{
  String? title;
  String? unit;
  String? price;
  bool? isSelected;
  Function? onClick;

  PackageModel({this.title,this.unit,this.price,this.isSelected = false,this.onClick});
}