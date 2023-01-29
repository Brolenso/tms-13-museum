extension String {
    func removeSpaces() -> String {
        var resultString = self
        resultString.removeAll { $0 == " " }
        return resultString
    }
}
