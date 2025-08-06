import 'package:flutter/material.dart';

import 'dart:async'; // For Timer
import 'package:alarmo/common_widgets/custom_button.dart';
import 'package:alarmo/helpers/date_formatter.dart'; // Import the separate DateFormatter

// Alarm model class to represent each alarm
class Alarm {
  final DateTime time; // Time when alarm should ring
  bool isEnabled; // Whether alarm is turned on/off
  
  Alarm(this.time, {this.isEnabled = true});
}

// ViewModel to manage alarm state
class HomeViewModel extends ChangeNotifier {
  final List<Alarm> _alarms = []; // Private list of alarms
  String _selectedLocation = "79 Regent's Park Rd, London\nNW1 8UY, United Kingdom"; // Default location

  // Getter for alarms list
  List<Alarm> get alarms => _alarms;
  // Getter for selected location
  String get selectedLocation => _selectedLocation;

  // Add new alarm to the list
  void addAlarm(DateTime time) {
    _alarms.add(Alarm(time));
    // Sort alarms by time for chronological display
    _alarms.sort((a, b) => a.time.compareTo(b.time));
    notifyListeners(); // Notify UI to rebuild
  }

  // Remove alarm at specific index
  void removeAlarm(int index) {
    if (index >= 0 && index < _alarms.length) {
      _alarms.removeAt(index);
      notifyListeners(); // Notify UI to rebuild
    }
  }

  // Toggle alarm on/off state
  void toggleAlarm(int index) {
    if (index >= 0 && index < _alarms.length) {
      _alarms[index].isEnabled = !_alarms[index].isEnabled;
      notifyListeners(); // Notify UI to rebuild
    }
  }

  // Update selected location
  void updateLocation(String location) {
    _selectedLocation = location;
    notifyListeners(); // Notify UI to rebuild
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Create view model instance
  final HomeViewModel _viewModel = HomeViewModel();
  // Current time and date for display
  late DateTime _currentDateTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Initialize current time
    _currentDateTime = DateTime.now();
    // Update time every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentDateTime = DateTime.now();
      });
    });
    
    // Add some sample alarms for demonstration
    _viewModel.addAlarm(DateTime.now().add(const Duration(hours: 1)));
    _viewModel.addAlarm(DateTime.now().add(const Duration(hours: 2, minutes: 35)));
    _viewModel.addAlarm(DateTime.now().add(const Duration(days: 1, hours: -1)));
  }

  @override
  void dispose() {
    // Cancel the timer when widget is disposed
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Dark background to match design
      backgroundColor: const Color(0xFF1E1E1E),
      // Custom app bar with current time and date
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E), // Match background
        elevation: 0, // No shadow
        automaticallyImplyLeading: false, // Remove back button
        centerTitle: true, // Center the title
        title: Column(
          children: [
            // Current time display - large and prominent
            Text(
              DateFormatter.formatTime(_currentDateTime),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28, // Large font for current time
                fontWeight: FontWeight.bold,
              ),
            ),
            // Current date display - smaller below time
            Text(
              DateFormatter.formatDate(_currentDateTime),
              style: const TextStyle(
                color: Colors.white70, // Slightly muted color
                fontSize: 14, // Smaller font for date
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Overall padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selected Location Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D), // Dark gray background
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location section title
                  const Text(
                    'Selected Location',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Location details with icon
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white70,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _viewModel.selectedLocation,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Add Alarm button
                  CustomButton.gray(
                    text: 'Add Alarm',
                    onPressed: _showAddAlarmDialog,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24), // Space between sections
            
            // Alarms Section
            const Text(
              'Alarms',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Alarms List
            Expanded(
              child: AnimatedBuilder(
                animation: _viewModel,
                builder: (context, child) {
                  // Show message if no alarms
                  if (_viewModel.alarms.isEmpty) {
                    return const Center(
                      child: Text(
                        'No alarms set',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }
                  
                  // Display list of alarms
                  return ListView.separated(
                    itemCount: _viewModel.alarms.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final alarm = _viewModel.alarms[index];
                      return _buildAlarmCard(alarm, index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build individual alarm card widget
  Widget _buildAlarmCard(Alarm alarm, int index) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D), // Dark gray background
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Row(
        children: [
          // Time and date section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display alarm time
                Text(
                  DateFormatter.formatTime(alarm.time),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // Display alarm date
                Text(
                  DateFormatter.formatShortDate(alarm.time),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Toggle switch and delete button
          Row(
            children: [
              // On/Off toggle switch
              Switch(
                value: alarm.isEnabled,
                onChanged: (value) => _viewModel.toggleAlarm(index),
                activeColor: const Color(0xFF6366F1), // Purple when active
                inactiveThumbColor: Colors.white54,
                inactiveTrackColor: Colors.white24,
              ),
              const SizedBox(width: 8),
              // Delete alarm button
              IconButton(
                onPressed: () => _viewModel.removeAlarm(index),
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.white54,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Show modern date and time picker dialog
  void _showAddAlarmDialog() {
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF2D2D2D), // Dark background
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text(
                'Add New Alarm',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Date selection
                  ListTile(
                    leading: const Icon(Icons.calendar_today, color: Colors.white70),
                    title: const Text(
                      'Date',
                      style: TextStyle(color: Colors.white70),
                    ),
                    subtitle: Text(
                      DateFormatter.formatDate(selectedDate),
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        // Modern date picker theme with better contrast
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color(0xFF6366F1), // Purple for selections
                                onPrimary: Colors.white, // White text on purple
                                surface: Colors.white, // White background
                                onSurface: Colors.black87, // Dark text on white
                                secondary: Color(0xFF6366F1),
                                onSecondary: Colors.white,
                              ),
                              textTheme: const TextTheme(
                                headlineMedium: TextStyle(
                                  fontSize: 24, // Larger header text
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                bodyLarge: TextStyle(
                                  fontSize: 18, // Larger body text
                                  color: Colors.black87,
                                ),
                                bodyMedium: TextStyle(
                                  fontSize: 16, // Larger body text
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null && picked != selectedDate) {
                        setDialogState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                  ),
                  
                  // Time selection
                  ListTile(
                    leading: const Icon(Icons.access_time, color: Colors.white70),
                    title: const Text(
                      'Time',
                      style: TextStyle(color: Colors.white70),
                    ),
                    subtitle: Text(
                      selectedTime.format(context),
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                        // Modern time picker theme with better contrast
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color(0xFF6366F1), // Purple for selections
                                onPrimary: Colors.white, // White text on purple
                                surface: Colors.white, // White background
                                onSurface: Colors.black87, // Dark text on white
                                secondary: Color(0xFF6366F1),
                                onSecondary: Colors.white,
                              ),
                              textTheme: const TextTheme(
                                headlineMedium: TextStyle(
                                  fontSize: 28, // Large time display
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                bodyLarge: TextStyle(
                                  fontSize: 18, // Larger body text
                                  color: Colors.black87,
                                ),
                                bodyMedium: TextStyle(
                                  fontSize: 16, // Larger body text
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null && picked != selectedTime) {
                        setDialogState(() {
                          selectedTime = picked;
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                // Cancel button
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
                // Add alarm button
                TextButton(
                  onPressed: () {
                    // Combine selected date and time
                    final DateTime alarmDateTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    );
                    
                    // Add alarm to view model
                    _viewModel.addAlarm(alarmDateTime);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Add Alarm',
                    style: TextStyle(color: Color(0xFF6366F1)),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}