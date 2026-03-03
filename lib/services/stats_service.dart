import '../models/city.dart';
import '../models/resident.dart';
import 'data_service.dart';

class StatsService {

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
}