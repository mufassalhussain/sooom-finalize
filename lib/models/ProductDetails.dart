class ProductDetail {
  int? statusCode;
  Data? data;

  ProductDetail({this.statusCode, this.data});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? description;
  String? content;
  String? status;
  List<String>? images;
  String? sku;
  String? order;
  String? quantity;
  String? allowCheckoutWhenOutOfStock;
  String? withStorehouseManagement;
  String? isFeatured;
  String? brandId;
  String? isVariation;
  String? saleType;
  String? price;
  String? salePrice;
  String? startDate;
  String? endDate;
  String? length;
  String? wide;
  String? height;
  String? weight;
  String? taxId;
  String? views;
  String? createdAt;
  String? updatedAt;
  String? stockStatus;
  String? storeId;
  String? createdById;
  String? createdByType;
  String? sellerName;
  String? sellerAvatar;
  String? approvedBy;
  String? image;
  String? productType;
  String? arabicName;
  String? arabicDesc;
  String? customerId;
  String? carModelId;
  String? year;
  String? returnAble;
  String? partNumber;
  String? engine;
  String? trim;
  String? shippingPrice;
  String? productCondition;
  String? productRating;
  List<Categories>? categories;

  Data(
      {this.id,
      this.year,
      this.engine,
      this.partNumber,
      this.trim,
      this.shippingPrice,
      this.returnAble,
      this.name,
      this.description,
      this.content,
      this.status,
      this.images,
      this.sellerAvatar,
      this.sellerName,
      this.sku,
      this.order,
      this.quantity,
      this.allowCheckoutWhenOutOfStock,
      this.withStorehouseManagement,
      this.isFeatured,
      this.brandId,
      this.carModelId,
      this.customerId,
      this.createdAt,
      this.createdById,
      this.createdByType,
      this.productCondition,
      this.productRating,
      this.storeId,
      this.isVariation,
      this.saleType,
      this.price,
      this.salePrice,
      this.startDate,
      this.endDate,
      this.length,
      this.wide,
      this.height,
      this.weight,
      this.taxId,
      this.views,
      this.updatedAt,
      this.stockStatus,
      this.approvedBy,
      this.image,
      this.productType,
      this.categories,
      this.arabicName,
      this.arabicDesc});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    customerId = json['customer_id'];
    carModelId = json['car_model_id'];
    year = json['year'];
    partNumber = json['part_number'];
    engine = json['engine'];
    trim = json['trim'];
    shippingPrice = json['shipping_price'];
    productCondition = json['product_condition'];
    productRating = json['product_rating'];
    description = json['description'];
    content = json['content'];
    status = json['status'];
    images = json['images'].cast<String>();
    sku = json['sku'];
    order = json['order'];
    quantity = json['quantity'];
    allowCheckoutWhenOutOfStock = json['allow_checkout_when_out_of_stock'];
    withStorehouseManagement = json['with_storehouse_management'];
    isFeatured = json['is_featured'];
    brandId = json['brand_id'];
    returnAble = json['returnable'];
    isVariation = json['is_variation'];
    saleType = json['sale_type'];
    price = json['price'];
    salePrice = json['sale_price'];
    startDate = json['start_date'];
    if (json['store'] != null) {
      sellerName = json['store']['customer']['name'];
      sellerAvatar = json['store']['customer']['avatar'];
    }
    endDate = json['end_date'];
    length = json['length'];
    wide = json['wide'];
    height = json['height'];
    weight = json['weight'];
    taxId = json['tax_id'];
    views = json['views'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stockStatus = json['stock_status'];
    storeId = json['store_id'];
    createdById = json['created_by_id'];
    createdByType = json['created_by_type'];
    approvedBy = json['approved_by'];
    image = json['image'];
    productType = json['product_type'];
    arabicName =
        json['arabic_detail'] != null ? json['arabic_detail']['name'] : '';
    arabicDesc = json['arabic_detail'] != null
        ? json['arabic_detail']['description']
        : '';
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['content'] = this.content;
    data['status'] = this.status;
    data['images'] = this.images;
    data['sku'] = this.sku;
    data['order'] = this.order;
    data['quantity'] = this.quantity;
    data['allow_checkout_when_out_of_stock'] = this.allowCheckoutWhenOutOfStock;
    data['with_storehouse_management'] = this.withStorehouseManagement;
    data['is_featured'] = this.isFeatured;
    data['brand_id'] = this.brandId;
    data['returnable'] = this.returnAble;
    data['is_variation'] = this.isVariation;
    data['store']['customer']['name'] = this.sellerName;
    data['store']['customer']['avatar'] = this.sellerAvatar;
    data['sale_type'] = this.saleType;
    data['price'] = this.price;
    data['sale_price'] = this.salePrice;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['length'] = this.length;
    data['wide'] = this.wide;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['tax_id'] = this.taxId;
    data['views'] = this.views;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['stock_status'] = this.stockStatus;
    data['store_id'] = this.storeId;
    data['created_by_id'] = this.createdById;
    data['created_by_type'] = this.createdByType;
    data['approved_by'] = this.approvedBy;
    data['image'] = this.image;
    data['product_type'] = this.productType;
    data['customer_id'] = this.customerId;
    data['car_model_id'] = this.carModelId;
    data['year'] = this.year;
    data['part_number'] = this.partNumber;
    data['engine'] = this.engine;
    data['trim'] = this.trim;
    data['shipping_price'] = this.shippingPrice;
    data['product_condition'] = this.productCondition;
    data['product_rating'] = this.productRating;
    data['arabic_detail']['name'] = this.arabicName;
    data['arabic_detail']['description'] = this.arabicDesc;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? categoryId;
  String? productId;
  String? categoryName;

  Categories({this.id, this.categoryId, this.productId, this.categoryName});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    productId = json['product_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['product_id'] = this.productId;
    data['category_name'] = this.categoryName;
    return data;
  }
}
