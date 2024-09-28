class ContactInformation {
  late String type;
  late String value;

  ContactInformation({
    required this.type,
    required this.value,
  });
  factory ContactInformation.fromJson(Map<String, dynamic> json) {
    return ContactInformation(
      type: json['type'],
      value: json['value'],
    );
  }
  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
      };
}

class ModelCenter {
  late int id;
  late String name;
  late String filterType;
  late String type;
  late String sector;
  late String location;
  late String mapLocation;
  late List<String> servicesProvided;
  late List<String> workingHours;
  late List<ContactInformation> contactInformation;

  ModelCenter({
    required this.id,
    required this.name,
    required this.filterType,
    required this.type,
    required this.sector,
    required this.location,
    required this.mapLocation,
    required this.servicesProvided,
    required this.workingHours,
    required this.contactInformation,
  });

  factory ModelCenter.fromJson(Map<String, dynamic> json) {
    List<ContactInformation> conInf = [];
    List<String> serPro = [];
    List<String> worHou = [];
    for (var element in json['contactInformation']) {
      conInf.add(ContactInformation.fromJson(element));
    }
    for (var element in json['servicesProvided']) {
      serPro.add(element);
    }
    for (var element in json['workingHours']) {
      worHou.add(element);
    }
    return ModelCenter(
      id: json['id'],
      name: json['name'],
      filterType: json['filterType'],
      type: json['type'],
      sector: json['sector'],
      location: json['location'],
      mapLocation: json['mapLocation'],
      servicesProvided: serPro,
      workingHours: worHou,
      contactInformation: conInf,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> conInf = [];
    for (var element in contactInformation) {
      conInf.add(element.toJson());
    }

    return {
      "id": id,
      "name": name,
      "filterType": filterType,
      "type": type,
      "sector": sector,
      "location": location,
      "mapLocation": mapLocation,
      "servicesProvided": servicesProvided,
      "workingHours": workingHours,
      "contactInformation": conInf,
    };
  }
}

class ValueDef {
  static List<String> type = ["مشفى", "مستوصف", "مركز"];
  static List<String> filterType = [
    "الخدمات الصحية",
    "الخدمات المدنية للمجالس المحلية",
    "الخدمات التعليمية",
    "الخدمات المدنية",
    "الخدمات القانونية"
  ];
  static List<String> sector = ["حكومي", "قطاع حكومي", "منظمة انسانية"];
  static List<String> contact = [
    "Phone",
    "Mobile",
    "Email",
    "Whatsapp",
    "Telegram",
    "FaceBook",
    "Instagram"
  ];
}
