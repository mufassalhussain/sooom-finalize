import 'dart:developer';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:soom_net/models/CarModelSearch.dart';
import 'package:soom_net/models/CarModels.dart';
import '../API/api.dart';
import '../constants.dart';
import '../helper/functions.dart';
import '../l10n/locale_keys.g.dart';
import '../models/Brands.dart' as brand;
import '../models/BrandSearchModel.dart';
import '../models/CustomOrders.dart';

class SubmitSpecialRequest extends StatefulWidget {
  static const routeName = 'submit_request';
  const SubmitSpecialRequest({Key? key}) : super(key: key);

  @override
  State<SubmitSpecialRequest> createState() => _SubmitSpecialRequestState();
}

class _SubmitSpecialRequestState extends State<SubmitSpecialRequest> {
  List<brand.Data> mydata = [];
  var brands = null;
  CarModels carModels = CarModels();
  var imageValidate = false;
  var nameArabicBrand = [];
  var nameBrand = [];
  var brandIds = [];
  var pickedImag = '';
  var nameModel = [];
  var idModel = [];
  var brandSingName = 'Select Brand';
  var carModelSingName = 'Select car model';
  var loadingIndicator = false;
  var _formKey = GlobalKey<FormState>();
  TextEditingController year = TextEditingController();
  TextEditingController selectedBrand = TextEditingController();
  TextEditingController selectedModel = TextEditingController();
  TextEditingController carModel = TextEditingController();
  TextEditingController partName = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController partNumber = TextEditingController();
  TextEditingController chasisNumber = TextEditingController();
  TextEditingController productCondition = TextEditingController();
  TextEditingController productDetail = TextEditingController();

  getBrands() async {
    try {
      brands = await API().getBrands();
      for (var brand in brands.data) {
        nameBrand.add(context.locale.toString() == 'en'
            ? brand.name.toString()
            : brand.nameAr.toString());
        brandIds.add(brand.id.toString());
      }
      carModels = await API().getCarModels();

      setState(() {});
    } catch (e) {}
  }

