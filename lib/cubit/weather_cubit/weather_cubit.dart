import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.w) : super(WeatherLoadig());
  WeatherService w = WeatherService();
  String? cityname;
  WeatherModel? m;

  void LoadWeather({required cityName}) async {
    emit(WeatherLoadig());
    try {
      m = await w.getWeather(cityName: cityName);
      emit(WeatherSuccess());
    } catch (ex) {
      emit(WeatherFailure());
    }
  }
}
