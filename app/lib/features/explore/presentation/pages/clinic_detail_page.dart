import 'package:flutter/material.dart';

class ClinicDetailPage extends StatelessWidget {
  const ClinicDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0D1B2A)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Color(0xFF0D1B2A)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Color(0xFF0D1B2A)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Wellness Central Clinic',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D1B2A),
                        ),
                      ),
                      Text(
                        'Multi-specialty Medical Center',
                        style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1FDF6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                      SizedBox(width: 4),
                      Text(
                        '4.8',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2ECC71)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTag('Cardiology'),
                  const SizedBox(width: 10),
                  _buildTag('Pediatrics'),
                  const SizedBox(width: 10),
                  _buildTag('Dermatology'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.access_time_filled, color: Color(0xFF2ECC71), size: 18),
                const SizedBox(width: 8),
                Text(
                  'Open until 8:00 PM',
                  style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.location_on, color: Color(0xFFABB2B9), size: 18),
                const SizedBox(width: 8),
                Text(
                  '2.4 km away',
                  style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500),
                ),
              ],
            ),

            const SizedBox(height: 32),
            // Primary Actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.calendar_today, size: 18),
                    label: const Text('Book Now'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2ECC71),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.directions_outlined, size: 18),
                    label: const Text('Directions'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF0D1B2A),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      side: BorderSide(color: Colors.grey.withOpacity(0.2)),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),
            // Estimated Costs Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.blue.withOpacity(0.05)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.payments_outlined, color: Color(0xFF2ECC71)),
                      SizedBox(width: 12),
                      Text(
                        'Estimated Costs',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildCostRow('General Consultation', '\$45 - \$60'),
                  const SizedBox(height: 12),
                  _buildCostRow('Specialist Visit', '\$85 - \$120'),
                  const SizedBox(height: 20),
                  Text(
                    'Final costs may vary based on insurance coverage and specific procedures.',
                    style: TextStyle(color: Colors.grey[500], fontSize: 13, height: 1.4, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            // Location Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.location_on_outlined, color: Color(0xFF2ECC71)),
                      SizedBox(width: 12),
                      Text(
                        'Location',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?w=500&h=300&fit=crop'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '123 Health Parkway, Medical District, Suite 405',
                    style: TextStyle(color: Colors.grey[700], height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F8F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Color(0xFF2ECC71), fontWeight: FontWeight.w600, fontSize: 13),
      ),
    );
  }

  Widget _buildCostRow(String service, String range) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(service, style: TextStyle(color: Colors.grey[700], fontSize: 15)),
        Text(range, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }
}
