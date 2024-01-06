//
//  HealthKitManager.swift
//  SleepDebt
//
//  Created by Oliver Hnát on 06.01.2024.
//

import Foundation
import HealthKit

enum Days: Int, CaseIterable {
    case seven = 7
    case thirty = 30
    case threehundredsixtyfive = 365
}

class HealthKitManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    @Published var sleepForLastXDays: Dictionary<Days, Int> = [:]
    
    init() {
        let sleep = HKCategoryType(.sleepAnalysis)
        
        let healthTypes: Set = [sleep]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            } catch {
                print(error)
            }
        }
        self.updateSleep()
    }
    
    func updateSleep() {
        self.getSleepForLastXDays(days: .seven)
        self.getSleepForLastXDays(days: .thirty)
        self.getSleepForLastXDays(days: .threehundredsixtyfive)
    }
    
    func getSleepForLast7Days() -> Int {
        self.getSleepForLastXDays(days: .seven)
        return self.sleepForLastXDays[Days.seven] ?? 0
    }
    
    func getSleepForLast30Days() -> Int{
        self.getSleepForLastXDays(days: .thirty)
        return self.sleepForLastXDays[Days.thirty] ?? 0
    }
    
    func getSleepForLast365Days() -> Int{
        self.getSleepForLastXDays(days: .threehundredsixtyfive)
        return self.sleepForLastXDays[Days.threehundredsixtyfive] ?? 0
    }
    
    private func getSleepForLastXDays(days: Days) {
        var totalSleep = 0
        let sleep = HKCategoryType(.sleepAnalysis)
        let sleepPredicate = HKCategoryValueSleepAnalysis.predicateForSamples(equalTo: HKCategoryValueSleepAnalysis.allAsleepValues)
        
        let lastXDays = Date().addingTimeInterval(TimeInterval(-60 * 60 * 24 * days.rawValue))
        
        let datePredicate = HKQuery.predicateForSamples(withStart: lastXDays, end: .now)
        let predicates = NSCompoundPredicate(andPredicateWithSubpredicates: [sleepPredicate, datePredicate])
        let sortByDate = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(
            sampleType: sleep,
            predicate: predicates,
            limit: 100000,
            sortDescriptors: [sortByDate])
        { _, results, error in
            for(_, sample) in results!.enumerated() {
                guard let currData:HKCategorySample = sample as? HKCategorySample else { print("There was an error"); return }
                
                let endDate = currData.endDate
                let startDate = currData.startDate
                let seconds = Int(endDate.timeIntervalSince(startDate))
                totalSleep += seconds
            }
            DispatchQueue.main.async {
                self.sleepForLastXDays[days] = totalSleep
            }
        }
        healthStore.execute(query)
    }
}
