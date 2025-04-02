import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/controller/profile_cubit/profile_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeProfileIcon extends StatelessWidget {
  const HomeProfileIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 185, 184, 184),
                    shape: BoxShape.circle),
                height: 35,
                width: 35,
                child: Center(
                    child: state is ProfileSuccess && state.profile.name != null
                        ? Text(
                            state.profile.name[0],
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700),
                          )
                        : const Icon(Icons.person))));
      },
    );
  }
}
