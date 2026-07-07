import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bouncing_widget.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // One continuous gradient from deep indigo to peachy orange
        gradient: const LinearGradient(
          colors: [
            Color(0xFF381DD7), // deep indigo
            Color(0xFF913DB5), // purple
            Color(0xFFF38B86), // peachy orange
          ],
          stops: [0.0, 0.5, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF381DD7).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background 3D Shapes on the right
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 450,
              child: _ThreeDShapes(),
            ),

            // Foreground Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ETHEREUM 2.0',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: 0.9),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Top Rating Project',
                    style: GoogleFonts.inter(
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Trending project and high rating Project Created by team.',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: Colors.white.withValues(alpha: 0.8),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _LearnMoreButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThreeDShapes extends StatefulWidget {
  @override
  State<_ThreeDShapes> createState() => _ThreeDShapesState();
}

class _ThreeDShapesState extends State<_ThreeDShapes> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value * 2 * math.pi;
        final dy1 = math.sin(t) * 8;
        final dy2 = math.sin(t + 1) * 12;
        final dy3 = math.sin(t + 2) * 10;
        final dy4 = math.sin(t + 3) * 15;
        final dy5 = math.sin(t + 4) * 8;
        final dy6 = math.sin(t + 5) * 12;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Peachy rectangle (top right edge)
            Positioned(
              top: -10 + dy1,
              right: 20,
              child: Transform.rotate(
                angle: 0.3,
                child: Container(
                  width: 70,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFDAB9), Color(0xFFF38B86), Color(0xFF5A44E3)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Black torus/donut ring (top middle-right)
            Positioned(
              top: 10 + dy2,
              right: 180,
              child: Transform(
                transform: Matrix4.rotationX(0.5)..rotateY(0.3)..rotateZ(-0.2),
                alignment: Alignment.center,
                child: Container(
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF151821),
                      width: 22,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(10, 10),
                      ),
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.1),
                        blurRadius: 5,
                        spreadRadius: -10,
                        offset: const Offset(-5, -5),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Blue pill (middle left)
            Positioned(
              top: 80 + dy3,
              right: 230,
              child: Transform.rotate(
                angle: -0.6,
                child: Container(
                  width: 90,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF67E8F9), Color(0xFF2563EB)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(-4, 6),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Purple diamond/octahedron (middle right)
            Positioned(
              top: 70 + dy4,
              right: 90,
              child: Transform.rotate(
                angle: 0.1,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFD946EF), Color(0xFF7E22CE)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  // Simulating the 3D edge of the pyramid
                  child: ClipPath(
                    clipper: _TriangleClipper(),
                    child: Container(
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                  ),
                ),
              ),
            ),

            // Green hemisphere (bottom middle)
            Positioned(
              bottom: -20 - dy5,
              right: 170,
              child: Container(
                width: 70,
                height: 45,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  gradient: RadialGradient(
                    colors: [Color(0xFF34D399), Color(0xFF059669)],
                    center: Alignment(-0.2, -0.5),
                    radius: 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
              ),
            ),

            // White cube (bottom right)
            Positioned(
              bottom: -15 - dy6,
              right: 10,
              child: Transform.rotate(
                angle: -0.2,
                child: Container(
                  width: 80,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFFFFF), Color(0xFF9CA3AF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 15,
                        offset: const Offset(-5, 5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _LearnMoreButton extends StatefulWidget {
  @override
  State<_LearnMoreButton> createState() => _LearnMoreButtonState();
}

class _LearnMoreButtonState extends State<_LearnMoreButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onTap: () {}, // Add your action here
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: _hovered ? const Color(0xFF2C224B) : const Color(0xFF1E1736), // dark navy/indigo matching PDF
          borderRadius: BorderRadius.circular(8),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Text(
          'Learn More.',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      ),
    );
  }
}
