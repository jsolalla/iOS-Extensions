//
//  String+Extensions.swift
//  Extensions
//
//  Created by Jesus Santa Olalla on 2/14/19.
//  Copyright © 2018 jsolalla. All rights reserved.
//

import UIKit

extension StringProtocol where Index == String.Index {
    
    func nsRange(from range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
}

extension String {
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with value: String) -> String {
        return String(format: NSLocalizedString(self, comment: ""), value)
    }
    
    func toDouble() -> Double {
        return Double(self) ?? 0.0
    }
    
    func toDate(with format: String = "dd/MM/yyyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    func size(font: UIFont, width: CGFloat, insets: UIEdgeInsets = UIEdgeInsets.zero) -> CGRect {
        let constrainedSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let attributes = [NSAttributedString.Key.font: font]
        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
        var bounds = (self as NSString).boundingRect(with: constrainedSize, options: options, attributes: attributes, context: nil)
        bounds.size.width = width
        bounds.size.height = ceil(bounds.height + insets.top + insets.bottom)
        return bounds
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func sizeTextCGRect(widthCustom: CGFloat = CGFloat.greatestFiniteMagnitude, heightCustom: CGFloat = CGFloat.greatestFiniteMagnitude, fontCustom: UIFont) -> CGRect {
        let attrString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.font: fontCustom])
        let rectSize = attrString.boundingRect(with: CGSize(width: widthCustom, height: heightCustom), options: .usesLineFragmentOrigin, context: nil)
        return rectSize
    }
    
    func toInt() -> Int {
        return Int(self) ?? 0
    }

    func trimmWhiteSpaces() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    func containsIgnoringCase(_ find: String) -> Bool {
        let selfNoDiacritic = self.folding(options: .diacriticInsensitive, locale: .current)
        return (selfNoDiacritic.range(of: find, options: .caseInsensitive, range: nil, locale: nil) != nil)
    }
    
    func noDiacritic() -> String {
        return trimmWhiteSpaces().lowercased().folding(options: .diacriticInsensitive, locale: .current)
    }
    
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
    func strikeThrough() -> NSMutableAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter {CharacterSet.decimalDigits.contains( $0 )}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    var htmlToAttributedString: NSMutableAttributedString? {
        return Data(utf8).htmlAttributedString
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
}

extension NSMutableAttributedString {
    
    @discardableResult func bold(_ text: String, font: UIFont, fontColor: UIColor = .black, size: CGFloat = 17) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: fontColor]
        let boldString = NSMutableAttributedString(string: text, attributes: attrs)
        append(boldString)
        return self
    }
    
    @discardableResult func normal(_ text: String, font: UIFont, fontColor: UIColor = .black, size: CGFloat = 17) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: fontColor]
        let normal = NSAttributedString(string: text, attributes: attrs)
        append(normal)
        return self
    }
    
    func setFontFace(font: UIFont, color: UIColor? = nil) {
        beginEditing()
        self.enumerateAttribute(.font, in: NSRange(location: 0, length: self.length)) { (value, range, stop) in
            if let f = value as? UIFont, let newFontDescriptor = f.fontDescriptor.withFamily(font.familyName).withSymbolicTraits(f.fontDescriptor.symbolicTraits) {
                let newFont = UIFont(descriptor: newFontDescriptor, size: font.pointSize)
                removeAttribute(.font, range: range)
                addAttribute(.font, value: newFont, range: range)
                if let color = color {
                    removeAttribute(.foregroundColor, range: range)
                    addAttribute(.foregroundColor, value: color, range: range)
                }
            }
        }
        endEditing()
    }
    
}
