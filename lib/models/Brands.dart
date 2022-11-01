class BrandsList {
  int? statusCode;
  List<Data>? data;

  BrandsList({this.statusCode, this.data});

  BrandsList.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? nameAr;
  String? description;
  String? website;
  String? logo;
  String? status;
  String? order;
  String? isFeatured;
  String? createdAt;
  String? updatedAt;
  String? logoPath;

  Data(
      {this.id,
      this.name,
      this.nameAr,
      this.description,
      this.website,
      this.logo,
      this.status,
      this.order,
      this.isFeatured,
      this.createdAt,
      this.updatedAt,
      this.logoPath});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    description = json['description'];
    website = json['website'];
    logo = json['logo'];
    status = json['status'];
    order = json['order'];
    isFeatured = json['is_featured'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    logoPath = json['logoPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['description'] = this.description;
    data['website'] = this.website;
    data['logo'] = this.logo;
    data['status'] = this.status;
    data['order'] = this.order;
    data['is_featured'] = this.isFeatured;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['logoPath'] = this.logoPath;
    return data;
  }
}
