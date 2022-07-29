//
//  ContentView.swift
//  SreenShotTest
//
//  Created by DONG SHENG on 2022/7/28.
//

// 螢幕截圖方法1
// info 要使用者提供權限 Privacy - Photo Library Additions Usage Description
//(功能) ScreenShot
// 利用  UIGraphicsImageRenderer 截圖   然後
// UIImageWriteToSavedPhotosAlbum 存到相簿內

import SwiftUI

struct ContentView: View {
    
    var textView: some View{
        Text("Hello, world!")
            .padding()
            .background(.yellow)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
    
    var imageView: some View{
        Image("Image1")
            .resizable()
            
    }
    
    
    var body: some View {
        
        VStack{
            textView
                .background(.gray) // 顏色不會被拍到照片內
            
            imageView
            
            Button {
                let image = textView.snapshot()
                let image2 = imageView.snapshot()
                
                // 需要添加詢問
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                UIImageWriteToSavedPhotosAlbum(image2, nil, nil, nil)
            } label: {
                Text("Save to Image")
                    .font(.largeTitle)
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View{
    
    func snapshot() -> UIImage{
        // 在iOS 15 有點小Bug 所以要加上 .ignoresSafeArea()
        let controller = UIHostingController(rootView: self.ignoresSafeArea())
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .green // 背景色
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
