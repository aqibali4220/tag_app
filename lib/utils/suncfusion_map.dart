import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:tag_app/utils/chat_module_by_aqib/view/chat_screen.dart';
import 'package:tag_app/utils/images.dart';
import 'package:tag_app/utils/singleton.dart';
import 'package:tag_app/utils/size_config.dart';
import 'package:tag_app/utils/text_styles.dart';
import '../controllers/general_controller.dart';
import '../widgets/progress_bar.dart';
import 'colors.dart';
import 'const.dart';
import 'get_gun_pin_data.dart';

class SyncfusionMap extends StatefulWidget {
  // String? subcatID;

  final List<dynamic> gunPins;
  const SyncfusionMap({super.key, required this.gunPins});

  @override
  State<SyncfusionMap> createState() => _SyncfusionMapState();
}

class _SyncfusionMapState extends State<SyncfusionMap> {
  late PageController _pageViewController;
  late MapTileLayerController _mapController;

  late MapZoomPanBehavior _zoomPanBehavior;

  // late List<_WonderDetails> _worldWonders;

  late int _currentSelectedIndex;
  late int _previousSelectedIndex;
  late int _tappedMarkerIndex;

  late double _cardHeight;

  late bool _canUpdateFocalLatLng;
  late bool _canUpdateZoomLevel;
  bool _isDesktop = false;

