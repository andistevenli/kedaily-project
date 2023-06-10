import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static initSupabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Supabase.initialize(
      url: 'https://ptgkhejarygqxdoyldbi.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB0Z2toZWphcnlncXhkb3lsZGJpIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4MzczMzkxNSwiZXhwIjoxOTk5MzA5OTE1fQ.9-IemXCLeq_DPt5E3kdHZEha8yxpyuRgNwkiW4lf71o',
    );
  }
}
