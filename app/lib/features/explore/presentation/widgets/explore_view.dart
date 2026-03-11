import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../presentation/pages/clinic_detail_page.dart';
import '../../../../core/services/location_service.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  GoogleMapController? _mapController;
  Position? _currentPosition;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(
      23.6850,
      90.3563,
    ), // Default to a central location (e.g., Dhaka)
    zoom: 12,
  );

  final Set<Marker> _markers = {
    Marker(
      markerId: const MarkerId('city_general'),
      position: const LatLng(23.7509, 90.3935),
      infoWindow: const InfoWindow(title: 'City General Hospital'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
    Marker(
      markerId: const MarkerId('mercy_clinic'),
      position: const LatLng(23.7915, 90.4045),
      infoWindow: const InfoWindow(title: 'Mercy Clinic'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
  };

  // Modern light map style
  final String _mapStyle = '''
[
  {
    "featureType": "poi.medical",
    "elementType": "geometry",
    "stylers": [
      { "color": "#e8f8f5" }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      { "color": "#eaf2f8" }
    ]
  },
  {
    "featureType": "landscape",
    "elementType": "geometry",
    "stylers": [
      { "color": "#f8fbff" }
    ]
  }
]
''';

  bool _isMapLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await LocationService.getCurrentLocation();
      if (position != null) {
        setState(() {
          _currentPosition = position;
        });
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(position.latitude, position.longitude),
            14.0,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Real Google Map
        GoogleMap(
          initialCameraPosition: _initialPosition,
          onMapCreated: (controller) {
            _mapController = controller;
            _mapController?.setMapStyle(_mapStyle);
            setState(() {
              _isMapLoading = false;
            });
            if (_currentPosition != null) {
              _mapController?.animateCamera(
                CameraUpdate.newLatLngZoom(
                  LatLng(
                    _currentPosition!.latitude,
                    _currentPosition!.longitude,
                  ),
                  14.0,
                ),
              );
            }
          },
          markers: _markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
        ),

        if (_isMapLoading)
          Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(color: Color(0xFF2ECC71)),
            ),
          ),

        // Filter Bar (Semi-transparent background for better map visibility)
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildFilterChip('Open Now', true, isDropdown: true),
                const SizedBox(width: 12),
                _buildFilterChip('Clinics', false, isSelected: true),
                const SizedBox(width: 12),
                _buildFilterChip('Hospitals', true, isDropdown: true),
              ],
            ),
          ),
        ),

        // Bottom Sheet Content
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 280,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Recommended nearby',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D1B2A),
                        ),
                      ),
                      Text(
                        'View List',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2ECC71),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _buildNearbyClinic(
                        context,
                        'City General Hospital',
                        '4.8',
                        '1.2k reviews',
                        '0.8 mi',
                        'Emergency',
                      ),
                      const SizedBox(width: 16),
                      _buildNearbyClinic(
                        context,
                        'Wellness North',
                        '4.9',
                        '850 reviews',
                        '1.4 mi',
                        'General',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80), // Padding for navbar
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(
    String label,
    bool hasIcon, {
    bool isSelected = false,
    bool isDropdown = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2ECC71) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF0D1B2A),
              fontWeight: FontWeight.w600,
            ),
          ),
          if (isDropdown) ...[
            const SizedBox(width: 8),
            Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: isSelected ? Colors.white : const Color(0xFF0D1B2A),
            ),
          ] else if (isSelected) ...[
            const SizedBox(width: 8),
            const Icon(Icons.check, size: 18, color: Colors.white),
          ],
        ],
      ),
    );
  }

  Widget _buildNearbyClinic(
    BuildContext context,
    String name,
    String rating,
    String reviews,
    String distance,
    String tag,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ClinicDetailPage()),
        );
      },
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FBFF),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.blue.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=200&h=200&fit=crop',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D1B2A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '($reviews)',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F8F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            color: Color(0xFF2ECC71),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        distance,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
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
}
