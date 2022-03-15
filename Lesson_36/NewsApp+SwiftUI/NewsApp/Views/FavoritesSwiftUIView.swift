//
//  FavoritesSwiftUIView.swift
//  NewsApp
//
//  Created by Nickolai Nikishin on 12.03.22.
//

import SwiftUI
import Kingfisher

struct FavoritesSwiftUIView: View {
    @ObservedObject var viewModel: ArticlesViewModel
    var body: some View {
        List(viewModel.articles) { article in
            NewsRow(article: article)
        }
    }
}

class ArticlesViewModel: ObservableObject {
    @Published var articles: [Article] = []
}

struct NewsRow: View {
    var article: Article
    static let imageSize = CGSize(width: 150, height: 150)
    let processor = DownsamplingImageProcessor(size: Self.imageSize)
    |> RoundCornerImageProcessor(cornerRadius: 20)
    
    var body: some View {
        VStack {
            HStack {
                if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
                    KFImage.url(url)
                        .placeholder({
                            Image("placeholder")
                        })
                        .setProcessor(processor)
                        .loadDiskFileSynchronously()
                        .cacheOriginalImage()
                        .fade(duration: 0.25)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Self.imageSize.width, height: Self.imageSize.height, alignment: .center)
                    
                }
                Text(article.title).padding().font(.system(size: 20))
                
                Spacer()
            }.padding()
            Text(article.description)
            Spacer()
        }
    }
}

struct FavoritesSwiftUIView_Previews: PreviewProvider {
    
    static var previews: some View {
        let articlesViewModel = ArticlesViewModel()
        FavoritesSwiftUIView(viewModel: articlesViewModel)
            .previewDevice("iPhone 13 Pro")
    }
}
