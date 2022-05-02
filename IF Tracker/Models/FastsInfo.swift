//
//  FastsInfo.swift
//  IF Tracker
//
//  Created by Chuck Underwood on 4/2/22.
//

import Foundation

// Model to store the fasting length info
struct FastsInfo: Identifiable {
    
    let id = UUID()
    let name: String
    let summary: String
    let imageName: String // Not implemented
}

// Extension on the FastInfo model to return the name and summary of the fasts
// Potential to move to online storage to allow for remote updating
extension FastsInfo {
    static var data: [FastsInfo] {
        return [
            FastsInfo(name: "Circadian Rythm", summary: "Based on the research of scientist Dr. Satchin Panda, this time-restricted feeding fast emulates the body's natural clock by fasting roughly after sunset until morning.", imageName: ""),
            FastsInfo(name: "16:8", summary: "The most popular time-restrictd feeding fast, this is the protocol Jennifer Aninston and Hugh Jackman use to get in shape. With this approach, it's common to fast from after dinner to lunch the next day, but some prefer to skip dinner to reach their 16-hour goal.", imageName: ""),
            FastsInfo(name: "18:6", summary: "Slightly more restrictive that the popular 16:8 fast, the 18:6 time-restrictive feeding helps rid the liver of more glycogen, allows the body to begin using ketones for fuel, and can activate autophagy to rid the body of damaged cells.", imageName: ""),
            FastsInfo(name: "20:4", summary: "A challenging protocol for intermediate to advanced fasters, the 20:4 helps you work toward a One-Meal-A-Day regimen. With this fast, you're training your body to become 'fat adapted' so your body leaarns how to use multiple sources of fuel including glycogen, fat, and glucose.", imageName: ""),
            FastsInfo(name: "OMAD", summary: "One-Meal-A-Day) is particularly strict because you don’t eat for 23 hours, then consume all of your calories in a single meal. ", imageName: ""),
            FastsInfo(name: "Monk Fast", summary: "This challenging fast, known as a 36-hour fast, is regarded by many to promote powerful cellular cleaning benefits and help rest the metabolism. Some users like to start on a Sunday evening and break the fast Tuesday morning. Not recommended to do more than once per week.", imageName: ""),
            FastsInfo(name: "Alternate Day", summary: "Doing this fasting method you eat one day and completely fast the next day.", imageName: "")
        ]
    }
}

// Fasting information taken from https://www.zerofasting.com/blog
