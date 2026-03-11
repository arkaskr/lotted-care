import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ai_doc_chat_page.dart';

class SymptomSelectionPage extends StatefulWidget {
  const SymptomSelectionPage({super.key});

  @override
  State<SymptomSelectionPage> createState() => _SymptomSelectionPageState();
}

class _SymptomSelectionPageState extends State<SymptomSelectionPage> {
  final List<String> _popularSymptoms = [
    'Headache',
    'Fatigue',
    'Fever',
    'Dry Cough',
    'Nausea',
    'Muscle Pain',
    'Sore Throat',
  ];
  final Set<String> _selectedSymptoms = {'Headache'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0D1B2A)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How are you feeling today?',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0D1B2A),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Select the symptoms you are experiencing to help us provide a preliminary assessment.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF5D6D7E),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // AI Doc Search Replacement (Premium Action)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AiDocChatPage()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FBFF),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF2ECC71).withOpacity(0.3)),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF2ECC71).withOpacity(0.08),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                color: Color(0xFF2ECC71),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 28),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Talk to your AI DOC',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0D1B2A),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Start an instant chat assessment',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF5D6D7E),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right_rounded, color: Color(0xFF2ECC71)),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 36),

                    const Text(
                      'POPULAR SYMPTOMS',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFAEB6BF),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: _popularSymptoms.map((symptom) => _buildSymptomChip(symptom)).toList(),
                    ),
                    
                    const SizedBox(height: 36),
                    
                    const Text(
                      'BY CATEGORY',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFAEB6BF),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildCategoryCard('Respiratory', Icons.air_rounded, const Color(0xFF2ECC71))),
                        const SizedBox(width: 16),
                        Expanded(child: _buildCategoryCard('Digestive', Icons.restaurant_menu_rounded, const Color(0xFF2ECC71))),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            
            // Continue Button (also leads to AI Doc)
            Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AiDocChatPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2ECC71),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Continue',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSymptomChip(String label) {
    bool isSelected = _selectedSymptoms.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedSymptoms.remove(label);
          } else {
            _selectedSymptoms.add(label);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2ECC71) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? const Color(0xFF2ECC71) : const Color(0xFFEAEEF2),
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: const Color(0xFF2ECC71).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ] : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF0D1B2A),
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBFF),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEAEEF2)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
