//
//  Dynamic.swift
//  PizzaShop
//
//  Created by Владимир Рубис on 08.05.2022.
//

import Foundation

/// Биндинг. Нашел такой способ отслеживания изменений,
/// разобрался только при взаимодействии VC и его VM
class Dynamic<T> {
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    var value: T {
        didSet {
            listener?(value )
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
