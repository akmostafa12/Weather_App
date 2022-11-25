import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubit/weather_cubit/weather_state.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchPage();
                }));
              },
              icon: Icon(Icons.search),
            ),
          ],
          title: Text('Weather App'),
        ),
        body: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoadig) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is WeatherSuccess) {
              return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    BlocProvider.of<WeatherCubit>(context).m!.getThemeColor(),
                    BlocProvider.of<WeatherCubit>(context)
                        .m!
                        .getThemeColor()[300]!,
                    BlocProvider.of<WeatherCubit>(context)
                        .m!
                        .getThemeColor()[100]!,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 3,
                    ),
                    Text(
                      BlocProvider.of<WeatherCubit>(context).cityname!,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'updated at : ${BlocProvider.of<WeatherCubit>(context).m!.date.hour.toString()}:${BlocProvider.of<WeatherCubit>(context).m!.date.minute.toString()}',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(BlocProvider.of<WeatherCubit>(context)
                            .m!
                            .getImage()),
                        Text(
                          BlocProvider.of<WeatherCubit>(context)
                              .m!
                              .temp
                              .toInt()
                              .toString(),
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                                'maxTemp :${BlocProvider.of<WeatherCubit>(context).m?.maxTemp.toInt()}'),
                            Text(
                                'minTemp : ${BlocProvider.of<WeatherCubit>(context).m?.minTemp.toInt()}'),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      BlocProvider.of<WeatherCubit>(context)
                          .m!
                          .weatherStateName,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(
                      flex: 5,
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'there is no weather 😔 start',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'searching now 🔍',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
