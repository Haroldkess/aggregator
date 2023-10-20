// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/riders/riders_detail.dart';
import '../../theme/colors.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<dynamic>? searchTerms;
  String? pageName;
  
  CustomSearchDelegate({this.searchTerms, this.pageName});
  // List<String> searchTerms = ["item", "item", "item", "item", "item", "item"];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear_rounded, color: kAccentColor),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back_ios_new_rounded, color: kAccentColor),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<dynamic> matchQuery = [];
    for (var items in searchTerms!) {
      if (items.username != null) {
        if (items.username.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(items);
        }
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        final result = matchQuery[index];
        return ListTile(
          onTap: () {
            if(pageName == "rider"){
                      Get.to(
              () => RidersDetail(
                ridersImage: "",
                ridersName: "",
                ridersPhoneNumber: "",
                noOfTrips: 0,
                onlineIndicator: Container(),
                rider: result,
              ),
              duration: const Duration(milliseconds: 300),
              fullscreenDialog: true,
              curve: Curves.easeIn,
              routeName: "Rider Details",
              preventDuplicates: true,
              popGesture: true,
              transition: Transition.downToUp,
            );
          

            }
    
          },
          title: Text(result.username),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    // for (var items in searchTerms!) {
    //   if (items.toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(items);
    //   }
    // }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
