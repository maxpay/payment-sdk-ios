import Foundation

extension DateFormatter {
    
    //  2010-09-23
    static let pay_birthdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        
        return formatter
    }()
}
