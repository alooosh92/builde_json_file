import 'dart:math';

import 'package:builde_json_file/binding_def.dart';
import 'package:builde_json_file/controller_home.dart';
import 'package:builde_json_file/model_center.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingDef(),
      locale: const Locale('ar'),
      home: const UrlScreen(),
    );
  }
}

class UrlScreen extends StatelessWidget {
  const UrlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController url = TextEditingController();
    HomeController controllerHome = Get.find();
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: GetBuilder<HomeController>(
        init: controllerHome,
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(15),
              height: MediaQuery.sizeOf(context).height - 500,
              width: MediaQuery.sizeOf(context).width * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormDef(
                        controller: url,
                        text: "ادخل الرابط",
                        textInputType: TextInputType.url),
                    ElevatedButton(
                        onPressed: () {
                          Get.dialog(const Center(
                            child: CircularProgressIndicator(),
                          ));
                          controller.getCenter(url.text);
                        },
                        child: const Text("متابعة"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text("الصفحة الرئيسية"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.to(const CreatCenterScreen());
                  },
                  child: const Text("اضافة مركز")),
              GetBuilder<HomeController>(
                init: homeController,
                builder: (controller) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.listCenter.length,
                  itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controller.listCenter[index].name),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  ModelCenter? center = controller.listCenter
                                      .where(
                                        (element) =>
                                            element.id ==
                                            controller.listCenter[index].id,
                                      )
                                      .firstOrNull;
                                  if (center != null) {
                                    controller.deleteCenter(center);
                                  } else {
                                    Get.dialog(const AlertDialog(
                                      title: Text("تحزير"),
                                      content: Text('يوجد خطأما'),
                                    ));
                                  }
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                            const SizedBox(height: 40),
                            IconButton(
                                onPressed: () {
                                  Get.to(CreatCenterScreen(
                                    val: controller.listCenter[index],
                                  ));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.amber,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CreatCenterScreen extends StatelessWidget {
  const CreatCenterScreen({
    super.key,
    this.val,
  });
  final ModelCenter? val;
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    TextEditingController name = TextEditingController(text: val?.name);
    TextEditingController filterType =
        TextEditingController(text: val?.filterType);
    TextEditingController type = TextEditingController(text: val?.type);
    TextEditingController sector = TextEditingController(text: val?.sector);
    TextEditingController location = TextEditingController(text: val?.location);
    TextEditingController mapLocationa =
        TextEditingController(text: val?.mapLocation);
    TextEditingController saturday =
        TextEditingController(text: val?.workingHours[0]);
    TextEditingController sunday =
        TextEditingController(text: val?.workingHours[1]);
    TextEditingController monday =
        TextEditingController(text: val?.workingHours[2]);
    TextEditingController tuesday =
        TextEditingController(text: val?.workingHours[3]);
    TextEditingController wednesday =
        TextEditingController(text: val?.workingHours[4]);
    TextEditingController thursday =
        TextEditingController(text: val?.workingHours[5]);
    TextEditingController friday =
        TextEditingController(text: val?.workingHours[6]);
    TextEditingController intServ =
        TextEditingController(text: val?.servicesProvided.length.toString());
    TextEditingController intCon =
        TextEditingController(text: val?.contactInformation.length.toString());
    HomeController homeController = Get.find();
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(title: const Text("إدخال معلومات مركز")),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          height: MediaQuery.sizeOf(context).height - 100,
          width: MediaQuery.sizeOf(context).width * 0.9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormDef(controller: name, text: "اسم المركز"),
                      TextFormDef(controller: location, text: "العنوان"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropBouttonListDef(
                          controller: filterType,
                          text: "الباب",
                          list: ValueDef.filterType),
                      DropBouttonListDef(
                          controller: type, text: "النوع", list: ValueDef.type),
                      DropBouttonListDef(
                          controller: sector,
                          text: "القطاع",
                          list: ValueDef.sector),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormDef(
                          controller: mapLocationa,
                          text: "رابط العنوان على الخرائط"),
                      TextFormDef(controller: saturday, text: "دوام يوم السبت"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormDef(controller: sunday, text: "دوام يوم الاحد"),
                      TextFormDef(controller: monday, text: "دوام يوم الإثنين"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormDef(
                          controller: tuesday, text: "دوام يوم الثلاثاء"),
                      TextFormDef(
                          controller: wednesday, text: "دوام يوم الأربعاء"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormDef(
                          controller: thursday, text: "دوام يوم الخميس"),
                      TextFormDef(controller: friday, text: "دوام يوم الجمعة"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormDef(
                          controller: intServ, text: "عدد الخدمات المقدمة"),
                      TextFormDef(
                          controller: intCon, text: "عدد طرق التواصل الموجودة"),
                    ],
                  ),
                  GetBuilder<HomeController>(
                    init: homeController,
                    builder: (controller) => ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.blueAccent)),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (val == null) {
                            int i = Random().nextInt(9999999);
                            while (controller.listCenter.any(
                              (element) => element.id == i,
                            )) {
                              i = Random().nextInt(9999999);
                            }
                            controller.newCenter = ModelCenter(
                              id: i,
                              name: name.text,
                              filterType: filterType.text,
                              type: type.text,
                              sector: sector.text,
                              location: location.text,
                              mapLocation: mapLocationa.text,
                              servicesProvided: [],
                              workingHours: [
                                saturday.text,
                                sunday.text,
                                monday.text,
                                tuesday.text,
                                wednesday.text,
                                thursday.text,
                                friday.text
                              ],
                              contactInformation: [],
                            );
                            Get.to(ServicesProvidedScreen(
                              intServ: int.parse(intServ.text),
                              intCon: int.parse(intCon.text),
                            ));
                          } else {
                            controller.newCenter = ModelCenter(
                              id: val!.id,
                              name: name.text,
                              filterType: filterType.text,
                              type: type.text,
                              sector: sector.text,
                              location: location.text,
                              mapLocation: mapLocationa.text,
                              servicesProvided: [],
                              workingHours: [
                                saturday.text,
                                sunday.text,
                                monday.text,
                                tuesday.text,
                                wednesday.text,
                                thursday.text,
                                friday.text
                              ],
                              contactInformation: [],
                            );
                            Get.to(ServicesProvidedScreen(
                              intServ: int.parse(intServ.text),
                              intCon: int.parse(intCon.text),
                              val: val,
                            ));
                          }
                        }
                      },
                      child: const Text(
                        "متابعة",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DropBouttonListDef extends StatelessWidget {
  const DropBouttonListDef({
    super.key,
    required this.list,
    required this.controller,
    required this.text,
  });
  final List<String> list;
  final TextEditingController controller;
  final String text;
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> listItem = [];
    for (var element in list) {
      listItem.add(DropdownMenuItem(value: element, child: Text(element)));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        width: 325,
        child: DropdownButtonFormField(
          value: controller.text == "" ||
                  !list.any(
                    (element) => element == controller.text,
                  )
              ? null
              : controller.text,
          items: listItem,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          hint: Text(text),
          validator: (value) {
            if (value == null || value == "") {
              return "الرجاء ادخال قيمة";
            }
            return null;
          },
          onChanged: (val) {
            if (val != null) {
              controller.text = val;
            }
          },
        ),
      ),
    );
  }
}

class TextFormDef extends StatelessWidget {
  const TextFormDef({
    super.key,
    required this.controller,
    required this.text,
    this.textInputType,
    this.enabled,
  });

  final TextEditingController controller;
  final String text;
  final TextInputType? textInputType;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        width: 500,
        child: TextFormField(
          controller: controller,
          enabled: enabled,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: text,
            labelText: text,
          ),
          keyboardType: textInputType,
          validator: (value) {
            if (value == null || value == "") {
              return "الرجاء ادخال قيمة صحيحة";
            }
            return null;
          },
        ),
      ),
    );
  }
}

class ServicesProvidedScreen extends StatelessWidget {
  const ServicesProvidedScreen({
    super.key,
    required this.intCon,
    required this.intServ,
    this.val,
  });

