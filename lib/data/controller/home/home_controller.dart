

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';


class HomeController extends GetxController{

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int carouselCurrentIndex = 0;
  final CarouselController carouselController = CarouselController();


  int visibleIndex = -1;

  setCurrentIndex(int index){
    carouselCurrentIndex = index;
    update();
  }

  toggleVisibility(int visibleIndex){
    if(visibleIndex==this.visibleIndex){
      this.visibleIndex = -1;
      update();
      return;
    }
    this.visibleIndex = visibleIndex;
    update();
  }

  //Language 

  changeLanguage(String langCode){

  }

}