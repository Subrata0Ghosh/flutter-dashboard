import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../models/data_models.dart';
import 'bouncing_widget.dart';

class AllProjectsWidget extends StatelessWidget {
  const AllProjectsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Projects',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          ...sampleProjects.asMap().entries.map(
            (entry) => _ProjectItem(
              project: entry.value,
              isLast: entry.key == sampleProjects.length - 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectItem extends StatelessWidget {
  final Project project;
  final bool isLast;

  const _ProjectItem({required this.project, required this.isLast});


  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: isLast ? 0 : 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: project.isHighlighted
              ? AppColors.red.withValues(alpha: 0.15)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10),
          border: project.isHighlighted
              ? Border.all(color: AppColors.red.withValues(alpha: 0.5))
              : null,
        ),
        child: Row(
          children: [
            // Project thumbnail
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(project.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Project info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: project.subtitle.split('•').first,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                        TextSpan(
                          text: '• ',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: Colors.white.withValues(alpha: 0.4),
                          ),
                        ),
                        TextSpan(
                          text: 'See project details',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: AppColors.primaryLight,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Edit icon
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: project.isHighlighted
                    ? AppColors.red.withValues(alpha: 0.3)
                    : Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.edit_outlined,
                size: 14,
                color: project.isHighlighted
                    ? AppColors.red
                    : Colors.white.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