  final int intServ;
  final int intCon;
  final ModelCenter? val;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    List<TextEditingController> listCon = [];
    for (var i = 0; i < intServ; i++) {
      if (val != null && val!.servicesProvided.length <= i) {
        listCon.add(TextEditingController());
      } else {
        listCon.add(TextEditingController(text: val?.servicesProvided[i]));
      }
    }
    HomeController homeController = Get.find();
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(title: const Text("الخدمات المقدمة")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery.sizeOf(context).width * 0.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: intServ,
                      itemBuilder: (context, index) {
                        return TextFormDef(
                            controller: listCon[index],
                            text: "الخدمة رقم : ${index + 1}");
                      },
                    ),
                    GetBuilder<HomeController>(
                      init: homeController,
                      builder: (controller) => ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.blueAccent)),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (val == null) {
                              for (var i = 0; i < intServ; i++) {
                                controller.newCenter!.servicesProvided
                                    .add(listCon[i].text);
                              }
                              Get.to(ContactInformationScreen(conInf: intCon));
                            } else {
                              for (var i = 0; i < intServ; i++) {
                                controller.newCenter!.servicesProvided
                                    .add(listCon[i].text);
                              }
                              Get.to(ContactInformationScreen(
                                conInf: intCon,
                                val: val,
                              ));
                            }
                          }
                        },
                        child: const Text(
                          "متابعة",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContactInformationScreen extends StatelessWidget {
  const ContactInformationScreen({super.key, required this.conInf, this.val});
  final int conInf;
  final ModelCenter? val;
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    List<TextEditingController> listConDro = [];
    List<TextEditingController> listConEdi = [];
    final formKey = GlobalKey<FormState>();
    for (var i = 0; i < conInf; i++) {
      listConDro
          .add(TextEditingController(text: val?.contactInformation[i].type));
      listConEdi
          .add(TextEditingController(text: val?.contactInformation[i].value));
    }
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text("معلومات التواصل"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: conInf,
                      itemBuilder: (context, index) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          DropBouttonListDef(
                              list: ValueDef.contact,
                              controller: listConDro[index],
                              text: "اختر طريقة التواصل رقم: $index"),
                          TextFormDef(
                              controller: listConEdi[index], text: "القيمة")
                        ],
                      ),
                    ),
                    GetBuilder<HomeController>(
                      init: homeController,
                      builder: (controller) => ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.blueAccent)),
                        onPressed: () {
                          for (var i = 0; i < conInf; i++) {
                            controller.newCenter!.contactInformation.add(
                                ContactInformation(
                                    type: listConDro[i].text,
                                    value: listConEdi[i].text));
                          }
                          if (!controller.listCenter.any(
                            (element) => element.id == controller.newCenter!.id,
                          )) {
                            controller.listCenter.add(controller.newCenter!);
                            controller.saveInStorage();
                            Get.off(const HomeScreen());
                          } else {
                            if (val == null) {
                              Get.dialog(AlertDialog(
                                actions: [
                                  TextButton(
                                      onPressed: () => Get.back(),
                                      child: const Text("موافق"))
                                ],
                                title: const Text("تحزير"),
                                content: const Text("يوجد عنصر مكرر"),
                              ));
                            } else {
                              controller.deleteCenter(val!);
                              controller.listCenter.add(controller.newCenter!);
                              controller.saveInStorage();
                              Get.off(const HomeScreen());
                            }
                          }
                        },
                        child: const Text(
                          "متابعة",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
