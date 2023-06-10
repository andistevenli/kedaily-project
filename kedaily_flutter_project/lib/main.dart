import 'package:flutter/material.dart';
import 'kedaily.dart';
import 'model/service/supabase_service.dart';

void main() async {
  await SupabaseService.initSupabase();
  runApp(const Kedaily());
}
