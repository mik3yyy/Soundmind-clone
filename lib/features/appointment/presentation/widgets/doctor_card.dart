import 'package:flutter/material.dart';
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  "${doctor.firstName} ${doctor.lastName}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "₦${doctor.consultationRate}/session",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(
                      "${doctor.ratingAverage}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // Text(" (${doctor.})"),
                    Spacer(),
                    Text(
                      "${doctor.yoe}yrs experience",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ).withCustomPadding(),
          ],
        ),
      ),
    );
  }
}
