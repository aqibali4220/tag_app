import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:tag_app/utils/singleton.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PermissionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      insetPadding: EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: SizedBox(
          width: 500,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.add_location_alt_rounded,
                color: Theme.of(context).primaryColor, size: 100),
            SizedBox(height: 20.0),
            Text(
              'you_denied_location_permission',
              textAlign: TextAlign.center,
              // : robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
            SizedBox(height: 20.0),
            Row(children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(
                            width: 2, color: Theme.of(context).primaryColor)),
                    minimumSize: Size(1, 50),
                  ),
                  child: Text('close'.tr),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    await Geolocator.openAppSettings();
                    Navigator.pop(context);
                  },
                  child: Text("Setting".tr),
                ),
              )
            ]),
          ]),
        ),
      ),
    );
  }
}

Future<bool?> locationPermission() async {
  loc.Location location = loc.Location();
  // perm.PermissionStatus permissionStatus =
  // await perm.Permission.location.status;
  // print("perm.Permission Status: ${permissionStatus}");
  loc.PermissionStatus status = await location.hasPermission();
  if (status == loc.PermissionStatus.granted ||
      status == loc.PermissionStatus.grantedLimited) {
    /// checking Location Service Status
    var serviceStatus = await loc.Location().serviceEnabled();
    print("Service Status: ${serviceStatus}");

    /// if enabled get current Location;
    if (serviceStatus) {
      print("Service Enabled");
      return true;
      getCurrentLocation();
    }

    /// if not enabled ask to enable it.
    else if (!serviceStatus) {
      print("Inside Service Disabled Block");
      serviceStatus = await loc.Location().requestService();

      /// if allowed
      if (serviceStatus) {
        print("Service Enabled");
        return true;

        /// get current Location
        getCurrentLocation();
      } else if (!serviceStatus) {
        print("Service not Enabled");
        return false;

        /// else statis LatLng
      }
    }
  } else if (status == loc.PermissionStatus.denied) {
    loc.PermissionStatus status = await location.requestPermission();

    // permissionStatus = await perm.Permission.location.request();
    if (status == loc.PermissionStatus.grantedLimited ||
        status == loc.PermissionStatus.granted) {
      return true;
    } else {
      return false;
      getCurrentLocation();
    }
  } else if (status == loc.PermissionStatus.deniedForever) {
    print("Permission Permanently Denied");
    Get.dialog(PermissionDialog());
    return false;
    // update();
  }
}

Future getCurrentLocation() async {
  await locationPermission().then((value) async {
    if (value!) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      SingleToneValue.instance.currentLat = position.latitude;
      SingleToneValue.instance.currentLng = position.longitude;

      print("current lat: ${position.latitude}");
      print("current lng: ${position.longitude}");
    }
  });

  // return LatLng(lat.value, lng.value);
}
