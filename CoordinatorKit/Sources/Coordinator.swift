//
//  Coordinator.swift
//
//  Created by Alex Manarpies on 30/05/16.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

public protocol Coordinator: class {
    func start()
}

public protocol ComposableCoordinator: Coordinator {
    var childCoordinators: [Coordinator] { get set }
}

extension ComposableCoordinator {
    public func findChildCoordinator<T>(_ type: T.Type) -> T? {
        return childCoordinators.filter({ (coordinator) -> Bool in
            return coordinator is T
        }).first as? T
    }
    
    public func removeChildCoordinator<T:Coordinator>(_ coordinator:T) -> T? {
        if let  potentialIndex = childCoordinators.index(where: { $0 is T }) {
            let index = Int(potentialIndex)
            childCoordinators.remove(at: index)
        }
        
        return coordinator
    }
}
