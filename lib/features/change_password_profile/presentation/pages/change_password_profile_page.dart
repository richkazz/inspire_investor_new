
import 'package:flutter/material.dart';
import 'package:inspire_investors/features/change_password_profile/presentation/widgets/change_password_profile_control.dart';

import '../../../../widgets/widgets.dart';
import '../../data/data_source/change_Password_profile_remote_data_source.dart';
import '../../data/models/change_password_profile_model.dart';

class ChangePasswordProfilePage extends StatefulWidget {
  const ChangePasswordProfilePage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordProfilePage> createState() => _ChangePasswordProfilePageState();
}

class _ChangePasswordProfilePageState extends State<ChangePasswordProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }
}
 void submitChangePassword (ChangePasswordProfileModel model){
  print(44);
   ChangePasswordProfileRemoteDataSourceImpl().postChangePassword(model).then((value){

   });
}

Widget buildBody(BuildContext context) {
  return Stack(
    children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            // Top half
            const TopHalfDisplay(
              text1: "Welcome to Inspire Investors",
              text2: "Set new account password",
            ),
            const SizedBox(height: 35),
            // Bottom half
            const ChangePasswordProfileControl(submitChangePassword: submitChangePassword,),
          ],
        ),
      ),

    ],
  );


}