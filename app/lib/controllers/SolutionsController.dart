import 'dart:async';
import 'dart:convert';

import 'package:towerofhanoi/models/Movement.dart';
import 'package:towerofhanoi/util/APIDefault.dart';
import 'package:towerofhanoi/util/UtilFunctions.dart';
import 'package:towerofhanoi/util/Map+Unwrapper.dart';

class SolutionsController {

  final incodeService = "/client/incode/hanoi";

  Future<List<Movement>> getSolution(int disks) {
    final completer = Completer<List<Movement>>();
    APIDefault.instance.get(incodeService, {"disks": disks}, false)
    .then((response) {
      Map map = json.decode(UtilFunctions.bodyFromResponse(response));

      final status = map["status"];
      if(status != 1) {
        completer.completeError("Fail");
        return;
      }
      List<Movement> list = [];
      List<dynamic>? movements = map["movements"];
      movements?.forEach((mm) {
        Map m = mm;
        int disk = m.getInt("disk");
        String source = m.getString("source");
        String target = m.getString("target");
        list.add(Movement(disk, source, target));
      });
      completer.complete(list);
    });
    return completer.future;
  }

}