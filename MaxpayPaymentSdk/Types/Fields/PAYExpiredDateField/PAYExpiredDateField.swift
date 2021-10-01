import UIKit

final internal class PAYExpiredDateField: PAYTextField {
    
    // MARK: - Subtypes
    
    private enum Constant {
        static let maxMonth = 12
        static let maxYear = 99
        
        static let separator: Character = "/"
    }

    // MARK: - Properties
    
    internal var isDateFull: Bool = false
    
    internal var expiredMonth: String? {
        return self.stringParts()?.first
    }
    
    internal var expiredYear: String? {
        return self.stringParts()?.last
    }
    
    //  01/22 without separator
    internal override var maxLength: Int {
        return 4
    }
    
    internal override var unformattedText: String? {
        return self.text?
            .split(separator: Constant.separator)
            .joined()
    }
    
    private lazy var currentYear: Int = {
        let year = Calendar.current.component(.year, from: Date()) % 100
        return year
    }()
    
    private lazy var currentMonth: Int = {
        let month = Calendar.current.component(.month, from: Date())
        return month
    }()
    
    private var isNumberAdded = false
    
    // MARK: - Public
    
    override internal func commonConfigure() {
        super.commonConfigure()
        
        self.keyboardType = .numberPad
        self.textContentType = .oneTimeCode
        self.addTarget(self, action: #selector(self.onEditingChanged), for: .editingChanged)
    }
    
    override internal func validate() -> Bool {
        let unformatted = self.text?.split(separator: Constant.separator)
        let month = unformatted?.first ?? ""
        let unformattedCount = self.unformattedText?.count ?? 0
        let isMonthValid = (1...Constant.maxMonth).contains(Int(month) ?? -1)
        
        self.isDateFull = unformattedCount == self.maxLength
        
        //  check full month else first decade number
        if unformattedCount == 2 {
            return isMonthValid
        } else if unformattedCount == 3 {
            return (Int(self.unformattedText?.suffix(1) ?? "") ?? 0) > 1 && isMonthValid  //  should be > 1, i.e from 202* and later
        }
        
        //  12/22 -> 12/2022
        let year = "20" + (unformatted?.pay_object(at: 1) ?? "")
        let fullDate = (month + "/" + year).pay_string
        let formatter = DateFormatter.expieredDate
        
        guard let enteredDate = formatter.date(from: fullDate) else { return false }
        
        let endOfMonth = Calendar.current.date(byAdding: .month, value: 1, to: enteredDate)!
        let now = Date()
        
        return endOfMonth > now
    }
    
    //  do not call super in this method, we override common behaviour
    //  on other fields validation execute on reach maxLength
    //  on this field we check separatly month, year and full date
    override internal func onEditingChanged(_ sender: PAYTextField) {
        self.format(text: text)
                
        guard let count = self.unformattedText?.count else { return }
        
        super.onEditingChanged(self)

        if (2...4).contains(count) {
            self.updateFieldAppearance()
        } else {
            self.resetFieldAppearance()
        }
    }
    
    // MARK: - Private
    
    private func format(text: String?) {
        guard let text = text else { return }
        
        let separator = Constant.separator
        
        if self.isNumberAdded && text.count == 2 {
            //  12 after enter -> 12/
            self.text?.append(separator)
        } else if text.count == 3 && !text.hasSuffix(String(separator)) {
            //  123 after enter -> 12/3
            var mutableText = text
            let suffix = mutableText.removeLast()
            mutableText.append(separator)
            mutableText.append(suffix)
            self.text = mutableText
        } else if !self.isNumberAdded && (text.count == 3 || text.count == 2) {
            //  12/3 after backspace -> 12
            //  12/ after backspace -> 1
            var mutableText = text
            mutableText.removeLast()
            self.text = mutableText
        } else if text.count > 3 && !text.contains(separator) {  //  probably copy-paste action
            var formatted = String(text.trimmingCharacters(in: .whitespacesAndNewlines).prefix(self.maxLength))
            formatted.insert(separator, at: text.index( text.startIndex, offsetBy: 2))
            self.text = formatted
        }
    }
    
    private func stringParts() -> [String]? {
        return self.text?
            .split(separator: Constant.separator)
            .map { $0.pay_string }
    }
    
    // MARK: - UITextFieldDelegate

    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        let unformattedCount = self.unformattedText?.count ?? 0

        let isFilled = unformattedCount == self.maxLength
        let isDigit = trimmed.first.map { CharacterSet.decimalDigits.pay_contains(character: $0) } ?? false
        let isBackspace = trimmed.isEmpty

        let isNewDigitEnabled = isDigit && !isFilled
        self.isNumberAdded = isNewDigitEnabled

        return isNewDigitEnabled || isBackspace
    }
}

extension DateFormatter {

    static let expieredDate: DateFormatter = {
        return DateFormatter().configure(formatString: "MM/yyyy")
    }()

    @discardableResult
    private func configure(formatString: String) -> DateFormatter {
        self.dateFormat = formatString
        self.timeZone = TimeZone.current
        self.locale = Locale.current

        return self
    }
}
