import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeNotificationLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: lodaing.map((e) => e).toList(),
    );
  }
}

List<Widget> lodaing = List.generate(10, (index) => const LoadingWidget());

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  Widget _shimmer(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          color: Colors.white,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 246, 246, 246),
              blurRadius: 4.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
              offset: Offset(
                1.0, // Move to right 5  horizontally
                1.0, // Move to bottom 5 Vertically
              ),
            ),
          ]),
      margin: EdgeInsets.symmetric(
          vertical: 10, horizontal: MediaQuery.of(context).size.width * .04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 10,
                width: MediaQuery.of(context).size.width * .4,
                child: _shimmer(context),
              ),
              Container(
                height: 10,
                width: MediaQuery.of(context).size.width * .2,
                child: _shimmer(context),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 5,
            // width: MediaQuery.of(context).size.width * .6,
            child: _shimmer(context),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 5,
            // width: MediaQuery.of(context).size.width * .6,
            child: _shimmer(context),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 5,
            // width: MediaQuery.of(context).size.width * .6,
            child: _shimmer(context),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 5,
            // width: MediaQuery.of(context).size.width * .6,
            child: _shimmer(context),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 5,
            width: MediaQuery.of(context).size.width * .6,
            child: _shimmer(context),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 3,
          ),
          SizedBox(
            height: 3,
          ),
        ],
      ),
    );
  }
}
