//
//  NotesWhatWeKnow.swift
//  Ghosting (iOS)
//
//  Created by Elisabeth Teigland Whiteley on 16/10/2022.
//

import SwiftUI

struct NotesWhatWeKnow: View {
    @EnvironmentObject private var ghostSettings: GhostSettings
       @State private var selectedGhost = ""
    @State private var submitText = ""
    
    func updatePossibleGhostsList() {
        print("ghosts: ", ghostSettings.ghosts)
        
        let newPossibleGhosts = ghostSettings.ghosts.filter {
            (ghostSettings.isMale == nil || $0.isMale == ghostSettings.isMale) &&
           (ghostSettings.ghostOrbSize == nil || $0.ghostOrbSize == ghostSettings.ghostOrbSize) &&
            (ghostSettings.voice == nil || $0.voice == ghostSettings.voice) &&
            (ghostSettings.ageRange == nil || $0.ageRange == ghostSettings.ageRange) &&
            (ghostSettings.voice == nil || $0.voice == ghostSettings.voice) &&
            (ghostSettings.distortion == nil || $0.distortionLevel == ghostSettings.distortion)
            
        }
         
      
        print("new possible ghosts: ", newPossibleGhosts)
       ghostSettings.possibleGhosts = newPossibleGhosts
    }
    
