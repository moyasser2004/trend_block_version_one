import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trend/features/profile/presentation/edit_profile%20copy/EditSheet.dart';

class CustomBioTile extends StatelessWidget {
  final String bio;
  final Function(String) onBioChanged;
  final String userBio;

  const CustomBioTile({
    Key? key,
    required this.bio,
    required this.onBioChanged,
    required this.userBio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xffF9F9FC),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5),
        leading: SvgPicture.asset(
          "assets/icons/Security.svg",
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        ),
        title: Row(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Bio",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        trailing: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 58,
          child: Row(
            children: [
              Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    bio.isEmpty ? userBio : bio,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SvgPicture.asset(
                "assets/icons/chevron-small-left.svg",
                height: 20,
                width: 20,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        onTap: () async {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return EditBottomSheet(
                heightfactor: 0.5,
                line: 3,
                Lenght: 80,
                onChanged: (newbio) {
                  onBioChanged(newbio);
                },
                x: userBio,
                onCancel: () {
                  onBioChanged('');
                },
              );
            },
          );
        },
      ),
    );
  }
}
