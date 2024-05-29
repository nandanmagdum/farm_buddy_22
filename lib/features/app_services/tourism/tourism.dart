import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:krishi_vikas/features/app_services/animal_husbandry/animal_view_details.dart';
import 'package:krishi_vikas/features/app_services/tourism/tourism_services.dart';
import 'package:krishi_vikas/utils/colors.dart';

class Tourism extends StatelessWidget {
  const Tourism({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Tourism")),
        body: FutureBuilder(
          future: TourismServices().getAllTourismRecords(),
          builder: (context, snapshot) {
            List data = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SpinKitCircle(color: primary_green);
            } else {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  if (snapshot.hasData) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewDetails(
                                object: data[index],
                                photo_url: data[index]['photo_url'])));
                      },
                      title: Text(data[index]["farm_name"]),
                      subtitle: Text(data[index]["description"]),
                    );
                  } else if (snapshot.hasError) {
                    return const Text("Error");
                  } else {
                    return const Text("No Data");
                  }
                },
              );
            }
          },
        ));
  }
}
