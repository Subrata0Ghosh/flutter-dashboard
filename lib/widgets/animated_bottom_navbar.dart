import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavBarItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class AnimatedBottomNavBar extends StatefulWidget {
  final List<NavBarItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;
  final Color bubbleColor;

  const AnimatedBottomNavBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
    this.activeColor = Colors.white,
    this.inactiveColor = const Color(0xFF9094A6),
    this.backgroundColor = Colors.white,
    this.bubbleColor = const Color(0xFF6C63FF),
  });

  @override
  State<AnimatedBottomNavBar> createState() => _AnimatedBottomNavBarState();
}

class _AnimatedBottomNavBarState extends State<AnimatedBottomNavBar>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
    _scaleController.forward();
    _slideController.value = 1.0;
  }

  @override
  void didUpdateWidget(AnimatedBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _previousIndex = oldWidget.selectedIndex;
      _slideController.forward(from: 0);
      _scaleController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.items.length;
    final barHeight = 66.0;
    final bubbleSize = 52.0;
    final bubbleLift = 22.0;

    return Container(
      height: barHeight + bubbleLift + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final totalWidth = constraints.maxWidth;
          final itemWidth = totalWidth / itemCount;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              // Sliding bubble indicator
              AnimatedBuilder(
                animation: _slideController,
                builder: (context, child) {
                  final begin = _previousIndex * itemWidth + itemWidth / 2 - bubbleSize / 2;
                  final end = widget.selectedIndex * itemWidth + itemWidth / 2 - bubbleSize / 2;
                  final curved = CurvedAnimation(
                    parent: _slideController,
                    curve: Curves.easeInOutCubic,
                  );
                  final left = begin + (end - begin) * curved.value;

                  return Positioned(
                    left: left,
                    top: 0,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: bubbleSize,
                        height: bubbleSize,
                        decoration: BoxDecoration(
                          color: widget.bubbleColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: widget.bubbleColor.withValues(alpha: 0.45),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Icon(
                          widget.items[widget.selectedIndex].activeIcon,
                          color: widget.activeColor,
                          size: 24,
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Tap targets & labels
              Positioned(
                bottom: MediaQuery.of(context).padding.bottom,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: barHeight,
                  child: Row(
                    children: List.generate(itemCount, (index) {
                      final isSelected = index == widget.selectedIndex;
                      return Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => widget.onItemSelected(index),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Space for the bubble at top (only for inactive items)
                              if (!isSelected)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Icon(
                                    widget.items[index].icon,
                                    color: widget.inactiveColor,
                                    size: 22,
                                  ),
                                ),
                              if (isSelected)
                                const SizedBox(height: 26), // space below bubble

                              // Label
                              AnimatedOpacity(
                                opacity: isSelected ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 250),
                                child: AnimatedSlide(
                                  offset: isSelected ? Offset.zero : const Offset(0, 0.3),
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeOut,
                                  child: Text(
                                    widget.items[index].label,
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: widget.bubbleColor,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
