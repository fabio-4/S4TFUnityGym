import Foundation

extension Array where Element: Hashable {
    func containsKeys(dicts: Dictionary<Element, Any>...) -> Bool {
        for dict in dicts {
            for key in dict.keys {
                if !self.contains(key) {
                    return false
                }
            }
        }
        return true
    }
}
