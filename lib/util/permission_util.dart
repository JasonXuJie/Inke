//import 'package:permission_handler/permission_handler.dart';
//import 'dart:async';
//import 'dart:io';
//class PermissionUtil{
//
//
//
//  static requestPermission(List<PermissionGroup> permissions,{Function granted,Function denied})async{
//    var stateCount = 0;
//    Map<PermissionGroup, PermissionStatus> permission = await PermissionHandler().requestPermissions(permissions);
//    permission.forEach((permissionGroup,state){
//        if(state==PermissionStatus.granted){
//          stateCount++;
//          if(stateCount==permissions.length){
//            granted();
//          }
//        }else{
//          denied();
//        }
//    });
//
//  }
//
//
//  static checkPermission(PermissionGroup permission,{Function noAllow,Function allowed})async{
//    PermissionStatus checkState = await PermissionHandler().checkPermissionStatus(permission);
//    if(checkState==PermissionStatus.unknown||checkState==PermissionStatus.denied){
//       noAllow();
//    }else{
//      allowed();
//    }
//  }
//
//
//
//
//  static Future<bool> openSettings()async{
//   bool isOpen = await PermissionHandler().openAppSettings();
//   return isOpen;
//  }
//
//}




