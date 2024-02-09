//
//  ViewController.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 09.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runExample()
    }
    
    func runExample() {
        let circle = Circle(radius: 5)
        let triangle = Triangle(sideA: 5, sideB: 5, sideC: 5)
        
        print("Площадь круга: \(circle.area())")
        print("Площадь треугольника: \(triangle.area())")
        print("Прямоугольный треугольник: \(triangle.isRightAngled())")
    }
}

protocol Figure {
    func area() -> Double
}

// Круг
struct Circle: Figure {
    var radius: Double
    
    func area() -> Double {
        return Double.pi * radius * radius
    }
}

// Треугольник
struct Triangle: Figure {
    var sideA: Double
    var sideB: Double
    var sideC: Double
    
    func area() -> Double {
        let s = (sideA + sideB + sideC) / 2
        return sqrt(s * (s - sideA) * (s - sideB) * (s - sideC))
    }
    
    func isRightAngled() -> Bool {
        let sides = [sideA, sideB, sideC].sorted()
        return sides[0] * sides[0] + sides[1] * sides[1] == sides[2] * sides[2]
    }
}
 
