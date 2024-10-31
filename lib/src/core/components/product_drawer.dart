import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';
import 'package:flutter_products_demo/src/features/authentication/domain/model/user_model.dart';
import 'package:flutter_products_demo/src/features/authentication/presentations/components/business_components/authentication_cubit.dart';
import 'package:flutter_products_demo/src/features/authentication/presentations/components/business_components/authentication_state.dart';
import 'package:go_router/go_router.dart';

class ProductDrawer extends StatelessWidget {
  final GestureTapCallback? onLogoutTap;

  const ProductDrawer({
    this.onLogoutTap,
    super.key,
  });

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    context.go('/');
  }

  getUser() async {
    final _storage = FirebaseStorage.instance;
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;
    final user = await auth.currentUser;
    final userID = user!.uid;

    DocumentSnapshot userData = await firestore.collection("user").doc(userID).get();
    userData.data();
    return userData;

    //Reference file = _storage.ref().child("${user.displayName} + _Photo").child(userID);

    //UserModel userModel = UserModel(email: user.email ?? "email", name: user.displayName ?? "name", photoUrl: file.name);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    late UserModel userModel;

    getUser();
    return Drawer(
      backgroundColor: ApplicationColors.grey700,
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                    child: ListView(
                  shrinkWrap: false,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    const SizedBox(height: ApplicationStylesConstants.spacing16Sp),
                    ListTile(
                      title: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ApplicationColors.white,
                            width: 4.0,
                          ),
                        ),
                        child: const CircleAvatar(
                          // backgroundImage: ,
                          backgroundColor: ApplicationColors.darkBlue,
                          radius: 28,
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: ApplicationStylesConstants.spacing4Sp),
                          child: Text(
                            state.userModel?.name??"name",
                            style: textTheme.titleLarge?.copyWith(color: ApplicationColors.white),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: ApplicationColors.white,
                      indent: 16,
                      endIndent: 16,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.keyboard_return,
                        color: ApplicationColors.white,
                        size: 24,
                      ),
                      title: Text(
                        l10n.logout,
                        style: textTheme.titleMedium?.copyWith(
                          color: ApplicationColors.white,
                        ),
                      ),
                      onTap: () => logout(context),
                    ),
                  ],
                )),
              ],
            ),
          );
        }
      ),
    );
  }
}
