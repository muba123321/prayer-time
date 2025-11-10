import 'package:flutter/material.dart';
import 'package:gicc/core/theme/design_system.dart';
import 'package:gicc/screens/surah_detail_screen.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({super.key});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  String _searchQuery = '';

  // All 114 Surahs with their details
  final List<Map<String, dynamic>> _allSurahs = [
    {
      'number': 1,
      'english': 'Al-Fatihah',
      'arabic': 'الفاتحة',
      'verses': 7,
      'revelation': 'Meccan'
    },
    {
      'number': 2,
      'english': 'Al-Baqarah',
      'arabic': 'البقرة',
      'verses': 286,
      'revelation': 'Medinan'
    },
    {
      'number': 3,
      'english': 'Aal-E-Imran',
      'arabic': 'آل عمران',
      'verses': 200,
      'revelation': 'Medinan'
    },
    {
      'number': 4,
      'english': 'An-Nisa',
      'arabic': 'النساء',
      'verses': 176,
      'revelation': 'Medinan'
    },
    {
      'number': 5,
      'english': 'Al-Maidah',
      'arabic': 'المائدة',
      'verses': 120,
      'revelation': 'Medinan'
    },
    {
      'number': 6,
      'english': 'Al-Anam',
      'arabic': 'الأنعام',
      'verses': 165,
      'revelation': 'Meccan'
    },
    {
      'number': 7,
      'english': 'Al-Araf',
      'arabic': 'الأعراف',
      'verses': 206,
      'revelation': 'Meccan'
    },
    {
      'number': 8,
      'english': 'Al-Anfal',
      'arabic': 'الأنفال',
      'verses': 75,
      'revelation': 'Medinan'
    },
    {
      'number': 9,
      'english': 'At-Tawbah',
      'arabic': 'التوبة',
      'verses': 129,
      'revelation': 'Medinan'
    },
    {
      'number': 10,
      'english': 'Yunus',
      'arabic': 'يونس',
      'verses': 109,
      'revelation': 'Meccan'
    },
    {
      'number': 11,
      'english': 'Hud',
      'arabic': 'هود',
      'verses': 123,
      'revelation': 'Meccan'
    },
    {
      'number': 12,
      'english': 'Yusuf',
      'arabic': 'يوسف',
      'verses': 111,
      'revelation': 'Meccan'
    },
    {
      'number': 13,
      'english': 'Ar-Rad',
      'arabic': 'الرعد',
      'verses': 43,
      'revelation': 'Medinan'
    },
    {
      'number': 14,
      'english': 'Ibrahim',
      'arabic': 'ابراهيم',
      'verses': 52,
      'revelation': 'Meccan'
    },
    {
      'number': 15,
      'english': 'Al-Hijr',
      'arabic': 'الحجر',
      'verses': 99,
      'revelation': 'Meccan'
    },
    {
      'number': 16,
      'english': 'An-Nahl',
      'arabic': 'النحل',
      'verses': 128,
      'revelation': 'Meccan'
    },
    {
      'number': 17,
      'english': 'Al-Isra',
      'arabic': 'الإسراء',
      'verses': 111,
      'revelation': 'Meccan'
    },
    {
      'number': 18,
      'english': 'Al-Kahf',
      'arabic': 'الكهف',
      'verses': 110,
      'revelation': 'Meccan'
    },
    {
      'number': 19,
      'english': 'Maryam',
      'arabic': 'مريم',
      'verses': 98,
      'revelation': 'Meccan'
    },
    {
      'number': 20,
      'english': 'Ta-Ha',
      'arabic': 'طه',
      'verses': 135,
      'revelation': 'Meccan'
    },
    {
      'number': 21,
      'english': 'Al-Anbiya',
      'arabic': 'الأنبياء',
      'verses': 112,
      'revelation': 'Meccan'
    },
    {
      'number': 22,
      'english': 'Al-Hajj',
      'arabic': 'الحج',
      'verses': 78,
      'revelation': 'Medinan'
    },
    {
      'number': 23,
      'english': 'Al-Muminun',
      'arabic': 'المؤمنون',
      'verses': 118,
      'revelation': 'Meccan'
    },
    {
      'number': 24,
      'english': 'An-Nur',
      'arabic': 'النور',
      'verses': 64,
      'revelation': 'Medinan'
    },
    {
      'number': 25,
      'english': 'Al-Furqan',
      'arabic': 'الفرقان',
      'verses': 77,
      'revelation': 'Meccan'
    },
    {
      'number': 26,
      'english': 'Ash-Shuara',
      'arabic': 'الشعراء',
      'verses': 227,
      'revelation': 'Meccan'
    },
    {
      'number': 27,
      'english': 'An-Naml',
      'arabic': 'النمل',
      'verses': 93,
      'revelation': 'Meccan'
    },
    {
      'number': 28,
      'english': 'Al-Qasas',
      'arabic': 'القصص',
      'verses': 88,
      'revelation': 'Meccan'
    },
    {
      'number': 29,
      'english': 'Al-Ankabut',
      'arabic': 'العنكبوت',
      'verses': 69,
      'revelation': 'Meccan'
    },
    {
      'number': 30,
      'english': 'Ar-Rum',
      'arabic': 'الروم',
      'verses': 60,
      'revelation': 'Meccan'
    },
    {
      'number': 31,
      'english': 'Luqman',
      'arabic': 'لقمان',
      'verses': 34,
      'revelation': 'Meccan'
    },
    {
      'number': 32,
      'english': 'As-Sajdah',
      'arabic': 'السجدة',
      'verses': 30,
      'revelation': 'Meccan'
    },
    {
      'number': 33,
      'english': 'Al-Ahzab',
      'arabic': 'الأحزاب',
      'verses': 73,
      'revelation': 'Medinan'
    },
    {
      'number': 34,
      'english': 'Saba',
      'arabic': 'سبإ',
      'verses': 54,
      'revelation': 'Meccan'
    },
    {
      'number': 35,
      'english': 'Fatir',
      'arabic': 'فاطر',
      'verses': 45,
      'revelation': 'Meccan'
    },
    {
      'number': 36,
      'english': 'Ya-Sin',
      'arabic': 'يس',
      'verses': 83,
      'revelation': 'Meccan'
    },
    {
      'number': 37,
      'english': 'As-Saffat',
      'arabic': 'الصافات',
      'verses': 182,
      'revelation': 'Meccan'
    },
    {
      'number': 38,
      'english': 'Sad',
      'arabic': 'ص',
      'verses': 88,
      'revelation': 'Meccan'
    },
    {
      'number': 39,
      'english': 'Az-Zumar',
      'arabic': 'الزمر',
      'verses': 75,
      'revelation': 'Meccan'
    },
    {
      'number': 40,
      'english': 'Ghafir',
      'arabic': 'غافر',
      'verses': 85,
      'revelation': 'Meccan'
    },
    {
      'number': 41,
      'english': 'Fussilat',
      'arabic': 'فصلت',
      'verses': 54,
      'revelation': 'Meccan'
    },
    {
      'number': 42,
      'english': 'Ash-Shura',
      'arabic': 'الشورى',
      'verses': 53,
      'revelation': 'Meccan'
    },
    {
      'number': 43,
      'english': 'Az-Zukhruf',
      'arabic': 'الزخرف',
      'verses': 89,
      'revelation': 'Meccan'
    },
    {
      'number': 44,
      'english': 'Ad-Dukhan',
      'arabic': 'الدخان',
      'verses': 59,
      'revelation': 'Meccan'
    },
    {
      'number': 45,
      'english': 'Al-Jathiya',
      'arabic': 'الجاثية',
      'verses': 37,
      'revelation': 'Meccan'
    },
    {
      'number': 46,
      'english': 'Al-Ahqaf',
      'arabic': 'الأحقاف',
      'verses': 35,
      'revelation': 'Meccan'
    },
    {
      'number': 47,
      'english': 'Muhammad',
      'arabic': 'محمد',
      'verses': 38,
      'revelation': 'Medinan'
    },
    {
      'number': 48,
      'english': 'Al-Fath',
      'arabic': 'الفتح',
      'verses': 29,
      'revelation': 'Medinan'
    },
    {
      'number': 49,
      'english': 'Al-Hujurat',
      'arabic': 'الحجرات',
      'verses': 18,
      'revelation': 'Medinan'
    },
    {
      'number': 50,
      'english': 'Qaf',
      'arabic': 'ق',
      'verses': 45,
      'revelation': 'Meccan'
    },
    {
      'number': 51,
      'english': 'Adh-Dhariyat',
      'arabic': 'الذاريات',
      'verses': 60,
      'revelation': 'Meccan'
    },
    {
      'number': 52,
      'english': 'At-Tur',
      'arabic': 'الطور',
      'verses': 49,
      'revelation': 'Meccan'
    },
    {
      'number': 53,
      'english': 'An-Najm',
      'arabic': 'النجم',
      'verses': 62,
      'revelation': 'Meccan'
    },
    {
      'number': 54,
      'english': 'Al-Qamar',
      'arabic': 'القمر',
      'verses': 55,
      'revelation': 'Meccan'
    },
    {
      'number': 55,
      'english': 'Ar-Rahman',
      'arabic': 'الرحمن',
      'verses': 78,
      'revelation': 'Medinan'
    },
    {
      'number': 56,
      'english': 'Al-Waqiah',
      'arabic': 'الواقعة',
      'verses': 96,
      'revelation': 'Meccan'
    },
    {
      'number': 57,
      'english': 'Al-Hadid',
      'arabic': 'الحديد',
      'verses': 29,
      'revelation': 'Medinan'
    },
    {
      'number': 58,
      'english': 'Al-Mujadila',
      'arabic': 'المجادلة',
      'verses': 22,
      'revelation': 'Medinan'
    },
    {
      'number': 59,
      'english': 'Al-Hashr',
      'arabic': 'الحشر',
      'verses': 24,
      'revelation': 'Medinan'
    },
    {
      'number': 60,
      'english': 'Al-Mumtahanah',
      'arabic': 'الممتحنة',
      'verses': 13,
      'revelation': 'Medinan'
    },
    {
      'number': 61,
      'english': 'As-Saf',
      'arabic': 'الصف',
      'verses': 14,
      'revelation': 'Medinan'
    },
    {
      'number': 62,
      'english': 'Al-Jumuah',
      'arabic': 'الجمعة',
      'verses': 11,
      'revelation': 'Medinan'
    },
    {
      'number': 63,
      'english': 'Al-Munafiqun',
      'arabic': 'المنافقون',
      'verses': 11,
      'revelation': 'Medinan'
    },
    {
      'number': 64,
      'english': 'At-Taghabun',
      'arabic': 'التغابن',
      'verses': 18,
      'revelation': 'Medinan'
    },
    {
      'number': 65,
      'english': 'At-Talaq',
      'arabic': 'الطلاق',
      'verses': 12,
      'revelation': 'Medinan'
    },
    {
      'number': 66,
      'english': 'At-Tahrim',
      'arabic': 'التحريم',
      'verses': 12,
      'revelation': 'Medinan'
    },
    {
      'number': 67,
      'english': 'Al-Mulk',
      'arabic': 'الملك',
      'verses': 30,
      'revelation': 'Meccan'
    },
    {
      'number': 68,
      'english': 'Al-Qalam',
      'arabic': 'القلم',
      'verses': 52,
      'revelation': 'Meccan'
    },
    {
      'number': 69,
      'english': 'Al-Haqqah',
      'arabic': 'الحاقة',
      'verses': 52,
      'revelation': 'Meccan'
    },
    {
      'number': 70,
      'english': 'Al-Maarij',
      'arabic': 'المعارج',
      'verses': 44,
      'revelation': 'Meccan'
    },
    {
      'number': 71,
      'english': 'Nuh',
      'arabic': 'نوح',
      'verses': 28,
      'revelation': 'Meccan'
    },
    {
      'number': 72,
      'english': 'Al-Jinn',
      'arabic': 'الجن',
      'verses': 28,
      'revelation': 'Meccan'
    },
    {
      'number': 73,
      'english': 'Al-Muzzammil',
      'arabic': 'المزمل',
      'verses': 20,
      'revelation': 'Meccan'
    },
    {
      'number': 74,
      'english': 'Al-Muddathir',
      'arabic': 'المدثر',
      'verses': 56,
      'revelation': 'Meccan'
    },
    {
      'number': 75,
      'english': 'Al-Qiyamah',
      'arabic': 'القيامة',
      'verses': 40,
      'revelation': 'Meccan'
    },
    {
      'number': 76,
      'english': 'Al-Insan',
      'arabic': 'الانسان',
      'verses': 31,
      'revelation': 'Medinan'
    },
    {
      'number': 77,
      'english': 'Al-Mursalat',
      'arabic': 'المرسلات',
      'verses': 50,
      'revelation': 'Meccan'
    },
    {
      'number': 78,
      'english': 'An-Naba',
      'arabic': 'النبإ',
      'verses': 40,
      'revelation': 'Meccan'
    },
    {
      'number': 79,
      'english': 'An-Naziat',
      'arabic': 'النازعات',
      'verses': 46,
      'revelation': 'Meccan'
    },
    {
      'number': 80,
      'english': 'Abasa',
      'arabic': 'عبس',
      'verses': 42,
      'revelation': 'Meccan'
    },
    {
      'number': 81,
      'english': 'At-Takwir',
      'arabic': 'التكوير',
      'verses': 29,
      'revelation': 'Meccan'
    },
    {
      'number': 82,
      'english': 'Al-Infitar',
      'arabic': 'الإنفطار',
      'verses': 19,
      'revelation': 'Meccan'
    },
    {
      'number': 83,
      'english': 'Al-Mutaffifin',
      'arabic': 'المطففين',
      'verses': 36,
      'revelation': 'Meccan'
    },
    {
      'number': 84,
      'english': 'Al-Inshiqaq',
      'arabic': 'الإنشقاق',
      'verses': 25,
      'revelation': 'Meccan'
    },
    {
      'number': 85,
      'english': 'Al-Buruj',
      'arabic': 'البروج',
      'verses': 22,
      'revelation': 'Meccan'
    },
    {
      'number': 86,
      'english': 'At-Tariq',
      'arabic': 'الطارق',
      'verses': 17,
      'revelation': 'Meccan'
    },
    {
      'number': 87,
      'english': 'Al-Ala',
      'arabic': 'الأعلى',
      'verses': 19,
      'revelation': 'Meccan'
    },
    {
      'number': 88,
      'english': 'Al-Ghashiyah',
      'arabic': 'الغاشية',
      'verses': 26,
      'revelation': 'Meccan'
    },
    {
      'number': 89,
      'english': 'Al-Fajr',
      'arabic': 'الفجر',
      'verses': 30,
      'revelation': 'Meccan'
    },
    {
      'number': 90,
      'english': 'Al-Balad',
      'arabic': 'البلد',
      'verses': 20,
      'revelation': 'Meccan'
    },
    {
      'number': 91,
      'english': 'Ash-Shams',
      'arabic': 'الشمس',
      'verses': 15,
      'revelation': 'Meccan'
    },
    {
      'number': 92,
      'english': 'Al-Layl',
      'arabic': 'الليل',
      'verses': 21,
      'revelation': 'Meccan'
    },
    {
      'number': 93,
      'english': 'Ad-Duhaa',
      'arabic': 'الضحى',
      'verses': 11,
      'revelation': 'Meccan'
    },
    {
      'number': 94,
      'english': 'Ash-Sharh',
      'arabic': 'الشرح',
      'verses': 8,
      'revelation': 'Meccan'
    },
    {
      'number': 95,
      'english': 'At-Tin',
      'arabic': 'التين',
      'verses': 8,
      'revelation': 'Meccan'
    },
    {
      'number': 96,
      'english': 'Al-Alaq',
      'arabic': 'العلق',
      'verses': 19,
      'revelation': 'Meccan'
    },
    {
      'number': 97,
      'english': 'Al-Qadr',
      'arabic': 'القدر',
      'verses': 5,
      'revelation': 'Meccan'
    },
    {
      'number': 98,
      'english': 'Al-Bayyinah',
      'arabic': 'البينة',
      'verses': 8,
      'revelation': 'Medinan'
    },
    {
      'number': 99,
      'english': 'Az-Zalzalah',
      'arabic': 'الزلزلة',
      'verses': 8,
      'revelation': 'Medinan'
    },
    {
      'number': 100,
      'english': 'Al-Adiyat',
      'arabic': 'العاديات',
      'verses': 11,
      'revelation': 'Meccan'
    },
    {
      'number': 101,
      'english': 'Al-Qariah',
      'arabic': 'القارعة',
      'verses': 11,
      'revelation': 'Meccan'
    },
    {
      'number': 102,
      'english': 'At-Takathur',
      'arabic': 'التكاثر',
      'verses': 8,
      'revelation': 'Meccan'
    },
    {
      'number': 103,
      'english': 'Al-Asr',
      'arabic': 'العصر',
      'verses': 3,
      'revelation': 'Meccan'
    },
    {
      'number': 104,
      'english': 'Al-Humazah',
      'arabic': 'الهمزة',
      'verses': 9,
      'revelation': 'Meccan'
    },
    {
      'number': 105,
      'english': 'Al-Fil',
      'arabic': 'الفيل',
      'verses': 5,
      'revelation': 'Meccan'
    },
    {
      'number': 106,
      'english': 'Quraysh',
      'arabic': 'قريش',
      'verses': 4,
      'revelation': 'Meccan'
    },
    {
      'number': 107,
      'english': 'Al-Maun',
      'arabic': 'الماعون',
      'verses': 7,
      'revelation': 'Meccan'
    },
    {
      'number': 108,
      'english': 'Al-Kawthar',
      'arabic': 'الكوثر',
      'verses': 3,
      'revelation': 'Meccan'
    },
    {
      'number': 109,
      'english': 'Al-Kafirun',
      'arabic': 'الكافرون',
      'verses': 6,
      'revelation': 'Meccan'
    },
    {
      'number': 110,
      'english': 'An-Nasr',
      'arabic': 'النصر',
      'verses': 3,
      'revelation': 'Medinan'
    },
    {
      'number': 111,
      'english': 'Al-Masad',
      'arabic': 'المسد',
      'verses': 5,
      'revelation': 'Meccan'
    },
    {
      'number': 112,
      'english': 'Al-Ikhlas',
      'arabic': 'الإخلاص',
      'verses': 4,
      'revelation': 'Meccan'
    },
    {
      'number': 113,
      'english': 'Al-Falaq',
      'arabic': 'الفلق',
      'verses': 5,
      'revelation': 'Meccan'
    },
    {
      'number': 114,
      'english': 'An-Nas',
      'arabic': 'الناس',
      'verses': 6,
      'revelation': 'Meccan'
    },
  ];

  List<Map<String, dynamic>> get _filteredSurahs {
    if (_searchQuery.isEmpty) return _allSurahs;

    return _allSurahs.where((surah) {
      final query = _searchQuery.toLowerCase();
      return surah['english'].toString().toLowerCase().contains(query) ||
          surah['arabic'].toString().contains(_searchQuery) ||
          surah['number'].toString().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'All Surahs',
          style: AppTextStyles.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(AppSpacing.md),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search by name or number...',
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() => _searchQuery = ''),
                      )
                    : null,
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppSpacing.borderRadiusSm),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
              ),
            ),
          ),

          // Surah List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: _filteredSurahs.length,
              itemBuilder: (context, index) {
                final surah = _filteredSurahs[index];
                return _buildSurahCard(surah);
              },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildSurahCard(Map<String, dynamic> surah) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurahDetailScreen(
                  surahNumber: surah['number'],
                  surahName: surah['english'],
                  surahNameArabic: surah['arabic'],
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              border: Border.all(
                color: AppColors.dividerColor,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Surah Number
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${surah['number']}',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                // Surah Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        surah['english'],
                        style: AppTextStyles.titleSmall.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${surah['verses']} verses • ${surah['revelation']}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Arabic Name
                Text(
                  surah['arabic'],
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
