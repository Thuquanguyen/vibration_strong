class MusicModel{
  String? title;
  String? thumb;
  String? url;
  double? size;
  Function? onTab;
  bool? isPremium;
  bool? isSelected;

  MusicModel({this.title,this.thumb,this.onTab,this.isPremium,this.isSelected,this.url,this.size});
}