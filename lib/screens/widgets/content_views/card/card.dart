import 'package:flutter/material.dart';
import 'package:vote/services/blockchain/voter_helper.dart';

class CardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250,
              ),
              // Background image
              Positioned(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Ink.image(
                  image: const AssetImage(
                      'src/images/background/Freebie-GradientTextures-Preview-06.webp'),
                  fit: BoxFit.cover,
                ),
              ),

              // Text overlays
              const Positioned(
                top: 20,
                left: 25,
                child: Text(
                  'VoteChain',
                  style: TextStyle(
                    color: Color.fromARGB(255, 253, 203, 39),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Positioned(
                bottom: 20,
                right: 20,
                child: Text(
                  VoterHelper.voterInfo == null
                      ? "Unknown User"
                      : "${VoterHelper.voterInfo!.personalInfo.firstName}${VoterHelper.voterInfo!.personalInfo.middleName} ${VoterHelper.voterInfo!.personalInfo.lastName}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Positioned(
                  child: Text(
                VoterHelper.voterInfo == null &&
                        VoterHelper.voterInfo!.aadharNumber.isEmpty &&
                        VoterHelper.voterInfo!.aadharNumber.length != 12
                    ? "Unknown UID"
                    : "${VoterHelper.voterInfo!.aadharNumber.substring(0, 4)}-${VoterHelper.voterInfo!.aadharNumber.substring(4, 8)}-${VoterHelper.voterInfo!.aadharNumber.substring(8, 12)}",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 6),
              ))
            ],
          ),
        ));
  }
}
