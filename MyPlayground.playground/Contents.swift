import UIKit

var greeting = "Hello, playground"

var name = "world"
let closure = { [name] in
print("Hello \(name)")
}
name = "hello"
closure()

class HTMLElement {

    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        if let text = self.text {
            // #1
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            // #2
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        // #3
        print("\(name) is being deinitialized")
    }

}

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
paragraph = nil
