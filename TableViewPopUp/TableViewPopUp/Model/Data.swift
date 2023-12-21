
struct Data {
    var id : Int
    let content : String
}

extension Data{
    static let list: [Data] = [
       Data(id: 1, content: "영화 보기"),
       Data(id: 2, content: "밥 먹기"),
       Data(id: 3, content: "스위프트 공부"),
       Data(id: 4, content: "운동하기"),
       Data(id: 5, content: "책 읽기")
    ]
}