  @override
  void initState() {
    super.initState();
    _currentSelectedIndex = 0;
    _canUpdateFocalLatLng = true;
    _canUpdateZoomLevel = true;
    _mapController = MapTileLayerController();
    _zoomPanBehavior = MapZoomPanBehavior(
      minZoomLevel: 3,
      maxZoomLevel: 18,
      focalLatLng: MapLatLng(
        double.parse(SingleToneValue.instance.currentLat.toString()),
        double.parse(SingleToneValue.instance.currentLng.toString()),
      ),
      enableDoubleTapZooming: true,
    );
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    _mapController.dispose();
    // _worldWonders.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_canUpdateZoomLevel) {
      _zoomPanBehavior.zoomLevel = _isDesktop ? 5 : 16;
      _canUpdateZoomLevel = false;
    }
    _cardHeight = (MediaQuery.of(context).orientation == Orientation.landscape)
        ? (_isDesktop ? 120 : 90)
        : 250;
    _pageViewController = PageController(
        initialPage: _currentSelectedIndex,
        viewportFraction:
            (MediaQuery.of(context).orientation == Orientation.landscape)
                ? (_isDesktop ? 0.5 : 0.7)
                : 0.95);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back,
              color: black,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SfMaps(
            layers: <MapLayer>[
              MapTileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                zoomPanBehavior: _zoomPanBehavior,
                controller: _mapController,
                initialMarkersCount: widget.gunPins.length,
                tooltipSettings: const MapTooltipSettings(
                  color: Colors.transparent,
                ),
                markerBuilder: (BuildContext context, int index) {
                  final double markerSize =
                      _currentSelectedIndex == index ? 80 : 40;
                  return MapMarker(
                    latitude: double.parse(
                        widget.gunPins[index]['current_lat'].toString()),
                    longitude: double.parse(
                        widget.gunPins[index]['current_lng'].toString()),
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        if (_currentSelectedIndex != index) {
                          _canUpdateFocalLatLng = false;
                          _tappedMarkerIndex = index;
                          _pageViewController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        height: markerSize,
                        width: markerSize,
                        child: const Icon(Icons.pin_drop_sharp,
                            color: red, size: 25),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: _cardHeight,
              // width: 470,
              padding: const EdgeInsets.only(bottom: 10, top: 40),
              decoration: const BoxDecoration(
                  color: bodyBackground,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(36),
                      topLeft: Radius.circular(36))),

              /// PageView which shows the world wonder details at the bottom.
              child: PageView.builder(
                itemCount: widget.gunPins.length,
                onPageChanged: _handlePageChange,
                controller: _pageViewController,
                itemBuilder: (BuildContext context, int index) {
                  // final _WonderDetails item = _worldWonders[index];
                  return Transform.scale(
                    // scaleY:index==_currentSelectedIndex ? 1 : 0.85 ,
                    scale: index == _currentSelectedIndex ? 1 : 0.85,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Get.log("on click");
                                // Get.to(()=>GroupChatScreen(),transition: Transition.noTransition);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                width: getWidth(375),
                                height: getHeight(172),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: red.withOpacity(0.7),
                                  boxShadow: [
                                    BoxShadow(
                                      color: black.withOpacity(0.1),
                                      spreadRadius: 0,
                                      blurRadius: 2,
                                      offset: const Offset(0, 0),
                                    )
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: getWidth(15),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: CachedNetworkImage(
                                        width: getWidth(140),
                                        height: getHeight(140),
                                        imageUrl: widget.gunPins[index]
                                            ['shooter_pic'],
                                        placeholder: (context, url) =>
                                            ProgressBar(),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(no_image),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(
                                      // color: red,
                                      width: getWidth(220),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.gunPins[index]
                                                      ['describe the person']
                                                  .toString()
                                                  .capitalizeFirst
                                                  .toString(),
                                              style: kSize20WhiteW400Text
                                                  .copyWith(color: yellow),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: true,
                                            ),
                                            SizedBox(
                                              height: getHeight(8),
                                            ),
                                            Text(
                                              widget.gunPins[index]
                                                      ['where are you']
                                                  .toString()
                                                  .capitalizeFirst
                                                  .toString(),
                                              style: kSize18W600ColorBlack
                                                  .copyWith(color: yellow),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: true,
                                            ),
                                            SizedBox(
                                              height: getHeight(8),
                                            ),
                                            Text(
                                              "Situation is ${widget.gunPins[index]['describe the situation']}",
                                              style: kSize16ColorWhite.copyWith(
                                                  color: yellow),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: true,
                                            ),
                                            SizedBox(
                                              height: getHeight(8),
                                            ),
                                            Text(
                                              "I feel ${widget.gunPins[index]['do you feel safe']}",
                                              style: kSize14ColorBlack.copyWith(
                                                  color: yellow),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: true,
                                            ),
                                            FirebaseAuth.instance.currentUser!
                                                        .uid ==
                                                    widget.gunPins[index]
                                                        ['userId']
                                                ? GestureDetector(
                                                    onTap: () {
                                                      Get.to(
                                                          () => ChatScreen(
                                                              chatRoomId: widget.gunPins[index][
                                                                  'chatRoomId'],
                                                              senderUid: FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid
                                                                  .toString(),
                                                              senderName:
                                                                  Get.find<GeneralController>()
                                                                      .gunBox
                                                                      .get(
                                                                          cUserName),
                                                              receiverUid: "",
                                                              receiverName: "",
                                                              receiverDeviceToken:""),
                                                          transition: Transition.noTransition);
                                                    },
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Icon(
                                                        Icons.chat_rounded,
                                                        color: yellow,
                                                        size: getHeight(30),
                                                      ),
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      Get.to(
                                                          () => ChatScreen(
                                                              chatRoomId: widget.gunPins[index][
                                                                  'chatRoomId'],
                                                              senderUid: FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid
                                                                  .toString(),
                                                              senderName:
                                                                  Get.find<GeneralController>()
                                                                      .gunBox
                                                                      .get(
                                                                          cUserName),
                                                              receiverUid: widget
                                                                      .gunPins[index]
                                                                  ['userId'],
                                                              receiverName: widget.gunPins[index]
                                                                  ['user_name'],
                                                              receiverDeviceToken:
                                                                  widget.gunPins[index]
                                                                      ['dv_token']),
                                                          transition: Transition.noTransition);
                                                    },
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Icon(
                                                        Icons.chat_rounded,
                                                        color: yellow,
                                                        size: getHeight(30),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: (20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handlePageChange(int index) {
    /// While updating the page viewer through interaction, selected position's
    /// marker should be moved to the center of the maps. However, when the
    /// marker is directly clicked, only the respective card should be moved to
    /// center and the marker itself should not move to the center of the maps.
    if (!_canUpdateFocalLatLng) {
      if (_tappedMarkerIndex == index) {
        _updateSelectedCard(index);
      }
    } else if (_canUpdateFocalLatLng) {
      _updateSelectedCard(index);
    }
  }

  void _updateSelectedCard(int index) {
    setState(() {
      _previousSelectedIndex = _currentSelectedIndex;
      _currentSelectedIndex = index;
    });

    /// While updating the page viewer through interaction, selected position's
    /// marker should be moved to the center of the maps. However, when the
    /// marker is directly clicked, only the respective card should be moved to
    /// center and the marker itself should not move to the center of the maps.
    if (_canUpdateFocalLatLng) {
      _zoomPanBehavior.focalLatLng = MapLatLng(
        double.parse(widget.gunPins[index]['current_lat'].toString()),
        double.parse(widget.gunPins[index]['current_lng'].toString()),
      );
    }

    /// Updating the design of the selected marker. Please check the
    /// `markerBuilder` section in the build method to know how this is done.
    _mapController
        .updateMarkers(<int>[_currentSelectedIndex, _previousSelectedIndex]);
    _canUpdateFocalLatLng = true;
  }
}
