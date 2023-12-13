import 'package:flutter/material.dart';

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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Positioned(
                bottom: 20,
                right: 20,
                child: Text(
                  'Aswanth V C',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Positioned(
                  child: Text(
                "1923-1231-1231",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 6),
              ))
            ],
          ),
        ));
  }
}
