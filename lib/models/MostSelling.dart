class MostSelling {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  MostSelling(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  MostSelling.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int? id;
  String? orderId;
  String? qty;
  String? price;
  String? taxAmount;
  String? options;
  String? productId;
  String? productName;
  String? weight;
  String? restockQuantity;
  String? createdAt;
  String? updatedAt;
  String? productType;
  String? arabicProductName;
  String? timesDownloaded;
  String? image;
  ArabicDetail? arabicDetail;
  ProductsDetail? productsDetail;

  Data(
      {this.id,
      this.orderId,
      this.qty,
      this.price,
      this.taxAmount,
      this.options,
      this.productId,
      this.productName,
      this.weight,
      this.restockQuantity,
      this.createdAt,
      this.image,
      this.updatedAt,
      this.productType,
      this.arabicProductName,
      this.timesDownloaded,
      this.arabicDetail,
      this.productsDetail});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    qty = json['qty'];
    price = json['price'];
    taxAmount = json['tax_amount'];
    options = json['options'];
    productId = json['product_id'];
    productName = json['product_name'];
    weight = json['weight'];
    restockQuantity = json['restock_quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productType = json['product_type'];
    timesDownloaded = json['times_downloaded'];
    arabicProductName = json['arabic_detail']['name'];
    image = json['products_detail']['images'][0];
    arabicDetail = json['arabic_detail'] != null
        ? new ArabicDetail.fromJson(json['arabic_detail'])
        : null;
    productsDetail = json['products_detail'] != null
        ? new ProductsDetail.fromJson(json['products_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['tax_amount'] = this.taxAmount;
    data['options'] = this.options;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['weight'] = this.weight;
    data['restock_quantity'] = this.restockQuantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product_type'] = this.productType;
    data['image'] = this.image;
    data['times_downloaded'] = this.timesDownloaded;
    data['arabic_product_name'] = this.arabicProductName;
    if (this.arabicDetail != null) {
      data['arabic_detail'] = this.arabicDetail!.toJson();
    }
    if (this.productsDetail != null) {
      data['products_detail'] = this.productsDetail!.toJson();
    }
    return data;
  }
}

class ArabicDetail {
  String? langCode;
  String? ecProductsId;
  String? name;
  String? description;
  String? content;

  ArabicDetail(
      {this.langCode,
      this.ecProductsId,
      this.name,
      this.description,
      this.content});

  ArabicDetail.fromJson(Map<String, dynamic> json) {
    langCode = json['lang_code'];
    ecProductsId = json['ec_products_id'];
    name = json['name'];
    description = json['description'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang_code'] = this.langCode;
    data['ec_products_id'] = this.ecProductsId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['content'] = this.content;
    return data;
  }
}

class ProductsDetail {
  int? id;
  List<String>? images;
  String? description;
  String? content;

  ProductsDetail({this.id, this.images, this.description, this.content});

  ProductsDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = json['images'].cast<String>();
    description = json['description'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['images'] = this.images;
    data['description'] = this.description;
    data['content'] = this.content;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
