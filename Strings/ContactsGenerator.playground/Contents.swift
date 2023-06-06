/*:
 # Overview
 */

/*:
 # Code
 */

/*:
 # Tests
 */
import Foundation
import Contacts

func craeteFakeContacts() {
    var namesIterator = lines(in: readFile(name: "names.txt"))
    var emailsIterator = lines(in: readFile(name: "emails.txt"))
    var phoneIterator = lines(in: readFile(name: "phone_numbers.txt"))
    
    guard let nextName = namesIterator.next(),
          let nextEmail = emailsIterator.next(),
          let nextPhone = phoneIterator.next() else {
        fatalError()
    }
    print(nextName, nextEmail, nextPhone)
    createContact(name: String(nextName), email: String(nextEmail), phone: String(nextPhone))
}

func createContact(name: String, email: String, phone: String) {
    let mutableContact = CNMutableContact()
    let (givenName, familiyName) = splitName(name)
    mutableContact.givenName = givenName
    mutableContact.familyName = familiyName
    
    let sanitizedPhone = phone
    let phoneNumber = CNLabeledValue(label: CNLabelPhoneNumberiPhone, value: CNPhoneNumber(stringValue: sanitizedPhone))
    mutableContact.phoneNumbers = [phoneNumber]
    
    let emailAddress = CNLabeledValue(label: CNLabelHome, value: email as NSString)
    mutableContact.emailAddresses = [emailAddress]
    
    let store = CNContactStore()
    do {
        let saveRequest = CNSaveRequest()
        saveRequest.add(mutableContact, toContainerWithIdentifier: nil)
        try store.execute(saveRequest)
    } catch {
        fatalError(error.localizedDescription)
    }
}

func lines(in string: String) -> IndexingIterator<Array<Substring>> {
    string.split(separator: "\n")
        .makeIterator()
}

func readFile(name: String) -> String {
    guard let nameExtension = nameExtension(filename: name) else  {
        fatalError("Inavalid filename")
    }
    guard let url = Bundle.main.url(forResource: nameExtension.name,
                                    withExtension: nameExtension.extension) else {
        fatalError("Resource not found")
    }
    do {
        let fileData = try Data(contentsOf: url)
        guard let fileContent = String(data: fileData, encoding: .ascii) else {
            fatalError("Unable to read files data content")
        }
        return fileContent
    } catch {
        fatalError(error.localizedDescription)
    }
}

func splitName(_ name: String) -> (given: String, family: String) {
    let splitNameArray = name.split(separator: " ")
    guard let givenName = splitNameArray.first,
          let familyName = splitNameArray.last else {
        fatalError("Unable to split name")
    }
    return (given: String(givenName), family: String(familyName))
}

typealias NameExtension = (name: String, extension: String)
func nameExtension(filename: String) -> NameExtension? {
    guard let extensionRange = filename.range(of: "\\.[^\\.]{3,}$", options: .regularExpression) else {
        return nil
    }
    let name = filename[filename.startIndex ..< extensionRange.lowerBound]
    let ext = filename[extensionRange.lowerBound ..< extensionRange.upperBound]
    return (name: String(name), extension: String(ext))
}

import XCTest
class Tests: XCTestCase {
    
    func testFoo() {
        XCTAssertTrue(true)
    }
}

runTests(Tests())
