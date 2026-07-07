import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/data_models.dart';
import 'bouncing_widget.dart';

class BirthdayCard extends StatelessWidget {
  const BirthdayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _CelebrationCard(
      title: 'Today Birthday',
      people: birthdayPeople,
      buttonLabel: 'Birthday Wishing',
      iconEmoji: '🎂',
      starColor: const Color(0xFFFBBF24),
    );
  }
}

class AnniversaryCard extends StatelessWidget {
  const AnniversaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _CelebrationCard(
      title: 'Anniversary',
      people: anniversaryPeople,
      buttonLabel: 'Anniversary Wishing',
      iconEmoji: '🎊',
      starColor: const Color(0xFFFBBF24),
    );
  }
}

class _CelebrationCard extends StatelessWidget {
  final String title;
  final List<BirthdayPerson> people;
  final String buttonLabel;
  final String iconEmoji;
  final Color starColor;

  const _CelebrationCard({
    required this.title,
    required this.people,
    required this.buttonLabel,
    required this.iconEmoji,
    required this.starColor,
  });

  Color _parseColor(String hexColor) {
    final hex = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  Widget _buildStars(Color color) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Icon(Icons.flare_rounded, color: color, size: 14),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Icon(Icons.flare_rounded, color: color, size: 10),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(
          0xFF302B49,
        ), // Lighter purple/navy for the card background
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center everything
        children: [
          // Header with stars
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStars(starColor),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              _buildStars(starColor),
            ],
          ),

          const SizedBox(height: 12),

          // Avatars row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: people
                .map(
                  (person) => Padding(
                    padding: const EdgeInsets.only(
                      right: 8,
                    ), // Small gap between avatars
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _parseColor(person.avatarColor),
                            border: Border.all(
                              color: const Color(
                                0xFF4C427B,
                              ), // dark purple border
                              width: 2,
                            ),
                            image: DecorationImage(
                              image: AssetImage(person.assetPath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Emoji overlay on top-right of avatar
                        Positioned(
                          top: -4,
                          right: -4,
                          child: Text(
                            iconEmoji,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),

          const SizedBox(height: 12),

          // Total count matching PDF format: "Total  |  2  |"
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF898A9F), // greyish color
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '|',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF898A9F),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${people.length}',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '|',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF898A9F),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Button with send icon on the left matching PDF
          BouncingWidget(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ), // Reduced vertical padding
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFC274FA),
                    Color(0xFFA753F8),
                  ], // bright purple gradient
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.send_rounded, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    buttonLabel,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
