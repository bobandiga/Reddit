
import Foundation

public extension String {
    static func toElapsedTime(from date: Date) -> String? {
        let c = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date, to: Date())
        
        let strDate = ""
            .year(intereval: c.year)?
            .month(intereval: c.month)?
            .day(intereval: c.day)?
            .hour(intereval: c.hour)?
            .minute(intereval: c.minute)?
            .sec(intereval: c.second)?
            .moment()
        
        return strDate
    }
}
