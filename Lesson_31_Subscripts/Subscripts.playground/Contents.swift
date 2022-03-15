import UIKit


struct Book {
    let name: String
}

class Library {
    private var books: [Book] = []
    
    init(books: [Book]) {
        self.books = books
    }
    
    subscript(_ index: Int) -> Book? {
        get {
            if index >= books.count {
                return nil
            }
            
            return books[index]
        }
        set {
            books[index] = newValue!
        }
        
    }
}

let book1 = Book(name: "Война и мир")
let book2 = Book(name: "Незнайка на Луне")
let book3 = Book(name: "Преступление и наказание")

let library = Library(books: [book1, book2, book3])
library[1] = Book(name: "Математика 3 класс")

print(library[1]?.name)
