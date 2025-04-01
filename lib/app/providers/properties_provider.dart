import 'package:flutter/material.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

class PropertiesProvider extends RemoteProvider {
  int getTypePropertyEnum(String type) {
    if (type == "Casa") {
      return 0;
    }
    return 1;
  }

  Future<List<Property>> getProperties(PropertyFilter filter) async {
    String endpoint = Urls.family.properties;
    if (filter.lat != null) {
      endpoint += "?Lat=${null}";
    }
    if (filter.lng != null) {
      endpoint += "&Lng=${null}";
    }
    if (filter.typeProperty != null) {
      endpoint += "&TypeProperty=${filter.typeProperty}";
    }
    if (filter.startSquareFootage != null) {
      endpoint += "&StartSquareFootage=${filter.startSquareFootage}";
    }
    if (filter.endSquareFootage != null) {
      endpoint += "&EndSquareFootage=${filter.endSquareFootage}";
    }
    if (filter.startCondominiumValue != null) {
      endpoint += "&StartCondominiumValue=${filter.startCondominiumValue}";
    }
    if (filter.endCondominiumValue != null) {
      endpoint += "&EndCondominiumValue=${filter.endCondominiumValue}";
    }
    if (filter.startIptuValue != null) {
      endpoint += "&StartIptuValue=${filter.startIptuValue}";
    }
    if (filter.endIptuValue != null) {
      endpoint += "&EndIptuValue=${filter.endIptuValue}";
    }
    if (filter.neighborhood != null) {
      endpoint += "&Neighborhood=${filter.neighborhood}";
    }
    if (filter.startNumberOfBedrooms != null) {
      endpoint += "&StartNumberOfBedrooms=${filter.startNumberOfBedrooms}";
    }
    if (filter.endNumberOfBedrooms != null) {
      endpoint += "&EndNumberOfBedrooms=${filter.endNumberOfBedrooms}";
    }
    if (filter.hasGarage != null) {
      endpoint += "&HasGarage=${filter.hasGarage}";
    }
    if (filter.hasAccessLadder != null) {
      endpoint += "&HasAccessLadder=${filter.hasAccessLadder}";
    }
    if (filter.hasAccessRamp != null) {
      endpoint += "&HasAccessRamp=${filter.hasAccessRamp}";
    }
    if (filter.hasAdaptedToPcd != null) {
      endpoint += "&HasAdaptedToPcd=${filter.hasAdaptedToPcd}";
    }
    print('endpoint ${endpoint}');
    try {
      final response = await get(endpoint);
      return (response.data as List).map((item) {
        final Property property = Property.fromJson(item);
        property.residencialPropertyFeatures.isInterested = false;
        return property;
      }).toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<bool> confirmInterest(String familyId, String propertyId) async {
    try {
      await post(
        Urls.family.interestProperty,
        body: {
          'familyId': familyId,
          'residencialPropertyId': propertyId,
        },
      );
      return true;
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<bool> refuseInterest(String familyId, String propertyId) async {
    try {
      await post(
        Urls.family.desinterestProperty,
        body: {
          'familyId': familyId,
          'residencialPropertyId': propertyId,
        },
      );
      return true;
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<List<Property>> getMatchs(String id) async {
    final endpoint = Urls.family.matchs;
    try {
      final response = await get('$endpoint/$id');
      return (response.data as List).map((item) {
        final Property property = Property.fromJson(item);
        property.residencialPropertyFeatures.isInterested = true;
        return property;
      }).toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<List<String>> getRegisteredNeighborhoods() async {
    final endpoint = Urls.family.registeredNeighborhoods;
    try {
      final response = await get('$endpoint');
      return (response.data as List).map((e) => e.toString()).toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<int> getCountInterestingFamilyInTheProperty(String familyId) async {
    final endpoint = Urls.family.countInterestingFamilyInTheProperty;
    try {
      final response = await get('$endpoint/$familyId');
      return response.data as int;
    } on MegaResponseException catch (e) {
      return 0;
    }
  }
}
