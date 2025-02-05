import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../shared/const/colors.dart';
import '../../../../../shared/style/app_styles.dart';
import '../../../../../shared/utiles/routes.dart';

class ExploreSearchAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final VoidCallback onSearchPressed;
  final TextEditingController textController;

  const ExploreSearchAppBar(
      {Key? key,
      required this.onSearchPressed,
      required this.textController})
      : super(key: key);

  @override
  _ExploreSearchViewState createState() => _ExploreSearchViewState();

  @override
  Size get preferredSize => const Size.fromHeight(55);
}

class _ExploreSearchViewState extends State<ExploreSearchAppBar> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    widget.textController
        .dispose(); // Dispose of the controller when the widget is destroyed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 93,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          child: Row(
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: IconButton(
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                        // Navigator.pushNamed(context, AppRoutes.home);
                      }
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 28,
                      color: Color(AppColors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 8,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: widget.textController,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      prefixIcon: const Icon(
                        FontAwesomeIcons.search,
                        size: 16,
                        color: Colors.black,
                      ),
                      hintText: 'Search',
                      hintStyle: AppStyles.styleNormal13.copyWith(
                        color: const Color(AppColors.greyDark),
                      ),
                      fillColor: const Color(AppColors.greyLighter)
                          .withOpacity(0.2),
                      filled: true,
                      enabledBorder: _buildOutlineInputBorder(),
                      disabledBorder: _buildOutlineInputBorder(),
                      errorBorder: _buildOutlineInputBorder(),
                      focusedBorder: _buildOutlineInputBorder(),
                    ),
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    onEditingComplete: () {
                      widget
                          .onSearchPressed(); // ✅ Correct function call
                      FocusManager.instance.primaryFocus
                          ?.unfocus(); // Unfocus the search field
                    },
                    onFieldSubmitted: (_) {
                      // widget
                      //     .onSearchPressed(); // ✅ Correct function call
                      // FocusManager.instance.primaryFocus
                      //     ?.unfocus(); // Unfocus the search field
                    },
                    onChanged: (_) => _formKey.currentState
                        ?.validate(), // ✅ Correct function call
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: const BorderSide(color: Color(AppColors.greyLight)),
    );
  }
}
