import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';

import 'package:sound_mind/features/appointment/data/models/doctor.dart';
import 'package:sound_mind/features/notification/presentation/views/notification_page.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                doctor.profilePicture!,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: (context.screenWidth / 2) - 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  AutoSizeText(
                    "${doctor.firstName} ${doctor.lastName}",
                    maxFontSize: 16,
                    minFontSize: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AutoSizeText(
                    "₦${doctor.consultationRate}/session",
                    maxLines: 1,
                    minFontSize: 8,
                    maxFontSize: 16,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          Text(
                            "${doctor.ratingAverage}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Gap(10),
                      AutoSizeText(
                        "${doctor.yoe}yrs experience",
                        minFontSize: 4,
                        maxFontSize: 16,
                        maxLines: 1,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ).withExpanded(),
                    ],
                  ),
                ],
              ).withCustomPadding(),
            ),
          ],
        ),
      ),
    );
  }
}
