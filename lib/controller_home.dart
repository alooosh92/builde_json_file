import 'dart:convert';
import 'dart:io';
import 'package:builde_json_file/main.dart';
import 'package:builde_json_file/model_center.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  ModelCenter? newCenter;
  List<ModelCenter> listCenter = [];
  Future<void> getCenter(String url) async {
    try {
      String u = url.substring(url.indexOf("/d/") + 3);
      u = u.split("/").first;
      var ul = "https://drive.google.com/uc?export=view&id=$u";
      http.Response response = await http.get(Uri.parse(ul));
      if (response.statusCode == 200) {
        if (response.body == "") {
          Get.to(const HomeScreen());
        } else {
          var body = json.decode(utf8.decode(response.bodyBytes));
          for (var element in body) {
            listCenter.add(ModelCenter.fromJson(element));
          }
          Get.to(const HomeScreen());
          update();
        }
      } else {
        Get.dialog(AlertDialog(
          title: const Text("تحذير"),
          content: const Text("يوجد خطأ بالاتصال بالنت او برابط المدخل"),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text("موافق"))
          ],
        ));
      }
    } catch (e) {
      Get.dialog(AlertDialog(
        title: const Text("تحذير"),
        content: Column(
          children: [
            const Text("يوجد خطأ بالاتصال بالنت او برابط المدخل"),
            Text(
              e.toString(),
              overflow: TextOverflow.fade,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("موافق"))
        ],
      ));
    }
  }

  Future saveInStorage() async {
    List<Map<String, dynamic>> listMap = [];
    for (var element in listCenter) {
      listMap.add(element.toJson());
    }
    var d = Directory.current.path;
    File fileDef = File('$d\\file\\data.json');
    await fileDef.create(recursive: true);
    var body = jsonEncode(listMap);
    fileDef.writeAsStringSync(body, mode: FileMode.write);
  }

  void deleteCenter(ModelCenter center) {
    listCenter.remove(center);
    saveInStorage();
    update();
  }
}
