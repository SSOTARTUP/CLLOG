//
//  LottieConfettiView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/8/23.
//

import SwiftUI
import UIKit
import Lottie

struct LottieConfettiView: UIViewRepresentable {
    typealias UIViewType = UIView
    
    var filename : String
    
    func makeUIView(context: UIViewRepresentableContext<LottieConfettiView>) -> UIView {
        let view = UIView(frame: .zero)

        let animationView = LottieAnimationView()

        animationView.animation = LottieAnimation.named(filename)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop

        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            //레이아웃의 높이와 넓이의 제약
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<LottieConfettiView>) {

    }
}