    var body: some View {
                Text("What we know").font(Font.custom("Mousedrawn", size: 30))
                    Group {
                        Text("Sex: ").padding(.bottom, -10)
                        HStack {
                            Button(action: {
                                if (ghostSettings.isMale ?? false) {
                                    ghostSettings.isMale = nil
                                } else {
                                    ghostSettings.isMale = true
                                }
                                updatePossibleGhostsList()
                            }) {
                                Image(ghostSettings.isMale ?? false ? "icon-checkedbox" : "icon-checkbox")
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                    .foregroundColor(Color(red: 128/255, green: 128/255, blue: 128/255, opacity: 0.8))
                                Text("Male").padding(.leading, -12)
                            }
                            Button(action: {
                                if (ghostSettings.isMale == false) {
                                    ghostSettings.isMale = nil
                                } else {
                                    ghostSettings.isMale = false
                                }
                                updatePossibleGhostsList()
                            }) {
                                Image(ghostSettings.isMale ?? true ? "icon-checkbox" : "icon-checkedbox")
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                    .foregroundColor(Color(red: 128/255, green: 128/255, blue: 128/255, opacity: 0.8))
                                Text("Female").padding(.leading, -12)
                            }
                        }
                    }.font(Font.custom("Mousedrawn", size: 18))
                    Group {
                        Text("Ghost orb: ").padding(.bottom, -10).padding(.top, 15)
                        HStack {
                            Button(action: {
                                if (ghostSettings.ghostOrbSize == "Small") {
                                    ghostSettings.ghostOrbSize = nil
                                } else {
                                    ghostSettings.ghostOrbSize = "Small"
                                }
                                updatePossibleGhostsList()
                            }) {
                                Image(ghostSettings.ghostOrbSize == "Small" ? "icon-checkedbox" : "icon-checkbox")
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                    .foregroundColor(Color(red: 128/255, green: 128/255, blue: 128/255, opacity: 0.8))
                                Text("Small").padding(.leading, -12)
                            }
                            Button(action: {
                                if (ghostSettings.ghostOrbSize == "Medium") {
                                    ghostSettings.ghostOrbSize = nil
                                } else {
                                    ghostSettings.ghostOrbSize = "Medium"
                                }
                                updatePossibleGhostsList()
                            }) {
                                Image(ghostSettings.ghostOrbSize == "Medium" ? "icon-checkedbox" : "icon-checkbox")
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                    .foregroundColor(Color(red: 128/255, green: 128/255, blue: 128/255, opacity: 0.8))
                                Text("Medium").padding(.leading, -12)
                            }
                            
                        }
                        HStack {
                            Button(action: {
                                if (ghostSettings.ghostOrbSize == "Large") {
                                    ghostSettings.ghostOrbSize = nil
                                } else {
                                    ghostSettings.ghostOrbSize = "Large"
                                }
                                updatePossibleGhostsList()
                            }) {
                                Image(ghostSettings.ghostOrbSize == "Large" ?  "icon-checkedbox" : "icon-checkbox")
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                    .foregroundColor(Color(red: 128/255, green: 128/255, blue: 128/255, opacity: 0.8))
                                Text("Large").padding(.leading, -12)
                            }
                        }
                    }.font(Font.custom("Mousedrawn", size: 18))
                    
                    Group {
                        Text("Voice: ").padding(.bottom, -10).padding(.top, 15)
                        HStack {
                            Button(action: {
                                if (ghostSettings.voice == "Whisper") {
                                    ghostSettings.voice = nil
                                } else {
                                    ghostSettings.voice = "Whisper"
                                }
                                updatePossibleGhostsList()
                            }) {
                                Image(ghostSettings.voice == "Whisper" ? "icon-checkedbox" : "icon-checkbox")
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                    .foregroundColor(Color(red: 128/255, green: 128/255, blue: 128/255, opacity: 0.8))
                                Text("Whisper").padding(.leading, -12)
                            }
                            Button(action: {
                                if (ghostSettings.voice == "Normal") {
                                    ghostSettings.voice = nil
                                } else {
                                    ghostSettings.voice = "Normal"
                                }
                                updatePossibleGhostsList()
                            }) {
                                Image(ghostSettings.voice == "Normal" ? "icon-checkedbox" : "icon-checkbox")
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                    .foregroundColor(Color(red: 128/255, green: 128/255, blue: 128/255, opacity: 0.8))
                                Text("Normal").padding(.leading, -12)
                            }
                            
                        }
                        HStack {
                            Button(action: {
                                if (ghostSettings.voice == "Loud") {
                                    ghostSettings.voice = nil
                                } else {
                                    ghostSettings.voice = "Loud"
                                }
                                updatePossibleGhostsList()
                            }) {
                                Image(ghostSettings.voice == "Loud" ?  "icon-checkedbox" : "icon-checkbox")
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                    .foregroundColor(Color(red: 128/255, green: 128/255, blue: 128/255, opacity: 0.8))
                                Text("Loud").padding(.leading, -12)
                            }
                        }
                    }.font(Font.custom("Mousedrawn", size: 18))
                    
                    Group {
                        Text("Age range: ").padding(.bottom, -10).padding(.top, 15)
                        VStack(alignment: .leading, spacing: 0) {
                            Button(action: {
                                if ( ghostSettings.ageRange == "Child (<12)") {
                                    ghostSettings.ageRange = nil
                                } else {
                                    ghostSettings.ageRange = "Child (<12)"
                                }
                                updatePossibleGhostsList()
                            }) {
                                Image(ghostSettings.ageRange == "Child (<12)" ? "icon-checkedbox" : "icon-checkbox")
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                    .foregroundColor(Color(red: 128/255, green: 128/255, blue: 128/255, opacity: 0.8))
                                Text("Child (<12)").padding(.leading, -12)
                            }
                            Button(action: {
                                if ( ghostSettings.ageRange == "Young adult (12-24)") {
                                    ghostSettings.ageRange = nil
                                } else {
                                    ghostSettings.ageRange = "Young adult (12-24)"
                                }
                                updatePossibleGhostsList()
                            }) {
                                Image(ghostSettings.ageRange == "Young adult (12-24)" ? "icon-checkedbox" : "icon-checkbox")
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                    .foregroundColor(Color(red: 128/255, green: 128/255, blue: 128/255, opacity: 0.8))
                                Text("Young adult (12-24)").padding(.leading, -12)
                            }
                       
                            Button(action: {
                                if ( ghostSettings.ageRange == "Adult (25-59)") {
                                    ghostSettings.ageRange = nil
                                } else {
                                    ghostSettings.ageRange = "Adult (25-59)"
                                }
                                updatePossibleGhostsList()
                            }) {
                                Image(ghostSettings.ageRange == "Adult (25-59)" ?  "icon-checkedbox" : "icon-checkbox")
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                    .foregroundColor(Color(red: 128/255, green: 128/255, blue: 128/255, opacity: 0.8))
                                Text("Adult (25-59)").padding(.leading, -12)
                            }
                            Button(action: {
                                if ( ghostSettings.ageRange == "Senior (60+)") {
                                    ghostSettings.ageRange = nil
                                } else {
                                    ghostSettings.ageRange = "Senior (60+)"
                                }
                                updatePossibleGhostsList()
                               
                            }) {
                                Image(ghostSettings.ageRange == "Senior (60+)" ?  "icon-checkedbox" : "icon-checkbox")
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                    .foregroundColor(Color(red: 128/255, green: 128/255, blue: 128/255, opacity: 0.8))
                                Text("Senior (60+)").padding(.leading, -12)
                            }
                        }
                    }.font(Font.custom("Mousedrawn", size: 18))
                    
                    Group {
                        Text("Distortion level: ").padding(.bottom, -10).padding(.top, 15)
                        HStack {
                            Button(action: {
                                if ( ghostSettings.distortion ==  "None") {
                                    ghostSettings.distortion = nil
                                } else {
                                    ghostSettings.distortion =  "None"
                                }
                                updatePossibleGhostsList()
                            }) {
                                Image(ghostSettings.distortion == "None" ? "icon-checkedbox" : "icon-checkbox")
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                    .foregroundColor(Color(red: 128/255, green: 128/255, blue: 128/255, opacity: 0.8))
                                Text("None").padding(.leading, -12)
                            }
                            Button(action: {
                                if ( ghostSettings.distortion ==  "Low") {
                                    ghostSettings.distortion = nil
                                } else {
                                    ghostSettings.distortion =  "Low"
                                }
                                updatePossibleGhostsList()
                            }) {
                                Image(ghostSettings.distortion == "Low" ? "icon-checkedbox" : "icon-checkbox")
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                    .foregroundColor(Color(red: 128/255, green: 128/255, blue: 128/255, opacity: 0.8))
                                Text("Low").padding(.leading, -12)
                            }
                            Button(action: {
                                if ( ghostSettings.distortion ==  "High") {
                                    ghostSettings.distortion = nil
                                } else {
                                    ghostSettings.distortion =  "High"
                                }
                                updatePossibleGhostsList()
                            }) {
                                Image(ghostSettings.distortion == "High" ?  "icon-checkedbox" : "icon-checkbox")
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                    .foregroundColor(Color(red: 128/255, green: 128/255, blue: 128/255, opacity: 0.8))
                                Text("High").padding(.leading, -12)
                            }
                        }
                    }.font(Font.custom("Mousedrawn", size: 18)).padding(.bottom, 15)
        
        Menu {
            Picker(selection: $ghostSettings.chosenGhost) {
                ForEach(ghostSettings.possibleGhosts){
                    Text($0.name).tag($0)
                  }
            } label: {}
        } label: {
            HStack {
                Text((ghostSettings.chosenGhost == "" ? "Choose ghost..." :  ghostSettings.possibleGhosts.first(where: {$0.id == ghostSettings.chosenGhost})?.name) ?? "Choose ghost...")
                    .font(Font.custom("Mousedrawn", size: 20))
                Image("icon-arrow-down")
                    .resizable()
                    .frame(width: 25.0, height: 25.0)
                    .foregroundColor(.gray)
            }.padding(14)
           
        }.overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray, lineWidth: 3)
        ).padding(.bottom, 20)
        
        HStack {
            Spacer()
            Text(submitText)
            Spacer()
        }.padding(.bottom, 16).padding(.top, 12)
        HStack(alignment: .center) {
            Spacer()
            Button(action: {
                print("chosen ghost: ", ghostSettings.chosenGhost)
                let ghost = ghostSettings.ghosts.first(where: { $0.id == ghostSettings.chosenGhost })
                
                
                if ((ghost != nil) && ghost!.isHere) {
                    
                    print("We had no trouble burning the bones, great work!")
                    submitText = "We had no trouble burning the bones, great work!"
                } else {
                    submitText = "That was one seriously pissed off ghost here at the graveyard. Please check your evidence again and try not to get us killed next time."
                    
                    ghostSettings.ghosts = ghostSettings.ghosts.filter( {
                        $0.id != ghostSettings.chosenGhost
                    })
                }
            }) {
                Text("Submit").padding(14)  .font(Font.custom("Mousedrawn", size: 25))
            }.overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 3)
                )
            Spacer()
        }.padding(.bottom, 16)
       
       
      
                }
}

