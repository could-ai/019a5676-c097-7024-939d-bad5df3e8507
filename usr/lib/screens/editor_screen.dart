import 'package:flutter/material.dart';
import 'dart:io';
import '../widgets/filter_option.dart';
import '../widgets/adjustment_slider.dart';
import '../models/filter_model.dart';
import '../models/adjustment_model.dart';

class EditorScreen extends StatefulWidget {
  final String imagePath;

  const EditorScreen({super.key, required this.imagePath});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  FilterModel _selectedFilter = FilterModel.none();
  final Map<String, double> _adjustments = {
    'brightness': 0,
    'contrast': 0,
    'saturation': 0,
    'sharpness': 0,
    'blur': 0,
  };

  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _applyFilter(FilterModel filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  void _updateAdjustment(String type, double value) {
    setState(() {
      _adjustments[type] = value;
    });
  }

  Future<void> _processWithAI(String effectType) async {
    setState(() {
      _isProcessing = true;
    });

    // Simulate AI processing
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isProcessing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$effectType applied successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _saveImage() async {
    setState(() {
      _isProcessing = true;
    });

    // Simulate saving process
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() {
        _isProcessing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Edit Photo'),
        actions: [
          if (_isProcessing)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _saveImage,
              tooltip: 'Save',
            ),
        ],
      ),
      body: Column(
        children: [
          // Image Preview
          Expanded(
            flex: 2,
            child: Center(
              child: Hero(
                tag: 'image_${widget.imagePath}',
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ColorFiltered(
                      colorFilter: _selectedFilter.colorFilter,
                      child: Image.file(
                        File(widget.imagePath),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Tools Section
          Container(
            color: Colors.grey[900],
            child: TabBar(
              controller: _tabController,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Theme.of(context).colorScheme.primary,
              tabs: const [
                Tab(icon: Icon(Icons.filter), text: 'Filters'),
                Tab(icon: Icon(Icons.tune), text: 'Adjust'),
                Tab(icon: Icon(Icons.auto_awesome), text: 'AI Magic'),
                Tab(icon: Icon(Icons.crop), text: 'Transform'),
              ],
            ),
          ),
          // Tool Options
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[900],
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildFiltersTab(),
                  _buildAdjustTab(),
                  _buildAIMagicTab(),
                  _buildTransformTab(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersTab() {
    final filters = [
      FilterModel.none(),
      FilterModel(name: 'Vivid', colorFilter: ColorFilter.mode(Colors.orange.withOpacity(0.2), BlendMode.overlay)),
      FilterModel(name: 'Noir', colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.saturation)),
      FilterModel(name: 'Cool', colorFilter: ColorFilter.mode(Colors.blue.withOpacity(0.2), BlendMode.overlay)),
      FilterModel(name: 'Warm', colorFilter: ColorFilter.mode(Colors.orange.withOpacity(0.3), BlendMode.overlay)),
      FilterModel(name: 'Vintage', colorFilter: ColorFilter.mode(Colors.brown.withOpacity(0.3), BlendMode.overlay)),
      FilterModel(name: 'Dramatic', colorFilter: ColorFilter.mode(Colors.purple.withOpacity(0.2), BlendMode.overlay)),
    ];

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      itemCount: filters.length,
      itemBuilder: (context, index) {
        final filter = filters[index];
        return FilterOption(
          filter: filter,
          imagePath: widget.imagePath,
          isSelected: _selectedFilter.name == filter.name,
          onTap: () => _applyFilter(filter),
        );
      },
    );
  }

  Widget _buildAdjustTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          AdjustmentSlider(
            label: 'Brightness',
            value: _adjustments['brightness']!,
            icon: Icons.brightness_6,
            onChanged: (value) => _updateAdjustment('brightness', value),
          ),
          AdjustmentSlider(
            label: 'Contrast',
            value: _adjustments['contrast']!,
            icon: Icons.contrast,
            onChanged: (value) => _updateAdjustment('contrast', value),
          ),
          AdjustmentSlider(
            label: 'Saturation',
            value: _adjustments['saturation']!,
            icon: Icons.palette,
            onChanged: (value) => _updateAdjustment('saturation', value),
          ),
          AdjustmentSlider(
            label: 'Sharpness',
            value: _adjustments['sharpness']!,
            icon: Icons.details,
            onChanged: (value) => _updateAdjustment('sharpness', value),
          ),
          AdjustmentSlider(
            label: 'Blur',
            value: _adjustments['blur']!,
            icon: Icons.blur_on,
            onChanged: (value) => _updateAdjustment('blur', value),
          ),
        ],
      ),
    );
  }

  Widget _buildAIMagicTab() {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildAIOption(
          icon: Icons.auto_fix_high,
          title: 'Auto Enhance',
          subtitle: 'AI-powered enhancement',
          onTap: () => _processWithAI('Auto Enhance'),
        ),
        _buildAIOption(
          icon: Icons.face_retouching_natural,
          title: 'Portrait Mode',
          subtitle: 'Blur background',
          onTap: () => _processWithAI('Portrait Mode'),
        ),
        _buildAIOption(
          icon: Icons.hd,
          title: 'Upscale HD',
          subtitle: 'Increase resolution',
          onTap: () => _processWithAI('Upscale HD'),
        ),
        _buildAIOption(
          icon: Icons.remove_red_eye,
          title: 'Remove Objects',
          subtitle: 'Erase unwanted items',
          onTap: () => _processWithAI('Remove Objects'),
        ),
        _buildAIOption(
          icon: Icons.wb_sunny,
          title: 'Sky Replace',
          subtitle: 'Change sky color',
          onTap: () => _processWithAI('Sky Replace'),
        ),
        _buildAIOption(
          icon: Icons.color_lens,
          title: 'Style Transfer',
          subtitle: 'Artistic effects',
          onTap: () => _processWithAI('Style Transfer'),
        ),
      ],
    );
  }

  Widget _buildAIOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: _isProcessing ? null : onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransformTab() {
    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildTransformOption(Icons.crop, 'Crop'),
        _buildTransformOption(Icons.rotate_90_degrees_ccw, 'Rotate'),
        _buildTransformOption(Icons.flip, 'Flip'),
        _buildTransformOption(Icons.aspect_ratio, 'Resize'),
        _buildTransformOption(Icons.straighten, 'Straighten'),
        _buildTransformOption(Icons.camera_enhance, 'Perspective'),
      ],
    );
  }

  Widget _buildTransformOption(IconData icon, String label) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label tool selected')),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}