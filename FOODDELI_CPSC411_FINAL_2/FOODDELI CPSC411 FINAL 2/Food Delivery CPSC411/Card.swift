//
//  Card.swift
//  Food
//
//  Created by BqNqNNN on 7/13/20.
//

import Foundation


struct Card : Identifiable {
    var id : Int
    var image : String
    var title : String
    var descrip : String
    var stars : Int
    var price : Double
    var expand : Bool
}

var TrendingCard = [
    Card(id: 0, image: "maxresdefault1", title: "Crispy Chicken Sandwich", descrip: "Chik-Fil-A",stars: 5, price: 25.00, expand: false),
    Card(id: 1, image: "maxresdefault2", title: "Shrimp Fries", descrip: "Vox Kitchen",stars: 3, price: 30.00, expand: false),
    Card(id: 2, image: "maxresdefault3", title: "Chicken Bake", descrip: "Costco",stars: 4, price: 20.00, expand: false),
    Card(id: 3, image: "maxresdefault4", title: "Beef Pho", descrip: "Phoholic",stars: 5, price: 15.00, expand: false),
    Card(id: 4, image: "maxresdefault5", title: "Spicy Miso Ramen", descrip: "KIN Izakaya",stars: 3, price: 25.00, expand: false),
    Card(id: 5, image: "maxresdefault6", title: "Pineapple Pizza", descrip: "Pizza Hut",stars: 1, price: 50.00, expand: false),
]

var MenuCard = [
    Card(id: 6, image: "maxresdefault7", title: "Double-Double", descrip: "Bun, 2 Cheese, 2 Beef Patties",stars: 5, price: 5.00, expand: false),
    Card(id: 7, image: "maxresdefault8", title: "Cheeseburger", descrip: "Bun, 1 Cheese, 1 Beef Patty",stars: 3, price: 4.00, expand: false),
    Card(id: 8, image: "maxresdefault9", title: "Hamburger", descrip: "Bun, 1 Beef Patty",stars: 4, price: 3.00, expand: false),
    Card(id: 9, image: "maxresdefault10", title: "French Fries", descrip: "Fresh, Hand-Cut Potatoes",stars: 5, price: 3.00, expand: false),
    Card(id: 10, image: "maxresdefault11", title: "Soft Drinks", descrip: "Soda",stars: 3, price: 2.00, expand: false),
    Card(id: 11, image: "maxresdefault12", title: "Milkshakes", descrip: "Vanilla, Strawberry, Chocolate",stars: 4, price: 4.00, expand: false),
]

var FoodTypes = ["Pizza","Drinks","Tacos","Burger","Fries","Top"]
