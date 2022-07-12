import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import '../../../../../core/app_theme.dart';
import '../../../domain/entities/profile_entity.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../settings_page.dart';
import '../../widgets/profile/text_field_widget.dart';
import '../../../../../home/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileEntitiy profile;
  File? profileImage;
  EditProfilePage({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _ProfileEditWidgetState();
}

class _ProfileEditWidgetState extends State<EditProfilePage> {
  @override
  final GlobalKey formkey = GlobalKey<FormState>();

  var picker = ImagePicker();

  String? base64Toimg;

  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.profile.name;
    emailController.text = widget.profile.email;
    phoneController.text = widget.profile.phone.toString();
    // widget.profileImage = Image.network(widget.profile.image).image;
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
              // alignment: Alignment.bottomCenter,
              children: [
                SingleChildScrollView(
                  child: Column(
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
                                  border: Border.all(
                                      width: 0.5, color: primaryColor),
                                  shape: BoxShape.circle),
                            ),
                            backgroundImage: widget.profileImage?.path != null
                                ? Image.file(widget.profileImage!).image
                                : CachedNetworkImageProvider(
                                    widget.profile.image),
                          ),
                          CircleAvatar(
                            child: IconButton(
                                onPressed: () async {
                                  final pickedFile = await picker.getImage(
                                    source: ImageSource.gallery,
                                  );

                                  if (pickedFile != null) {
                                    setState(() {
                                      widget.profileImage =
                                          File(pickedFile.path);
                                      print(pickedFile.path);
                                    });
                                  }
                                  if (widget.profileImage != null) {
                                    var bytes = File(widget.profileImage!.path)
                                        .readAsBytesSync();
                                    base64Toimg = base64Encode(bytes);
                                  } else {
                                    var bytes = File(widget.profile.image)
                                        .readAsBytesSync();
                                    base64Toimg = base64Encode(bytes);
                                  }
                                },
                                icon: const Icon(
                                  Icons.photo,
                                  color: Colors.white,
                                )),
                            radius: 20.r,
                            backgroundColor: primaryColor,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      widget.profileImage != null
                          ? Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                    onPressed: () {
                                      BlocProvider.of<ProfileBloc>(context)
                                          .add(uploadProfilePhotoEvent(
                                              profile: ProfileEntitiy(
                                        id: widget.profile.id,
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        image: base64Toimg!,
                                        points: widget.profile.points,
                                        credit: widget.profile.credit,
                                        token: widget.profile.token,
                                      )));
                                    },
                                    icon: const Icon(Icons.upload_outlined),
                                    label: const Text('Upload Photo')),
                              ),
                            )
                          : const Text(''),

                      Padding(
                        padding: EdgeInsets.all(8.0.w),
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
                      // Text('profile img ${widget.profileImage}'),
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
