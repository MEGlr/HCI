import 'package:flutter/material.dart';
import 'package:first_app/constants/appcolors.dart';

class cam_and_mic extends StatelessWidget {
  @override
  build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        //title: const Text('Add a product to your list',
        //    style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 80),
                child: MaterialButton(
                  onPressed: () {},
                  color: AppColors.PURPLE,
                  textColor: Colors.white,
                  child: Icon(
                    Icons.mic,
                    size: 80,
                  ),
                  padding: EdgeInsets.all(16),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: 30, right: 80),
                child: MaterialButton(
                  onPressed: () {},
                  color: AppColors.PURPLE,
                  textColor: Colors.white,
                  child: Icon(
                    Icons.camera,
                    size: 80,
                  ),
                  padding: EdgeInsets.all(16),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                )),
          ],
        ));
  }
}
