class MusicModel{
  String? title;
  String? thumb;
  String? url;
  double? size;
  double? view;
  Function? onTab;
  bool? isSelected;

  MusicModel({this.title,this.thumb,this.onTab,this.isSelected,this.url,this.size,this.view});
}