class MusicModel{
  String? title;
  String? thumb;
  String? url;
  double? size;
  int? view;
  Function? onTab;
  bool? isSelected;
  bool? isPremium;

  MusicModel({this.title,this.thumb,this.onTab,this.isSelected,this.url,this.size,this.view,this.isPremium = false});
}