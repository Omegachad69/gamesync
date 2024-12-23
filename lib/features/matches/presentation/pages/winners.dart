import 'package:flutter/material.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';
import 'package:gameync/core/themes/text_style.dart';

class Winners extends StatelessWidget {
  const Winners({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Details',
          style: AppStyles.heading40Bold(size: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        const FrostedGlassBox(
            theWidth: double.infinity, theHeight: 2, theChild: SizedBox()),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 700,
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 17.0),
                    child: FrostedGlassBox(
                      theHeight: 70,
                      theWidth: double.infinity,
                      theChild: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            '$index',
                            style: AppStyles.button15(),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 50,
                            height: 70,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Spidey",
                            style: AppStyles.info14(),
                          )
                        ],
                      ),
                    ),
                  )),
        )
      ],
    );
  }
}
