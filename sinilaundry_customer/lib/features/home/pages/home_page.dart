import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../services/location_services.dart';

import '../widgets/home_header.dart';
import '../widgets/home_search.dart';
import '../widgets/promo_card.dart';
import '../widgets/service_category.dart';
import '../widgets/why_sinilaundry.dart';
import '../widgets/home_hero_banner.dart';
import '../widgets/home_bottom_nav.dart';
import '../../order/pages/order_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocationService _locationService = LocationService();

  String _locationText = 'Mendeteksi lokasi...';
  bool _isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  // ======================================================
  // LOCATION
  // ======================================================

  Future<void> _loadLocation() async {
    if (!mounted) return;

    setState(() {
      _isLoadingLocation = true;
      _locationText = 'Mendeteksi lokasi...';
    });

    try {
      final position = await _locationService.getCurrentLocation();

      if (position == null) {
        if (!mounted) return;

        setState(() {
          _locationText = 'Lokasi tidak tersedia';
          _isLoadingLocation = false;
        });

        return;
      }

      try {
        final placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isEmpty) {
          if (!mounted) return;

          setState(() {
            _locationText = 'Lokasi Anda';
            _isLoadingLocation = false;
          });

          return;
        }

        final placemark = placemarks.first;

        final city =
            placemark.locality ??
            placemark.subAdministrativeArea ??
            '';

        final province =
            placemark.administrativeArea ?? '';

        String locationName;

        if (city.isNotEmpty && province.isNotEmpty) {
          locationName = '$city, $province';
        } else if (city.isNotEmpty) {
          locationName = city;
        } else if (province.isNotEmpty) {
          locationName = province;
        } else {
          locationName = 'Lokasi Anda';
        }

        if (!mounted) return;

        setState(() {
          _locationText = locationName;
          _isLoadingLocation = false;
        });
      } catch (_) {
        if (!mounted) return;

        setState(() {
          _locationText = 'Lokasi Anda';
          _isLoadingLocation = false;
        });
      }
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _locationText = 'Lokasi tidak tersedia';
        _isLoadingLocation = false;
      });
    }
  }

  // ======================================================
  // LOCATION SELECTOR
  // ======================================================

  Widget _buildLocationSelector() {
  return GestureDetector(
    onTap: _isLoadingLocation ? null : _loadLocation,
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Location icon
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.location_on_rounded,
              color: AppColors.primary,
              size: 17,
            ),
          ),

          const SizedBox(width: 8),

          // Location text
          Flexible(
            child: Text(
              _locationText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(width: 7),

          // Loading / refresh
          if (_isLoadingLocation)
            const SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          else
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 19,
              color: AppColors.textSecondary,
            ),
        ],
      ),
    ),
  );
}

  // ======================================================
  // SECTION TITLE
  // ======================================================

  Widget _sectionTitle(
    String title, {
    String action = 'Lihat Semua',
    VoidCallback? onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.heading2.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),

        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            action,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // ======================================================
  // LAUNDRY CARD
  // ======================================================

  Widget _laundryCard({
  required String name,
  required String rating,
  required String review,
  required String distance,
  required String service,
  required String closeTime,
  required bool isOpen,
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.grey.shade200,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.035),
          blurRadius: 16,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================================
          // LAUNDRY IMAGE
          // ==========================================

          Container(
            width: 82,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(
                alpha: 0.08,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.local_laundry_service_rounded,
              color: AppColors.primary,
              size: 40,
            ),
          ),

          const SizedBox(width: 12),

          // ==========================================
          // CONTENT
          // ==========================================

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NAME + FAVORITE
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    const SizedBox(width: 6),

                    const Icon(
                      Icons.favorite_border_rounded,
                      size: 21,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // RATING + DISTANCE
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: AppColors.warning,
                      size: 16,
                    ),

                    const SizedBox(width: 3),

                    Text(
                      rating,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(width: 3),

                    Text(
                      '($review)',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(width: 8),

                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.primary,
                      size: 16,
                    ),

                    const SizedBox(width: 3),

                    Text(
                      distance,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // SERVICES
                Text(
                  service,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 8),

                // STATUS + BUTTON
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isOpen
                            ? AppColors.success.withValues(
                                alpha: 0.10,
                              )
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Text(
                        isOpen ? 'Buka' : 'Tutup',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: isOpen
                              ? AppColors.success
                              : AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ),

                    const SizedBox(width: 6),

                    Flexible(
                      child: Text(
                        'Tutup $closeTime',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // FIX: BUTTON DIBERI WIDTH PASTI
                    SizedBox(
                      width: 62,
                      height: 34,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                        child: const Text(
                          'Pesan',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  // ======================================================
  // BUILD
  // ======================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ======================================================
              // HEADER
              // ======================================================

              const HomeHeader(
                userName: 'Febrio',
              ),

              const SizedBox(height: 12),

              // ======================================================
              // LOCATION
              // ======================================================

             

              _buildLocationSelector(),

              const SizedBox(height: 16),

              const HomeHeroBanner(),

              const SizedBox(height: 16),

              
              // ======================================================
              // SEARCH
              // ======================================================

              const HomeSearch(),

              const SizedBox(height: 26),

              // ======================================================
              // PROMO
              // ======================================================

              _sectionTitle(
                'Promo Untuk Kamu',
                action: 'Lihat Semua',
              ),

              const SizedBox(height: 12),

              const PromoCard(),

              const SizedBox(height: 28),

              // ======================================================
              // LAUNDRY TERDEKAT
              // ======================================================

              _sectionTitle(
                'Laundry Terdekat',
                action: 'Lihat Semua',
              ),

              const SizedBox(height: 12),

              _laundryCard(
                name: 'Sini Laundry Depok',
                rating: '4.8',
                review: '124',
                distance: '0.8 km',
                service: 'Cuci Kering • Setrika',
                closeTime: '21.00',
                isOpen: true,
              ),

              _laundryCard(
                name: 'Laundry Bersih Jaya',
                rating: '4.7',
                review: '98',
                distance: '1.2 km',
                service: 'Cuci Kering • Express',
                closeTime: '22.00',
                isOpen: true,
              ),

              _laundryCard(
                name: 'Clean Express',
                rating: '4.6',
                review: '76',
                distance: '1.6 km',
                service: 'Cuci • Sepatu • Tas',
                closeTime: '20.00',
                isOpen: true,
              ),

              const SizedBox(height: 10),

              // ======================================================
              // KATEGORI
              // ======================================================

              _sectionTitle(
                'Kategori Layanan',
                action: 'Lihat Semua',
              ),

              const SizedBox(height: 16),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    ServiceCategory(
                      icon: Icons.local_laundry_service_rounded,
                      title: 'Cuci Kering',
                    ),

                    SizedBox(width: 14),

                    ServiceCategory(
                      icon: Icons.iron_rounded,
                      title: 'Setrika',
                    ),

                    SizedBox(width: 14),

                    ServiceCategory(
                      icon: Icons.bed_rounded,
                      title: 'Bed Cover',
                    ),

                    SizedBox(width: 14),

                    ServiceCategory(
                      icon: Icons.sports_soccer_rounded,
                      title: 'Sepatu',
                    ),

                    SizedBox(width: 14),

                    ServiceCategory(
                      icon: Icons.shopping_bag_rounded,
                      title: 'Tas',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ======================================================
              // KENAPA SINILAUNDRY
              // ======================================================

              Text(
                'Kenapa SiniLaundry?',
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 16),

              const WhySiniLaundry(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // ======================================================
      // BOTTOM NAVIGATION
      // ======================================================

      bottomNavigationBar: HomeBottomNav(
        selectedIndex: 0,
        onDestinationSelected: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OrderPage(),
              ),
            );
          }
        },
      ),
    );
  }
} 