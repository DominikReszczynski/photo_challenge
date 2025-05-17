import 'dart:io';
import 'package:cas_house/models/properties.dart';
import 'package:cas_house/services/property_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PropertiesProvider extends ChangeNotifier {
  List<Property?> _propertiesListOwner = [];

  List<Property?> get propertiesListOwner => _propertiesListOwner;

  List<Property?> _propertiesListTenant = [];

  List<Property?> get propertiesListTenant => _propertiesListTenant;

  Future<void> getAllPropertiesByOwner() async {
    try {
      final List<Property?>? result =
          await PropertyServices().getAllPropertiesByOwner();
      if (result != null) {
        _propertiesListOwner = result;
      }
    } catch (e) {
      print("Error fetching expenses: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> getAllPropertiesByTenant() async {
    try {
      final List<Property?>? result =
          await PropertyServices().getAllPropertiesByTenant();
      if (result != null) {
        _propertiesListTenant = result;
        notifyListeners();
      }
    } catch (e) {
      print("Error fetching expenses: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<bool> addProperty(Property property, File? imageFile) async {
    try {
      final result = await PropertyServices().addProperty(property, imageFile);
      if (result != null) {
        _propertiesListOwner.insert(0, result);
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("Error adding property: $e");
      return false;
    }
    return false;
  }

  Future addTenantToProperty(String propertyID, String pin) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedUserId = prefs.getString('userId');
      final Property? result = await PropertyServices()
          .addTenantToProperty(propertyID, pin, storedUserId!);
      if (result != null) {
        print('dupa');
        _propertiesListTenant.insert(0, result);
        print('dupa2');
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("Error adding tenant to property: $e");
      return false;
    }
    return false;
  }

  Future<bool> setPin(String propertyID, String pin) async {
    try {
      final result = await PropertyServices().setPin(propertyID, pin);
      if (result) {
        for (var property in _propertiesListOwner) {
          if (property!.id == propertyID) {
            property.pin = pin;
            break;
          }
        }
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("Error setting PIN: $e");
      return false;
    }
    return false;
  }

  Future<bool> deletePin(String propertyID) async {
    try {
      final result = await PropertyServices().removePin(propertyID);
      if (result) {
        for (var property in _propertiesListOwner) {
          if (property!.id == propertyID) {
            property.pin = null;
            break;
          }
        }
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("Error deleting PIN: $e");
      return false;
    }
    return false;
  }
}
