
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:share/share.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../../Ui/values/my_colors.dart';
import '../../controllers/services_controller/services_controller.dart';
import '../../data/constants/constants.dart';
import '../../data/dynamic_link.dart';
import '../../data/models/get_all_products_by_keyword/get_all_products_by_keyword.dart';
import '../Values/dimens.dart';
import '../farmer_profile_screen/farmer_profile_screen.dart';

import '../product_details/product_details.dart';
import '../product_reviews/product_reviews.dart';
import '../values/my_imgs.dart';

class SyncfusionMap extends StatefulWidget {
  List<ProductListByKeyword>? products;
  List<int>? pID;
  // String? subcatID;
  SyncfusionMap({required this.products, required this.pID});

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
          double.parse(widget.products![_currentSelectedIndex].lat.toString()),
          double.parse(widget.products![_currentSelectedIndex].lng.toString())),
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
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    final ThemeData themeData = Theme.of(context);

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
        leading: Padding(
          padding:  EdgeInsets.all(8.0.h),
          child: CircleAvatar(
            backgroundColor: MyColors.bodyBackground,
            child: IconButton(
                icon: Image.asset(
                  MyImgs.back1,
                  height: (Dimens.size22.h),
                  width: (Dimens.size25.w),
                  color: MyColors.black,
                  fit: BoxFit.cover,
                ),
                onPressed: () => Get.back(),
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
                initialMarkersCount: widget.products!.length,
                tooltipSettings: const MapTooltipSettings(
                  color: Colors.transparent,
                ),
                markerBuilder: (BuildContext context, int index) {
                  final double markerSize =
                      _currentSelectedIndex == index ? 80 : 40;
                  return MapMarker(
                    latitude:
                        double.parse(widget.products![index].lat.toString()),
                    longitude:
                        double.parse(widget.products![index].lng.toString()),
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
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2,
                                  spreadRadius: 0,
                                  color: MyColors.black.withOpacity(0.1),
                                  offset: Offset(0, 0))
                            ],
                            color: _currentSelectedIndex == index
                                ? MyColors.primaryColor
                                : MyColors.primary2,
                            borderRadius: BorderRadius.circular(100),
                            // shape: BoxShape.circle,
                            // image: DecorationImage(
                            //   image: NetworkImage("${Constants.baseUrl}/${widget.products![index].catImg}"),
                            //   fit: BoxFit.cover
                            // )
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                                padding: _currentSelectedIndex == index
                                    ? EdgeInsets.all(20)
                                    : EdgeInsets.all(10),
                                height: 40,
                                width: 40,
                                child: Image.network(
                                  "${Constants.baseUrl}/${widget.products![index].catImg}",
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.contain,
                                )),
                          ),
                        ),
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
              padding:  EdgeInsets.only(bottom: 10.h, top: 40.h),
              decoration: BoxDecoration(
                  color: MyColors.bodyBackground,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(36),
                      topLeft: Radius.circular(36))),

              /// PageView which shows the world wonder details at the bottom.
              child: PageView.builder(
                itemCount: widget.products!.length,
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
                                await Get.find<ServicesController>()
                                    .getSellerProductDetails(widget
                                        .products![index].productId
                                        .toString());
                                Get.to(() => ProductDetails(
                                      dynamicLink: false,
                                      pID: widget.pID,
                                      avgRating: double.parse(
                                          widget.products![index].avgRating!),
                                      isFavourite:
                                          widget.products![index].liked,
                                      reviews: widget
                                          .products![index].numOfReviews
                                          .toString(),
                                      sellerImage:
                                          widget.products![index].sellerImage,
                                    ));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top:10.h),
                                width: 375.w,
                                height: 172.h,

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.w)
                                  ,
                                  color: MyColors.bodyBackground,
                                  boxShadow: [
                                    BoxShadow(
                                      color: MyColors.black.withOpacity(0.1),
                                      spreadRadius: 0,
                                      blurRadius: 2,
                                      offset: Offset(0, 0),
                                    )
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(16.0.w),
                                      child: Container(
                                        width: (Dimens.size140).w,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "${Constants.baseUrl}/${widget.products![index].productImage}"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: Dimens.size12.w,
                                          top: Dimens.size20.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.find<ServicesController>()
                                                      .sellerDetailsShimmer
                                                      .value = false;
                                                  Get.find<ServicesController>()
                                                      .update();
                                                  Get.find<ServicesController>()
                                                          .sellerDetailsShimmer
                                                          .value
                                                      ? Get.log('show Shimmer')
                                                      : Get.to(() =>
                                                          FarmerProfileScreen(
                                                            id: widget
                                                                .products![
                                                                    index]
                                                                .productId
                                                                .toString(),
                                                            farmerId: widget
                                                                .products![
                                                                    index]
                                                                .sellerId
                                                                .toString(),
                                                          ));
                                                  Get.log(widget
                                                      .products![index].sellerId
                                                      .toString());
                                                  Get.find<ServicesController>()
                                                      .gettingSellerDetailsById(
                                                          widget
                                                              .products![index]
                                                              .sellerId
                                                              .toString());
                                                },
                                                child: Container(
                                                  height: 55.h,
                                                  width: 55.w,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "${Constants.baseUrl}/${widget.products![index].sellerImage!}"),
                                                          fit: BoxFit.cover)),
                                                ),
                                              ),
                                              SizedBox(
                                                width: (Dimens.size8).w,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 40.h,
                                                    width: 115.w,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: FittedBox(
                                                      child: Text(
                                                        widget.products![index]
                                                            .productName!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: true,
                                                        style: textTheme.headline3,
                                                        textAlign:
                                                            TextAlign.left,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      Get.find<
                                                              ServicesController>()
                                                          .productReviewShimmer
                                                          .value = false;
                                                      Get.find<
                                                              ServicesController>()
                                                          .update();
                                                      Get.find<ServicesController>()
                                                              .productReviewShimmer
                                                              .value
                                                          ? Get.log(
                                                              "show shimmer")
                                                          : Get.to(() =>
                                                              ProductReviews());
                                                      await Get.find<
                                                              ServicesController>()
                                                          .gettingProductReviewsById(
                                                              widget
                                                                  .products![
                                                                      index]
                                                                  .productId
                                                                  .toString());
                                                    },
                                                    child: Row(
                                                      children: [
                                                        RatingBarIndicator(
                                                          rating: double.parse(
                                                              widget
                                                                  .products![
                                                                      index]
                                                                  .avgRating!),
                                                          itemBuilder: (context,
                                                                  index) =>
                                                              Icon(
                                                            Icons.star,
                                                            color: MyColors
                                                                .primaryColor,
                                                          ),
                                                          unratedColor:
                                                              MyColors.black,
                                                          itemCount: 5,
                                                          itemSize: 16.0,
                                                          direction:
                                                              Axis.horizontal,
                                                        ),
                                                        FittedBox(
                                                          child: Text(
                                                            "(${widget.products![index].numOfReviews}) ",
                                                            style: TextStyle(
                                                                //   fontFamily: "TiemposHeadline-Regular",
                                                                color: MyColors
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Dimens.size10.h,
                                          ),

                                          // Row(
                                          //   children: [
                                          //     Icon(
                                          //       Icons.access_time,
                                          //       color: MyColors.grey
                                          //           .withOpacity(0.4),
                                          //       size: (17).w,
                                          //     ),
                                          //     SizedBox(
                                          //       width: (Dimens.size10).w,
                                          //     ),
                                          //     Text(
                                          //       '${widget.products![index].operatingHours}',
                                          //       style: TextStyle(
                                          //           fontSize:
                                          //               (Dimens.size15).sp,
                                          //           fontWeight: FontWeight.w500,
                                          //           fontStyle: FontStyle.normal,
                                          //           color: MyColors.grey
                                          //               .withOpacity(0.4)),
                                          //     )
                                          //   ],
                                          // ),

                                          SizedBox(
                                            height: (Dimens.size12).h,
                                          ),
                                          // Padding(
                                          //   padding: EdgeInsets.only(left: (28).w),
                                          //   child: Text(
                                          //     'Price : \$50',
                                          //     style: TextStyle(
                                          //         fontSize: (Dimens.size14).sp,
                                          //         fontWeight: FontWeight.w400,
                                          //         color: MyColors.black),
                                          //   ),
                                          // ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 5.w),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  MyImgs.money1,
                                                  fit: BoxFit.contain,
                                                  height: (Dimens.size20).h,
                                                  width: (Dimens.size20).w,
                                                ),
                                                SizedBox(
                                                  width: (Dimens.size6).w,
                                                ),
                                                Container(
                                                  width: Dimens.size110.w,
                                                  child: FittedBox(
                                                    child: Text(
                                                      '${widget.products![index].productPrice}',
                                                      style: textTheme.headline3,
                                                    ),
                                                  ),
                                                ),
                                                // SizedBox(width: 80,),

                                                // InkWell(
                                                //   // onTap: () => Get.to(
                                                //   //     ChatScreen(),
                                                //   //     arguments: map),
                                                //   child: Icon(
                                                //     Icons.messenger_outline,
                                                //     size: (Dimens.size18).w,
                                                //     color: MyColors.black,
                                                //   ),
                                                // ),
                                                SizedBox(
                                                  width: 17.w,
                                                ),
                                                InkWell(
                                                  // onTap: () => Get.to(
                                                  //     SearchLocationScreen()),
                                                  child: ImageIcon(
                                                    AssetImage(
                                                      MyImgs.loc1,
                                                    ),
                                                    size: 17.w,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16.w,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Get.dialog(
                                                        Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                        barrierDismissible:
                                                            false);
                                                    DynamicLinks()
                                                        .createLink(
                                                            "${widget.products![index].productId.toString()}",
                                                            "product")
                                                        .then((value) {
                                                      Get.back();
                                                      Get.log(
                                                          "your link is $value");
                                                      Share.share(value);
                                                    });
                                                  },
                                                  // showShareDialog(context,widget.products![index].productId.toString()),
                                                  child: Image.asset(
                                                    MyImgs.shareIcon,
                                                    fit: BoxFit.contain,
                                                    height: (Dimens.size19).h,
                                                    width: Dimens.size19.w,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: (Dimens.size20).h,
                            ),
                            Positioned(
                              top: (Dimens.size15).h,
                              left: (Dimens.size8).w,
                              child: Container(
                                height: (37).h,
                                width: (37).w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: MyColors.black),
                                child: Icon(
                                  widget.products![index].liked == true
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  size: Dimens.size25.w,
                                  color: MyColors.primary2,
                                ),
                              ),
                            )
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
        double.parse(widget.products![_currentSelectedIndex].lat.toString()),
        double.parse(widget.products![_currentSelectedIndex].lng.toString()),
      );
    }

    /// Updating the design of the selected marker. Please check the
    /// `markerBuilder` section in the build method to know how this is done.
    _mapController
        .updateMarkers(<int>[_currentSelectedIndex, _previousSelectedIndex]);
    _canUpdateFocalLatLng = true;
  }
}
