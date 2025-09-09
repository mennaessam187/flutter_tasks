// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:news_app_nti/core/utils/icons.dart';
// import 'package:news_app_nti/core/utils/image.dart';
// import 'package:news_app_nti/core/widget/elevation_button.dart';
// import 'package:news_app_nti/core/widget/textformfield.dart';
// import 'package:news_app_nti/feature/myLocation/cubit/locationCubit/location_cubit.dart';
// import 'package:news_app_nti/feature/myLocation/cubit/locationCubit/location_state.dart';

// //AIzaSyBNz4-PPme29TeKDDUgIgZf3KWG_AwBhHk
// class SearchScreen extends StatelessWidget {
//   const SearchScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => LocationCubit()..getLocation(),
//       child: SafeArea(
//         child: Scaffold(
//           body: Column(
//             children: [
//               BlocBuilder<LocationCubit, LocationState>(
//                 builder: (context, state) {
//                   if (state is LocationLoading) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (state is LocationSuccess) {
//                     return Center(
//                       child: Text(
//                         '${state.position.latitude}\n ${state.position.longitude}',
//                       ),
//                     );
//                   } else if (state is LocationError) {
//                     return Text(state.message);
//                   } else {
//                     return SizedBox();
//                   }
//                 },
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(30),
//                 child: MyTextFormField(
//                   hintText: "Menna Essam",
//                   prefixIcon: IconButton(
//                     onPressed: () {},
//                     icon: SvgPicture.asset(
//                       Appicons.profile,
//                       width: 24,
//                       height: 24,
//                     ),
//                   ),
//                 ),
//               ),

//               BlocBuilder<LocationCubit, LocationState>(
//                 builder: (context, state) {
//                   if (state is LocationLoading) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (state is LocationSuccess) {
//                     return  Expanded(
//                     child: Stack(
//                       children: [
//                         Positioned.fill(
//                           child: GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                   target: LatLng(state.position.latitude, state.position.longitude),
//                   zoom: 5,
//                 ),
//                 markers: LocationCubit.get(context).markers,
//               );
//                         ),

//                         Positioned(
//                           left: 90,
//                           right: 90,
//                           bottom: 20,

//                           child: MyElevatedButton(
//                             children: const Text(
//                               "Get Started",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             onPressed: () {
//                               Navigator.of(
//                                 context,
//                               ).pushReplacementNamed("home");
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   );

//                   } else if (state is LocationError) {
//                     return Text(state.message);
//                   } else {
//                     return SizedBox();
//                   }

//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // مهم
import 'package:news_app_nti/core/utils/icons.dart';
import 'package:news_app_nti/core/widget/elevation_button.dart';
import 'package:news_app_nti/core/widget/textformfield.dart';
import 'package:news_app_nti/feature/myLocation/cubit/locationCubit/location_cubit.dart';
import 'package:news_app_nti/feature/myLocation/cubit/locationCubit/location_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationCubit()..getLocation(),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              // الجزء الأول بيعرض الــ Lat / Lng
              BlocBuilder<LocationCubit, LocationState>(
                builder: (context, state) {
                  if (state is LocationLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is LocationSuccess) {
                    return Center(
                      child: Text(
                        'Lat: ${state.position.latitude}\nLng: ${state.position.longitude}',
                      ),
                    );
                  } else if (state is LocationError) {
                    return Text(state.message);
                  } else {
                    return const SizedBox();
                  }
                },
              ),

              Padding(
                padding: const EdgeInsets.all(30),
                child: MyTextFormField(
                  hintText: "Menna Essam",
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      Appicons.profile,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),

              // الجزء الثاني: الخريطة
              Expanded(
                child: BlocBuilder<LocationCubit, LocationState>(
                  builder: (context, state) {
                    if (state is LocationLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is LocationSuccess) {
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  state.position.latitude,
                                  state.position.longitude,
                                ),
                                zoom: 14,
                              ),
                              markers: LocationCubit.get(context).markers,
                              myLocationEnabled: true,
                            ),
                          ),
                          Positioned(
                            left: 90,
                            right: 90,
                            bottom: 20,
                            child: MyElevatedButton(
                              children: const Text(
                                "Get Started",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).pushReplacementNamed("mains");
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (state is LocationError) {
                      return Text(state.message);
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
