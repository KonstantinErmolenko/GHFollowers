//
//  GFError.swift
//  GHFollowers
//
//  Created by Ермоленко Константин on 02.06.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import Foundation

enum GFError: String {
    case invalidUsername  = "This user created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse  = "Invalid response from the server. Please try again."
    case invalidData      = "The data received from the server was invalid. Please try again."
}
