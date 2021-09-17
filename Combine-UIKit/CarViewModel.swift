import Combine

struct CarViewModel {
    var car: Car
    
    lazy var batterySubject: AnyPublisher<String?, Never> = {
        return car.$kwhInBattery.map({ newCharge in
            return "The car now has \(newCharge)kwh in its battery"
        }).eraseToAnyPublisher()
    }()
    
    mutating func drive(kilometers: Double) {
        let kwhNeeded = kilometers * car.kwhPerKilometer
        
        assert(kwhNeeded <= car.kwhInBattery, "Can't make trip, not enough charge in battery")
        
        car.kwhInBattery -= kwhNeeded
    }
}
