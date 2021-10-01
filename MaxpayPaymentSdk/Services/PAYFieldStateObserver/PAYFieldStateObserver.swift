import UIKit

final class PAYFieldStateObserver {
    
    // MARK: - Properties
    
    private let textFields: [PAYTextField]
    private let checkboxViews: [PAYCheckboxView]
    private let stateHandler: (Bool) -> ()
    
    // MARK: - Init and Deinit
    
    init(textFields: [PAYTextField?], checkboxes: [PAYCheckboxView], handler: @escaping (Bool) -> ()) {
        self.textFields = textFields.compactMap { $0 }
        self.checkboxViews = checkboxes
        self.stateHandler = handler
        
        self.startObservation()
    }
    
    // MARK: - Private
    
    private func startObservation() {
        self.textFields.forEach {
            $0.onTextChanged = { [weak self] in self?.updateState() }
        }
        
        self.checkboxViews.forEach {
            $0.onValueChanged = { [weak self] in self?.updateState() }
        }
    }
    
    private func updateState() {
        let isAllValid = self.textFields
            .map { $0.isValid }
            .reduce(true) { $0 && $1 }
        
        let isExpiredDateFull = self.textFields
            .compactMap { ($0 as? PAYExpiredDateField)?.isDateFull }
            .first ?? false
        
        let isAllChecked = self.checkboxViews
            .filter({ $0.isHidden == false })
            .allSatisfy ({ $0.state == .selected })
        
        self.stateHandler(isAllValid && isAllChecked && isExpiredDateFull)
    }
}

