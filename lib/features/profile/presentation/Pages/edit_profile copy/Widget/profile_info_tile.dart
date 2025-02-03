import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trend/features/profile/presentation/Pages/edit_profile%20copy/Widget/EditSheet.dart';

class ProfileInfoTile extends StatefulWidget {
  final String property;
  final String userpro;
  final Function(String) onChanged;
  final Function() onCancel;

  const ProfileInfoTile({
    Key? key,
    required this.property,
    required this.userpro,
    required this.onChanged,
    required this.onCancel,
  }) : super(key: key);

  @override
  _ProfileInfoTileState createState() => _ProfileInfoTileState();
}

class _ProfileInfoTileState extends State<ProfileInfoTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
        color: Color(0xffF9F9FC),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5),
        leading: Image.asset("assets/images/User.png"),
        title: Text(
          "Full Name",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Row(
            children: [
              Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 60,
                child: Row(
                  children: [
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          widget.property.isEmpty
                              ? widget.userpro
                              : widget.property,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
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
                heightfactor: 0.35,
                line: 1,
                Lenght: 30,
                x: widget.userpro,
                onChanged: (newFullName) {
                  setState(() {
                    widget.onChanged(newFullName);
                  });
                },
                onCancel: () {
                  setState(() {
                    widget.onCancel();
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
