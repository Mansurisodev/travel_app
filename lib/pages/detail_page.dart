import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:travel_app/misc/colors.dart';
import 'package:travel_app/pages/cubit/app_cubit.dart';
import 'package:travel_app/pages/cubit/app_cubit_states.dart';
import 'package:travel_app/widgets/app_buttons.dart';
import 'package:travel_app/widgets/app_large_text.dart';
import 'package:travel_app/widgets/app_text.dart';
import 'package:travel_app/widgets/responsive_button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int gottenStars = 4;
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(
      builder: (context, state) {
        DetailState detail = state as DetailState;
        return Scaffold(
          body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.maxFinite,
                    height: 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("http://mark.bslmeiyu.com/uploads/" + detail.place.img),
                        // image: AssetImage("assets/images/welcome-one.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 50,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<AppCubits>(context).goHome();
                          },
                          icon: Icon(Icons.menu),
                          color: Colors.white),
                    ],
                  ),
                ),
                // images past qism
                Positioned(
                  top: 320,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Yosemite and 250 $
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppLargeText(text: detail.place.name, color: Colors.black54.withOpacity(0.8)),
                            AppLargeText(text: "\$" + detail.place.price.toString(), color: AppColors.mainColor),
                          ],
                        ),
                        SizedBox(height: 10),
                        //UZB Tashkent
                        Row(
                          children: [
                            Icon(Icons.location_on, color: AppColors.mainColor),
                            SizedBox(width: 10),
                            AppText(text: detail.place.location.toString(), color: AppColors.textColor1),
                          ],
                        ),
                        SizedBox(height: 20),
                        //Star and text
                        Row(
                          children: [
                            Wrap(
                              children: List.generate(5, (index) {
                                return Icon(Icons.star, color: index < detail.place.stars ? AppColors.starColor : AppColors.textColor2);
                              }),
                            ),
                            SizedBox(width: 10),
                            AppText(text: "(5.0)", color: AppColors.bigTextColor),
                          ],
                        ),
                        SizedBox(height: 25),
                        //People
                        AppLargeText(text: "People", color: Colors.black.withOpacity(0.8), size: 20),
                        SizedBox(height: 5),
                        // Number of people in your group
                        AppText(text: "Number of people in your group", color: AppColors.mainTextColor),
                        //Wrap 1,2,3,4,5 button
                        SizedBox(height: 10),
                        Wrap(
                          children: List.generate(5, (index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: AppButton(
                                  size: 50,
                                  color: selectedIndex == index ? Colors.white : Colors.black,
                                  backgroundColor: selectedIndex == index ? Colors.black : AppColors.buttonBackground,
                                  borderColor: selectedIndex == index ? Colors.black : AppColors.buttonBackground,
                                  text: (index + 1).toString(),
                                  // icon: false,
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: 20),
                        AppLargeText(text: "Description", color: Colors.black.withOpacity(0.9), size: 20),
                        SizedBox(height: 10),
                        AppText(text: detail.place.description, color: AppColors.mainTextColor),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    children: [
                      AppButton(
                        size: 60,
                        color: AppColors.textColor2,
                        backgroundColor: Colors.white,
                        borderColor: AppColors.textColor2,
                        isIcons: true,
                        icon: Icons.favorite_border,
                      ),
                      SizedBox(width: 20),
                      ResponsiveButton(
                        isResponse: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
