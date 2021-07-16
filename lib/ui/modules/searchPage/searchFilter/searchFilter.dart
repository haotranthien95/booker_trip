import 'package:flutter/material.dart';
import 'package:new_ecom_project/ui/modules/searchPage/searchFilter/numberPax/numberPax.dart';
import 'package:new_ecom_project/ui/modules/searchPage/searchFilter/rangePrice/rangePrice.dart';
import 'package:new_ecom_project/ui/modules/searchPage/searchFilter/typeTour/typeTourPicker.dart';

import 'datePickerFilter/datePickerFilter.dart';

class SearchFilter extends StatelessWidget {
  const SearchFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
      child: Column(
        children: [
          DatePickerFilter(),
          TypeTourPicker(),
          RangePrice(),
          NumerPax(),
          ElevatedButton(
              onPressed: () {
                print("On press search button");
              },
              child: Text("Tìm"))
        ],
      ),
    );
  }
}
