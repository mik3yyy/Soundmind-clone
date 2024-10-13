import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/list_extensions.dart';

class ComplexShimmer {
  static Widget therapistProfileShimmer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Circular profile picture shimmer
        Container(
          width: context.screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            color: Color(0xFFF3EEFA),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeShimmer.round(
                size: 100,
                fadeTheme: FadeTheme.light,
                millisecondsDelay: 0,
                baseColor: const Color(0xFFE0E0E0),
                highlightColor: const Color(0xFFF5F5F5),
              ),
              const SizedBox(height: 16),

              // Name and experience shimmers
              const FadeShimmer(
                height: 12,
                width: 150,
                radius: 4,
                fadeTheme: FadeTheme.light,
                millisecondsDelay: 100,
                baseColor: Color(0xFFE0E0E0),
                highlightColor: Color(0xFFF5F5F5),
              ),
              const SizedBox(height: 8),

              // Experience, Patients, Reviews shimmers (in a row)
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Experience shimmer
                  FadeShimmer(
                    height: 12,
                    width: 50,
                    radius: 4,
                    fadeTheme: FadeTheme.light,
                    millisecondsDelay: 150,
                    baseColor: Color(0xFFE0E0E0),
                    highlightColor: Color(0xFFF5F5F5),
                  ),
                  // Patients shimmer
                  FadeShimmer(
                    height: 12,
                    width: 50,
                    radius: 4,
                    fadeTheme: FadeTheme.light,
                    millisecondsDelay: 150,
                    baseColor: Color(0xFFE0E0E0),
                    highlightColor: Color(0xFFF5F5F5),
                  ),
                  // Reviews shimmer
                  FadeShimmer(
                    height: 12,
                    width: 50,
                    radius: 4,
                    fadeTheme: FadeTheme.light,
                    millisecondsDelay: 150,
                    baseColor: Color(0xFFE0E0E0),
                    highlightColor: Color(0xFFF5F5F5),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 'Message Therapist' button shimmer
              const FadeShimmer(
                height: 50,
                width: double.infinity,
                radius: 25,
                fadeTheme: FadeTheme.light,
                millisecondsDelay: 200,
                baseColor: Color(0xFFE0E0E0),
                highlightColor: Color(0xFFF5F5F5),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        const Gap(20),
        // Pricing section shimmer
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeShimmer(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.45,
                    radius: 8,
                    fadeTheme: FadeTheme.light,
                    millisecondsDelay: 250,
                    baseColor: const Color(0xFFE0E0E0),
                    highlightColor: const Color(0xFFF5F5F5),
                  ),
                  FadeShimmer(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.45,
                    radius: 8,
                    fadeTheme: FadeTheme.light,
                    millisecondsDelay: 250,
                    baseColor: const Color(0xFFE0E0E0),
                    highlightColor: const Color(0xFFF5F5F5),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // About section shimmer
              const FadeShimmer(
                height: 12,
                width: double.infinity,
                radius: 4,
                fadeTheme: FadeTheme.light,
                millisecondsDelay: 300,
                baseColor: Color(0xFFE0E0E0),
                highlightColor: Color(0xFFF5F5F5),
              ),
              const SizedBox(height: 16),

              // Specializations shimmer
              const FadeShimmer(
                height: 20,
                width: double.infinity,
                radius: 10,
                fadeTheme: FadeTheme.light,
                millisecondsDelay: 350,
                baseColor: Color(0xFFE0E0E0),
                highlightColor: Color(0xFFF5F5F5),
              ),
              const SizedBox(height: 16),

              // Earliest Availability shimmer
              FadeShimmer(
                height: 12,
                width: MediaQuery.of(context).size.width * 0.7,
                radius: 4,
                fadeTheme: FadeTheme.light,
                millisecondsDelay: 400,
                baseColor: const Color(0xFFE0E0E0),
                highlightColor: const Color(0xFFF5F5F5),
              ),
              const SizedBox(height: 16),

              // 'Book Now' button shimmer
              const FadeShimmer(
                height: 50,
                width: double.infinity,
                radius: 25,
                fadeTheme: FadeTheme.light,
                millisecondsDelay: 450,
                baseColor: Color(0xFFE0E0E0),
                highlightColor: Color(0xFFF5F5F5),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Generic shimmer for list items
  static Widget listShimmer({required int itemCount, double height = 80}) {
    return ListView.separated(
      itemCount: itemCount,
      itemBuilder: (_, i) {
        final delay = i * 20;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              FadeShimmer.round(
                size: 50,
                fadeTheme: FadeTheme.light,
                millisecondsDelay: delay,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeShimmer(
                      height: 12,
                      width: double.infinity,
                      millisecondsDelay: delay,
                      radius: 4,
                      fadeTheme: FadeTheme.light,
                    ),
                    const SizedBox(height: 8),
                    FadeShimmer(
                      height: 12,
                      width: MediaQuery.of(_).size.width * 0.6,
                      millisecondsDelay: delay,
                      radius: 4,
                      fadeTheme: FadeTheme.light,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 16),
    );
  }

  static Widget messagingShimmer(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 10, // Simulate 10 message bubbles
      itemBuilder: (context, index) {
        bool isSentByUser =
            index % 2 == 0; // Alternate between sent and received

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0),
          child: Row(
            mainAxisAlignment:
                isSentByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: isSentByUser
                        ? const Radius.circular(16)
                        : const Radius.circular(2),
                    bottomRight: isSentByUser
                        ? const Radius.circular(2)
                        : const Radius.circular(16),
                  ),
                ),
                child: FadeShimmer(
                  height:
                      40 + (index % 3) * 10.0, // Vary heights for text bubbles
                  width: MediaQuery.of(context).size.width * 0.4,
                  radius: 20,
                  millisecondsDelay: index * 150,
                  fadeTheme: FadeTheme.light,
                  baseColor: const Color(0xFFE0E0E0),
                  highlightColor: const Color(0xFFF5F5F5),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget bookingScreenShimmer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // Circular profile picture shimmer
          Row(
            children: [
              FadeShimmer.round(
                size: 100,
                fadeTheme: FadeTheme.light,
                millisecondsDelay: 0,
                baseColor: const Color(0xFFE0E0E0),
                highlightColor: const Color(0xFFF5F5F5),
              ),
              const SizedBox(width: 16),
              // Name shimmer
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeShimmer(
                    height: 16,
                    width: 150,
                    radius: 4,
                    millisecondsDelay: 100,
                    fadeTheme: FadeTheme.light,
                    baseColor: const Color(0xFFE0E0E0),
                    highlightColor: const Color(0xFFF5F5F5),
                  ),
                  const SizedBox(height: 8),
                  FadeShimmer(
                    height: 12,
                    width: 100,
                    radius: 4,
                    millisecondsDelay: 150,
                    fadeTheme: FadeTheme.light,
                    baseColor: const Color(0xFFE0E0E0),
                    highlightColor: const Color(0xFFF5F5F5),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // "Therapist available days" text shimmer
          FadeShimmer(
            height: 16,
            width: 250,
            radius: 4,
            fadeTheme: FadeTheme.light,
            millisecondsDelay: 200,
            baseColor: const Color(0xFFE0E0E0),
            highlightColor: const Color(0xFFF5F5F5),
          ),
          const SizedBox(height: 16),

          // Available day shimmer (rounded rectangle for day selector)
          FadeShimmer(
            height: 50,
            width: double.infinity,
            radius: 25,
            millisecondsDelay: 250,
            fadeTheme: FadeTheme.light,
            baseColor: const Color(0xFFE0E0E0),
            highlightColor: const Color(0xFFF5F5F5),
          ),
          const SizedBox(height: 16),

          // "Proceed to select time" button shimmer
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FadeShimmer(
                height: 50,
                width: double.infinity,
                radius: 25,
                millisecondsDelay: 300,
                fadeTheme: FadeTheme.light,
                baseColor: const Color(0xFFE0E0E0),
                highlightColor: const Color(0xFFF5F5F5),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // Shimmer for card view
  static Widget cardShimmer(
      {required int itemCount,
      double cardHeight = 150,
      bool useTitle = true,
      EdgeInsetsGeometry margin = EdgeInsets.zero}) {
    return Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (useTitle)
            FadeShimmer(
              height: 20,
              width: MediaQuery.of(context).size.width * 0.4,
              millisecondsDelay: 3,
              radius: 4,
              fadeTheme: FadeTheme.light,
            ),
          const Gap(10),
          Container(
            decoration: BoxDecoration(
              // color: context.colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: FadeShimmer(
              height: cardHeight,
              width: double.infinity,
              millisecondsDelay: 3,
              radius: 8,
              fadeTheme: FadeTheme.light,
            ),
          ),
        ],
      );
    });
  }

  // Shimmer for card view
  static Widget textShimmer(
      {double cardHeight = 150, EdgeInsetsGeometry margin = EdgeInsets.zero}) {
    return Builder(builder: (context) {
      return FadeShimmer(
        height: 20,
        width: MediaQuery.of(context).size.width * 0.4,
        millisecondsDelay: 3,
        radius: 4,
        fadeTheme: FadeTheme.light,
      );
    });
  }

  static Widget textFieldShimmer({
    double height = 50, // Default height to resemble a text field
    double width = double.infinity, // Default width
    int millisecondsDelay = 0,
  }) {
    return FadeShimmer(
      height: height,
      width: width,
      radius: 8, // Rounded corners for text field look
      millisecondsDelay: millisecondsDelay,
      fadeTheme: FadeTheme.light,
      baseColor: const Color(0xFFE0E0E0), // Light base color
      highlightColor: const Color(0xFFF5F5F5), // Highlight shimmer
    );
  }

  static Widget circleButtonShimmer(
      {required int itemCount,
      double size = 50, // Size of each circle
      int millisecondsDelay = 0,
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.end}) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: List.generate(itemCount, (i) {
        final delay = i * millisecondsDelay;
        return FadeShimmer.round(
          size: size,
          fadeTheme: FadeTheme.light,
          millisecondsDelay: delay,
          baseColor: const Color(0xFFE0E0E0), // Light base color
          highlightColor: const Color(0xFFF5F5F5), // Highlight shimmer effect
        );
      }).addSpacer(const Gap(10)),
    );
  }

  // Shimmer for grid view
  static Widget gridShimmer({required int itemCount, double cellHeight = 200}) {
    return GridView.builder(
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (_, i) {
        final delay = i * 40;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeShimmer.round(
              size: 80,
              fadeTheme: FadeTheme.light,
              millisecondsDelay: delay,
            ),
            const SizedBox(height: 8),
            FadeShimmer(
              height: 12,
              width: MediaQuery.of(_).size.width * 0.4,
              millisecondsDelay: delay,
              radius: 4,
              fadeTheme: FadeTheme.light,
            ),
          ],
        );
      },
    );
  }

  // Shimmer for title with card column layout
  static Widget titleWithCardShimmer(
      {required int itemCount, double cardHeight = 200}) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, i) {
        final delay = i * 25;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeShimmer(
              height: 20,
              width: MediaQuery.of(context).size.width * 0.6,
              millisecondsDelay: delay,
              radius: 4,
              fadeTheme: FadeTheme.light,
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: context.colors.white,
              ),
              child: FadeShimmer(
                height: cardHeight,
                width: double.infinity,
                millisecondsDelay: delay,
                radius: 8,
                fadeTheme: FadeTheme.light,
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  // Shimmer for generic custom shapes
  static Widget customShapeShimmer({
    required double height,
    required double width,
    double radius = 10,
    int delay = 0,
  }) {
    return FadeShimmer(
      height: height,
      width: width,
      radius: radius,
      millisecondsDelay: delay,
      fadeTheme: FadeTheme.light,
    );
  }
}