  getFromCamera(context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 2000,
      maxHeight: 2000,
    );
    if (pickedFile != null) {
      setState(() {
        pickedImag = pickedFile.path;
      });
    }
  }

  getFromGallery(context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 2000,
      maxHeight: 2000,
    );
    if (pickedFile != null) {
      setState(() {
        pickedImag = pickedFile.path;
      });
    }
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        getFromGallery(context);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      getFromCamera(context);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    getBrands();
    pickedImag = '';
    selectedBrand.text = "0";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Column(
            children: [
              Text(
                '${LocaleKeys.custom_order.tr()}',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        body: brands != null
            ? ModalProgressHUD(
                inAsyncCall: loadingIndicator,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                controller: year,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Year is required";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Select Year"),
                                        content: Container(
                                          // Need to use container to add size constraint.
                                          width: 300,
                                          height: 300,
                                          child: YearPicker(
                                            firstDate: DateTime(
                                                DateTime.now().year - 100, 1),
                                            lastDate: DateTime(
                                                DateTime.now().year + 100, 1),
                                            initialDate: DateTime.now(),
                                            // save the selected date to _selectedDate DateTime variable.
                                            // It's used to set the previous selected date when
                                            // re-showing the dialog.
                                            selectedDate: DateTime.now(),
                                            onChanged: (DateTime dateTime) {
                                              year.text =
                                                  dateTime.year.toString();
                                              // close the dialog when year is selected.
                                              Navigator.pop(context);

                                              // Do something with the dateTime selected.
                                              // Remember that you need to use dateTime.year to get the year
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                decoration: InputDecoration(
                                    labelText: "Year",
                                    hintText: "Enter year",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    suffixIcon: Icon(Icons.date_range)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: DropdownSearch<BrandSearchModel>(
                                validator: (value) {
                                  setState(() {
                                    brandSingName = value!.name.toString();
                                  });
                                  if (selectedBrand.text.isEmpty) {
                                    return "Brand is required";
                                  }
                                  return null;
                                },
                                popupProps: PopupProps.dialog(
                                  searchFieldProps: TextFieldProps(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 12, 8, 0),
                                      labelText: "Search Brands",
                                    ),
                                  ),
                                  showSearchBox: true,
                                ),
                                onChanged: (data) {
                                  selectedBrand.text = data!.id.toString();
                                },
                                selectedItem: BrandSearchModel(
                                    id: selectedBrand.text,
                                    name: brandSingName,
                                    arabicName: ""),
                                items: [
                                  for (int i = 0; i < nameBrand.length; i++)
                                    BrandSearchModel(
                                        id: brandIds[i],
                                        name: nameBrand[i],
                                        arabicName: "")
                                ],
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                      labelText: "Select Brand"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: DropdownSearch<CarModelSearch>(
                                validator: (value) {
                                  setState(() {
                                    carModelSingName = value!.name.toString();
                                  });
                                  if (selectedModel.text.isEmpty) {
                                    return "Brand is required";
                                  }
                                  return null;
                                },
                                popupProps: PopupProps.dialog(
                                  searchFieldProps: TextFieldProps(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 12, 8, 0),
                                      labelText: "Search car model",
                                    ),
                                  ),
                                  showSearchBox: true,
                                ),
                                onChanged: (data) {
                                  selectedModel.text = data!.id.toString();
                                },
                                selectedItem: CarModelSearch(
                                  id: selectedModel.text,
                                  name: carModelSingName,
                                ),
                                items: [
                                  for (int i = 0;
                                      i < carModels.data!.length;
                                      i++)
                                    CarModelSearch(
                                      id: carModels.data![i].id.toString(),
                                      name: carModels.data![i].name.toString(),
                                    )
                                ],
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                      labelText: "Select Brand"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: partName,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Part name is required";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Part Name",
                                  hintText: "Enter part name",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  suffixIcon: Icon(Icons.wysiwyg),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Quantity is required";
                                  }
                                  return null;
                                },
                                controller: quantity,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Quantity",
                                  hintText: "Enter quantity",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  suffixIcon: Icon(Icons.shopping_bag),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Part Number is required";
                                  }
                                  return null;
                                },
                                controller: partNumber,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: "Part Number",
                                  hintText: "Enter part number",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  suffixIcon: Icon(Icons.numbers_sharp),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: chasisNumber,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Chassis number is required";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Chassis Number",
                                  hintText: "Enter chassis number",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  suffixIcon: Icon(Icons.format_list_numbered),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                controller: productCondition,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Product condition is required";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: "Product Condition",
                                  hintText: "Enter product condition",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  suffixIcon:
                                      Icon(Icons.production_quantity_limits),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                controller: productDetail,
                                maxLines: 4,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Product detail is required";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: "Product Detail",
                                  hintText: "Enter product detail",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  suffixIcon: Icon(Icons.notes),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                  height: 130,
                                  child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              showPicker(context);
                                            },
                                            child: Container(
                                                height: 100,
                                                width: 100,
                                                child: Icon(
                                                  Icons.add_a_photo,
                                                  size: 50,
                                                  color: Colors.white,
                                                ),
                                                color: kPrimaryColor),
                                          ),
                                          Stack(
                                            key: ObjectKey(1),
                                            alignment: Alignment.topRight,
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        8, 0, 0, 0),
                                                    height: 100,
                                                    width: 100,
                                                    child: pickedImag.isNotEmpty
                                                        ? Image.file(
                                                            File(pickedImag))
                                                        : Image.asset(
                                                            'assets/img_error.png')),
                                              ),
                                              // InkWell(
                                              //   onTap: () {},
                                              //   child:

                                              //    Container(
                                              //     margin: const EdgeInsets.all(3),
                                              //     decoration: BoxDecoration(
                                              //       color: Colors.grey.withOpacity(.7),
                                              //       shape: BoxShape.circle,
                                              //     ),
                                              //     alignment: Alignment.center,
                                              //     height: 22,
                                              //     width: 22,
                                              //     child:

                                              //     const Icon(
                                              //       Icons.close,
                                              //       size: 18,
                                              //       color: Colors.white,
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ))),
                            ),
                            imageValidate
                                ? Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      'Photo is required',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : SizedBox.shrink(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                    onPressed: () async {
                                      var fieldMap = {};
                                      setState(() {
                                        loadingIndicator = true;
                                      });
                                      var photo =
                                          await getBase64FormatFile(pickedImag);
                                      if (pickedImag.isEmpty) {
                                        setState(() {
                                          imageValidate = true;
                                        });
                                      } else {
                                        imageValidate = false;
                                        setState(() {});
                                      }
                                      if (_formKey.currentState!.validate() &&
                                          pickedImag.isNotEmpty) {
                                        fieldMap['part_number'] =
                                            partNumber.text;
                                        fieldMap['name'] = partName.text;
                                        fieldMap['quantity'] = quantity.text;
                                        fieldMap['price'] = "0";
                                        fieldMap['chassis_number'] =
                                            partName.text;
                                        fieldMap['product_details'] =
                                            productDetail.text;
                                        fieldMap['brand_id'] =
                                            selectedBrand.text;
                                        fieldMap['car_model_id'] =
                                            selectedModel.text;
                                        fieldMap['year'] = year.text;
                                        fieldMap['status'] = "Pending";
                                        fieldMap['image'] =
                                            "data:image/jpeg;base64,$photo";
                                        fieldMap['product_id'] = "0";
                                        fieldMap['approve_id'] = "0";
                                        fieldMap['order_number'] = 0;
                                        fieldMap['last_status'] = "Pending";
                                        fieldMap['product_type'] =
                                            productCondition.text;
                                        var status = await API()
                                            .submitSpecialRequest(fieldMap);
                                        setState(() {
                                          loadingIndicator = false;
                                        });
                                      }
                                    },
                                    icon: Icon(Icons.check),
                                    label: Text("Submit"))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Center(child: spinkit));
  }
}
