import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/constant.dart';
import 'package:ghena_alshaam/core/state/base_state.dart';
import 'package:ghena_alshaam/core/validate/validation.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/cities_cubit.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/make_offer_cubit.dart';
import 'package:ghena_alshaam/modules/widgets/custom_Loading.dart';
import 'package:ghena_alshaam/modules/widgets/custom_dropdown.dart';
import 'package:ghena_alshaam/modules/widgets/custom_text.dart';
import 'package:ghena_alshaam/modules/widgets/text_field/custom_text_field.dart';
import 'package:ghena_alshaam/modules/widgets/text_field/text_field_tap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

class MakeOfferForm extends StatefulWidget {
  const MakeOfferForm({Key? key}) : super(key: key);

  @override
  State<MakeOfferForm> createState() => _MakeOfferFormState();
}

class _MakeOfferFormState extends State<MakeOfferForm> {
  PickResult? selectedPlace;
  Color color = kLightTextColor;
  String? SelectedPaymentType;
  double total = 0.0;
  List<String?>? paymentType = ['الدفع عند الاستلام'];

  @override
  void initState() {
    BlocProvider.of<CitiesCubit>(context).onGetCities(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = MakeOfferCubit.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Form(
        key: cubit.makeOfferKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleText(text: "المدن", fontSize: 14),
            BlocBuilder<CitiesCubit, BaseState>(
              builder: (context, state) {
                final city_cubit = CitiesCubit.of(context);
                return state is LoadingState
                    ? const CustomLoading()
                    : city_cubit.citiesModel == null
                    ? Center(child: MainText(text: "حدث خطأ ما يرجي المحاولة مرة اخري", fontSize: 15))
                    : CustomDropDown(
                  hint: "اختر المدينة",
                  value: cubit.cityName,
                  items: city_cubit.citiesModel!.data?.map(
                        (ele) =>
                        DropdownMenuItem(
                          child: SingleText(text: ele.city, fontSize: 14),
                          value: ele.city,
                        ),
                  ).toList(),
                  onChanged: (val) {
                    print("value    ${val}");
                    cubit.cityName = val.toString();
                    for (int i = 0; i < city_cubit.citiesModel!.data!.length; i++) {
                      if (city_cubit.citiesModel!.data![i].city == val.toString()) {
                        cubit.cityId = city_cubit.citiesModel!.data![i].id;
                      }
                    }
                    print(cubit.cityId);
                    setState(() {});
                  },
                );
              },
            ),


            Divider(height: 20),
            SingleText(text: "الاسم", fontSize: 14),
            CustomTextField(
              controller: cubit.nameController,
              hint: "اسم المستخدم",
              inputType: TextInputType.name,
              validate: Validations.name,
              verticalPadding: 5,
            ),


            SizedBox(height: 15),
            SingleText(text: "رقم الهاتف", fontSize: 14),
            CustomTextField(
              controller: cubit.phoneController,
              hint: "050xxxxxxx",
              inputType: TextInputType.phone,
              validate: Validations.phone,
              verticalPadding: 5,
            ),


            SizedBox(height: 15),
            SingleText(text: "عنوانك", fontSize: 14),
            CustomTextField(
              controller:
              cubit.addressController,
              hint: "عنوانك بالتفصيل",
              inputType: TextInputType.text,
              validate: Validations.any,
              verticalPadding: 5,
            ),


            SizedBox(height: 15),
            SingleText(text: "موقعك", fontSize: 14),
            CustomTextFieldTap(
              verticalPadding: 5,
              hintColor: color,
              label: selectedPlace == null ? "موقعك الحالي" : selectedPlace!.formattedAddress,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlacePicker(
                      //AIzaSyBsGwp19k_0lr31Hnyos-OPLdJ9FwTO6k4
                      //AIzaSyBedHW8DNb7CXNjHjdf0MB4DNU51E20VW0
                      apiKey:
                      "AIzaSyAyhVG7B9FUmg-urb3TZBtDSTB2aXHVFCg",
                      initialPosition:
                      const LatLng(23.8859, 45.0792),
                      enableMyLocationButton: true,
                      selectInitialPosition: true,
                      useCurrentLocation: true,
                      onPlacePicked: (value) {
                        setState(() {
                          selectedPlace = value;
                          color = kPrimaryColor;
                        });
                        cubit.lat = value.geometry?.location.lat;
                        cubit.lng = value.geometry?.location.lng;
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                );
              },
            ),


            SizedBox(height: 15),
            SingleText(text: "وسيلة الدفع", fontSize: 14),
            CustomDropDown(
              hint: "اختر وسية الدفع",
              value: SelectedPaymentType,
              items: paymentType?.map(
                    (ele) => DropdownMenuItem(
                  child: SingleText(text: ele, fontSize: 14),
                  value: ele,
                ),
              ).toList(),
              onChanged: (val) {
                setState(() => SelectedPaymentType = val);
                cubit.payment_type = val;
              },
            ),


            SizedBox(height: 15),
            SingleText(text: "اضف ملاحظات", fontSize: 14),
            CustomTextField(
              controller: cubit.noteController,
              hint: "ملاحظات",
              inputType: TextInputType.text,
              lines: 7,
              verticalPadding: 5,
            ),
          ],
        ),
      ),
    );
  }
}
