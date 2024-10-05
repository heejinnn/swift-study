import SwiftUI

struct ContentView: View {
    var body: some View {
        MyGallary()
    }
}

struct MyGallary: View {
    @State private var currentPage: Int =  0
    @State private var currentArtist: String = "이암"
    @State private var currentArtYear: String = "미상"
    @State private var currentArtTitle: String = "어미개와 강아지(모견도)"
    @State private var currentArtResource: String = "From 국립중앙박물관"
    @State private var currentPaintAsset: String = "puppy"
    
    var body: some View {
        VStack(alignment: .center) {
            MyPicture(
                currentPaintAsset: $currentPaintAsset,
                currentArtResource: $currentArtResource,
                currentArtTitle: $currentArtTitle
            )
            PictureArtistAndName(
                currentArtTitle: $currentArtTitle, currentArtist: $currentArtist, currentArtYear: $currentArtYear
            )
            NextAndPreviousButton(currentPage: $currentPage)
        }
        .onChange(of: currentPage) {
            switch currentPage {
            case 0:
                currentArtist = "이암"
                currentArtYear = "미상"
                currentArtTitle = "어미개와 강아지(모견도)"
                currentArtResource = "From 국립중앙박물관"
                currentPaintAsset = "puppy"
            case 1:
                currentArtist = "미상"
                currentArtYear = "미상"
                currentArtTitle = "복식화"
                currentArtResource = "From 국립중앙박물관"
                currentPaintAsset = "cloth"
            default:
                currentArtist = "김홍도"
                currentArtYear = "1970"
                currentArtTitle = "서당, 《단원 풍속도첩》"
                currentArtResource = "From 국립중앙박물관"
                currentPaintAsset = "school"
            }
        }
    }
}

struct MyPicture: View {
    @Binding var currentPaintAsset: String
    @Binding var currentArtResource: String
    @Binding var currentArtTitle: String
    
    var body: some View {
        Spacer()
        VStack(alignment: .leading) {
            Image(currentPaintAsset, label: Text(currentArtTitle))
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 400)
                .background(Color.white)
                .border(Color.teal, width: 3)
                .shadow(radius: 10)
                .labelsHidden()
            Text(currentArtResource)
        }
        .padding(20)
    }
}

struct PictureArtistAndName: View {
    @Binding var currentArtTitle: String
    @Binding var currentArtist: String
    @Binding var currentArtYear: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(currentArtTitle)
                    .font(.system(size: 28))
                Spacer()
            }
            HStack {
                Text(currentArtist)
                    .fontWeight(.bold)
                Text("(\(currentArtYear))")
                Spacer()
            }
        }
        .padding(20)
        .background(Material.ultraThick)
        .padding(.horizontal, 20)
    }
}

struct NextAndPreviousButton: View {
    @Binding var currentPage: Int
    
    var body: some View {
        Spacer()
        HStack {
            Button {
                currentPage =  updateCurrentPage(isNext: false, currentPage: currentPage)
            } label: {
                Text("Previous")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            Button {
                currentPage =  updateCurrentPage(isNext: true, currentPage: currentPage)
            } label: {
                Text("Next")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
        }
        .padding(20)
    }
    
    internal func updateCurrentPage(isNext: Bool, currentPage: Int) -> Int {
        var newPage = currentPage
        if isNext {
            newPage += 1
        } else {
            if currentPage < 1 {
                newPage = 2
            } else {
                newPage -= 1
            }
        }
        newPage %= 3
        return newPage
    }
}

#Preview {
    ContentView()
}
