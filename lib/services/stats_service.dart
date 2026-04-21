import '../models/city.dart';
import '../models/resident.dart';
import 'data_service.dart';
import 'package:flutter/material.dart';

class StatsService {

  static const List<Color> possibleEyeColors = [
    Colors.brown,
    Colors.blue,
    Colors.green,
    Colors.grey,
    Colors.red,
  ];

  static const List<Color> possibleHairColors = [
    Colors.black,
    Colors.brown,
    Colors.yellow,
    Colors.grey,
    Colors.white,
  ];

  static int getTotalPopulation({City? selectedCity}) {
    if (selectedCity != null) {
      return selectedCity.population; 
    }
    
    int total = 0;
    for (var city in DataService.cities) {
      total += city.population;
    }
    return total;
  }

  static int getTotalHouses({City? selectedCity}) {
    if (selectedCity != null) {
      return selectedCity.houses.length; 
    }
    
    int total = 0;
    for (var city in DataService.cities) {
      total += city.houses.length;
    }
    return total;
  }
  
  static int getAverageAge({City? selectedCity}) {
    List<Resident> allResidents = [];
    
    if (selectedCity != null) {
      for (var house in selectedCity.houses) {
        allResidents.addAll(house.residents);
      }
    } else {
      for (var city in DataService.cities) {
        for (var house in city.houses) {
          allResidents.addAll(house.residents);
        }
      }
    }
    
    if (allResidents.isEmpty) return 0;
    
    int totalAge = allResidents.fold(0, (sum, resident) => sum + resident.age);
    return (totalAge / allResidents.length).round();
  }

  static int getEyeColorValueForChart(Color? color, City? selectedCity) {
    if (color == null) return 0;

    List<Resident> allResidents = [];
    
    if (selectedCity != null) {
      for (var house in selectedCity.houses) {
        allResidents.addAll(house.residents);
      }
    } else {
      for (var city in DataService.cities) {
        for (var house in city.houses) {
          allResidents.addAll(house.residents);
        }
      }
    }

    int count = 0;
    for (var resident in allResidents) {
      if (resident.traits.eyeColor == color) {
        count++;
      }
    }
    return count;
    
  }

  static int getHairColorValueForChart(Color? color, City? selectedCity) {
    if (color == null) return 0;

    List<Resident> allResidents = [];
    
    if (selectedCity != null) {
      for (var house in selectedCity.houses) {
        allResidents.addAll(house.residents);
      }
    } else {
      for (var city in DataService.cities) {
        for (var house in city.houses) {
          allResidents.addAll(house.residents);
        }
      }
    }

    int count = 0;
    for (var resident in allResidents) {
      if (resident.traits.hairColor == color) {
        count++;
      }
    }
    return count;
    
  }

  static String getEyeColorPercentageForChart(Color? color, City? selectedCity) {
    if (color == null) return '0%';

    List<Resident> allResidents = [];
    
    if (selectedCity != null) {
      for (var house in selectedCity.houses) {
        allResidents.addAll(house.residents);
      }
    } else {
      for (var city in DataService.cities) {
        for (var house in city.houses) {
          allResidents.addAll(house.residents);
        }
      }
    }

    int count = 0;
    for (var resident in allResidents) {
      if (resident.traits.eyeColor == color) {
        count++;
      }
    }

    if (allResidents.isEmpty) return '0%';
    
    double percentage = (count / allResidents.length) * 100;
    return '${percentage.toStringAsFixed(1)}%';
  }

  static String getHairColorPercentageForChart(Color? color, City? selectedCity) {
    if (color == null) return '0%';

    List<Resident> allResidents = [];
    
    if (selectedCity != null) {
      for (var house in selectedCity.houses) {
        allResidents.addAll(house.residents);
      }
    } else {
      for (var city in DataService.cities) {
        for (var house in city.houses) {
          allResidents.addAll(house.residents);
        }
      }
    }

    int count = 0;
    for (var resident in allResidents) {
      if (resident.traits.hairColor == color) {
        count++;
      }
    }

    if (allResidents.isEmpty) return '0%';
    
    double percentage = (count / allResidents.length) * 100;
    return '${percentage.toStringAsFixed(1)}%';
  }

  static int getResidentsWithNoEyeColor({City? selectedCity}) {
    List<Resident> allResidents = [];
    
    if (selectedCity != null) {
      for (var house in selectedCity.houses) {
        allResidents.addAll(house.residents);
      }
    } else {
      for (var city in DataService.cities) {
        for (var house in city.houses) {
          allResidents.addAll(house.residents);
        }
      }
    }

    return allResidents.where((r) => r.traits.eyeColor == null).length;
  }

  static int getResidentsWithNoHairColor({City? selectedCity}) {
    List<Resident> allResidents = [];
    
    if (selectedCity != null) {
      for (var house in selectedCity.houses) {
        allResidents.addAll(house.residents);
      }
    } else {
      for (var city in DataService.cities) {
        for (var house in city.houses) {
          allResidents.addAll(house.residents);
        }
      }
    }

    return allResidents.where((r) => r.traits.hairColor == null).length;
  }

  static String getResidentsWithNoEyeColorPercentage({City? selectedCity}) {
    List<Resident> allResidents = [];
    
    if (selectedCity != null) {
      for (var house in selectedCity.houses) {
        allResidents.addAll(house.residents);
      }
    } else {
      for (var city in DataService.cities) {
        for (var house in city.houses) {
          allResidents.addAll(house.residents);
        }
      }
    }

    int count = allResidents.where((r) => r.traits.eyeColor == null).length;

    if (allResidents.isEmpty) return '0%';
    
    double percentage = (count / allResidents.length) * 100;
    return '${percentage.toStringAsFixed(1)}%';
  }

  static String getResidentsWithNoHairColorPercentage({City? selectedCity}) {
    List<Resident> allResidents = [];
    
    if (selectedCity != null) {
      for (var house in selectedCity.houses) {
        allResidents.addAll(house.residents);
      }
    } else {
      for (var city in DataService.cities) {
        for (var house in city.houses) {
          allResidents.addAll(house.residents);
        }
      }
    }

    int count = allResidents.where((r) => r.traits.hairColor == null).length;

    if (allResidents.isEmpty) return '0%';
    
    double percentage = (count / allResidents.length) * 100;
    return '${percentage.toStringAsFixed(1)}%';
  }
}