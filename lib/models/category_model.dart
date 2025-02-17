
import '../core/theme/app_theme.dart';

class Categories {
  List<CategoryModel>? data;
  int? status;
  String? message;
  String? hash;

  Categories({this.data, this.status, this.message, this.hash});

  Categories.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryModel>[];
      json['data'].forEach((v) {
        data!.add(CategoryModel.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
    hash = json['hash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['message'] = message;
    data['hash'] = hash;
    return data;
  }
}

class CategoryModel {
  String? image;
  String? id;
  String? name;
  int? sort;
  int? type;
  String? typeLabel;
  String? createdAt;
  String? updatedAt;
  String? color;
  String? bgColor;
  String? borderColor;

  int get backgroundColor => int.tryParse(color?.replaceAll("#", "0XFF") ?? graySwatch.shade600.toARGB32().toString()) ?? 0;

  CategoryModel(
      {this.image,
      this.id,
      this.name,
      this.sort,
      this.type,
      this.typeLabel,
      this.createdAt,
      this.updatedAt,
      this.color,
      this.bgColor,
      this.borderColor});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    id = json['id'].toString();
    name = json['name'];
    sort = json['sort'];
    type = json['type'];
    typeLabel = json['type_label'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    color = json['color'];
    bgColor = json['bg_color'];
    borderColor = json['border_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['id'] = id;
    data['name'] = name;
    data['sort'] = sort;
    data['type'] = type;
    data['type_label'] = typeLabel;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['color'] = color;
    data['bg_color'] = bgColor;
    data['border_color'] = borderColor;
    return data;
  }
}
