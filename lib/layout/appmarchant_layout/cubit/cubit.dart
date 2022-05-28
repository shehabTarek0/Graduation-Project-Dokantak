import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/appmarchant_layout/cubit/states.dart';
import 'package:g_project/modules/marchant/home/mar_home.dart';
import 'package:g_project/modules/marchant/more/more_mar.dart';

class MarCubit extends Cubit<MarStates> {
  MarCubit() : super(MarInitState());
  static MarCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreen = [const MarHome(), const MarMore()];

  void changeBottom(int index) {
    currentIndex = index;
    emit(MarBottomNavState());
  }
}
