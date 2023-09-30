//
//  Data.swift
//  SearchTableView
//
//  Created by 최희진 on 2023/09/30.
//

struct Data {
    var id : Int
    let name : String
    let session: String
}

extension Data{
    static let list: [Data] = [
       Data(id: 1, name: "Chocolate Bar", session: "Chocolate"),
       Data(id: 2, name: "Chocolate Chip", session: "Chocolate"),
       Data(id: 3, name: "Dark Chocolate", session: "Chocolate"),
       Data(id: 4, name: "Lolipop", session: "Candy"),
       Data(id: 5, name: "Candy Cane", session: "Candy"),
       Data(id: 6, name: "Gummi Bear", session: "Jelly")
    ]
}
