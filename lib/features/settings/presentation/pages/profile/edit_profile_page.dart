import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../core/app_theme.dart';
import '../../../domain/entities/profile_entity.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../settings_page.dart';
import '../../widgets/profile/text_field_widget.dart';
import '../../../../../home/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileEntitiy profile;
  const EditProfilePage({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _ProfileEditWidgetState();
}

class _ProfileEditWidgetState extends State<EditProfilePage> {
  @override
  final GlobalKey formkey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.profile.name;
    emailController.text = widget.profile.email;
    phoneController.text = widget.profile.phone.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is LoadedupdateProfileState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.update_info_success),
            backgroundColor: primaryColor,
            duration: const Duration(seconds: 1),
          ));
          BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Form(
            key: formkey,
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                    ),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.20,
                          child: Container(
                            decoration: BoxDecoration(
                                // color: primaryColor,
                                border:
                                    Border.all(width: 0.5, color: primaryColor),
                                shape: BoxShape.circle),
                          ),
                          // radius: 75,
                          backgroundImage:
                              CachedNetworkImageProvider(widget.profile.image),
                        ),
                        CircleAvatar(
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.white,
                              )),
                          radius: 20,
                          backgroundColor: primaryColor,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFieldEditWidget(
                          isSecure: false,
                          controller: nameController,
                          label: AppLocalizations.of(context)!.name),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFieldEditWidget(
                          isSecure: false,
                          controller: phoneController,
                          label: AppLocalizations.of(context)!.phone),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFieldEditWidget(
                          isSecure: false,
                          controller: emailController,
                          label: AppLocalizations.of(context)!.email),
                    ),
                    TextButton.icon(
                        onPressed: () {
                          BlocProvider.of<ProfileBloc>(context)
                              .add(updateProfileEvent(
                                  profile: ProfileEntitiy(
                            id: widget.profile.id,
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            image: widget.profile.image,
                            points: widget.profile.points,
                            credit: widget.profile.credit,
                            token: widget.profile.token,
                          )));
                        },
                        icon: const Icon(Icons.update),
                        label: Text(AppLocalizations.of(context)!.update))
                  ],
                ),
                state is LoadingupdateProfileState
                    ? Center(
                        child: Container(
                            decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.2),
                                shape: BoxShape.circle),
                            child: const CircularProgressIndicator()),
                      )
                    : const Text('')
              ],
            ),
          ),
        );
      },
    );
  }
}
