//
//  NotesView.swift
//  Ghosting
//
//  Created by Elisabeth Teigland Whiteley on 01/05/2022.
//

import SwiftUI

struct Ghost: Codable, Hashable, Identifiable {
    var id: String
    var name: String
    var age: Int
    var disposition: String
    var violentDeath: Bool
    var yearOfDeath: Int
    var isMale: Bool
    var isHere: Bool
    var description: String
    var voice: String
    var ghostOrbSize: String
    var distortionLevel: String
    var ageRange: String
    
    init(id: String, name: String, age: Int, disposition: String, violentDeath: Bool, yearOfDeath: Int, isMale: Bool, isHere: Bool, description: String, voice: String, ghostOrbSize: String, distortionLevel: String, ageRange: String) {
        self.id = id
        self.name = name
        self.age = age
        self.disposition = disposition
        self.violentDeath = violentDeath
        self.yearOfDeath = yearOfDeath
        self.isMale = isMale
        self.isHere = isHere
        self.description = description
        self.voice = voice
        self.ghostOrbSize = ghostOrbSize
        self.distortionLevel = distortionLevel
        self.ageRange = ageRange
    }
}

struct NotesView: View {
    @State private var page = 1
    @EnvironmentObject private var ghostSettings: GhostSettings
      
    var body: some View {
        Color.black
               .ignoresSafeArea()
            .overlay(
                VStack(alignment: .leading) {
                    if (page == 1) {
                        GeometryReader { geometry in
                            ScrollView {
                                VStack(alignment: .leading, spacing: 0) {
                                    NotesWhatWeKnow()
                                }.frame(minHeight: geometry.size.height).frame(maxWidth: .infinity)
                                
                            }
                        }
                    }
                    
                    else {
                        Text("Suspect #\(page-1)").font(Font.custom("Mousedrawn", size: 24)).padding(.bottom, 0.5)
                        Text("Name: " + ghostSettings.possibleGhosts[page - 2].name).lineSpacing(8)
                        Text("\n Year of death: " + String(ghostSettings.possibleGhosts[page - 2].yearOfDeath) + "\n Age: "  + String(ghostSettings.possibleGhosts[page - 2].age)).lineSpacing(8)
                        Text("\n " + ghostSettings.possibleGhosts[page - 2].description).lineSpacing(8)
                    }
                   
            Spacer()
                    Spacer()
                    HStack(alignment: .center) {
                        Spacer()
                        Spacer()
                    Button(action: {
                        if (page > 1) {
                            page = page - 1;
                        }
                    }) {
                        Image("previous-icon")
                            .resizable()
                            .frame(width: 50.0, height: 50.0)
                            .foregroundColor(page > 1 ? Color(red: 92/255, green: 98/255, blue: 116/255, opacity: 1.0) : Color(red: 92/255, green: 98/255, blue: 116/255, opacity: 0.3))
                    }
                        Spacer()
                        Button(action: {
                            if (page < ghostSettings.possibleGhosts.count + 1) {
                                page = page + 1;
                            }
                        }) {
                            Image("next-icon")
                                .resizable()
                                .frame(width: 50.0, height: 50.0)
                                .foregroundColor(page < ghostSettings.possibleGhosts.count+1 ? Color(red: 92/255, green: 98/255, blue: 116/255, opacity: 1.0) : Color(red: 92/255, green: 98/255, blue: 116/255, opacity: 0.3))
                        }
                        Spacer()
                        Spacer()
                    }.padding(.bottom, 12)
                }.font(Font.custom("Mousedrawn", size: 16)).padding(20).padding(.top, 24).foregroundColor(Color(red: 92/255, green: 98/255, blue: 116/255, opacity: 1.0))
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
        .background(Image("background-notes").resizable())
            )}
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}
