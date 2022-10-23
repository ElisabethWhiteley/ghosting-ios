//
//  JournalView.swift
//  Ghosting
//
//  Created by Elisabeth Teigland Whiteley on 01/05/2022.
//

import SwiftUI
 
struct JournalView: View {
    @State private var page = 1
    
    private var pageTitle = ["Ghost hunting for dummies", "Why hunt ghosts?", "Locating ghosts", "Gathering evidence"]
    private var pageContent = [
        "",
        "Some ghosts are unable to move on and be at peace, and will end up haunting the area where they died. These ghosts will have to be eliminated, which is done by burning their corpse. However, if you try burning the corpse of a ghost which is not haunting, it is more closely tied to its corpse and will attack you. Thats why we need to be sure which ghost is haunting a place before we go trying to burn corpses all willy nilly. Its your job to figure out which ghost we are dealing with, and we will burn the bones on your order. Use the notes we gave you to compare evidence against the bio of each potential ghost, but first you will have to find the exact place it is haunting.",
        "\n DIVINING RODS \n You can use divining rods to locate ghosts from quite a distance. They are however unreliable in buildings with multiple floors, as they work by sensing where the ghosts essence has sunk into the earth. Holding the rods in front of you horizontally, the rods will move in the direction of the nearest ghostly essence. When the rods point inwards in opposite directions (like an X), it means the spirit is at, underneath or above this point. \n \n  SPIRIT BOX \n A spirit box is used to communicate with ghosts to gain evidence as to their identity. However, it can also be useful for finding the ghost, as it will only questions when in close proximity.  \n \n  EMF METER \n An EMF meter may register some ghost activity when the ghost is nearby, however, it is a truly unreliable piece of equipment, as it will trigger from so many other electrical sources as well.",
        " \n SPIRIT BOX \n The spirit box is not only useful for finding the ghost, but also for determining the ghosts disposition. If it was an angry person, it will likely be very loud. If it was content in life it will be more likely to whisper. Additionally, you can hear if it is male or female, and in some cases if its very old or very young as well. \n \n VIDEO CAMERA \n The video camera is definitely your best bet at finding evidence. Once you know the ghosts location, look for ghost orbs through the camera. Although ghosts can show themselves in human form, the ghost orb is their essence. A large ghost orb indicates that the person has not been a ghost for very long, while a small one means it has been dead for well over a century at least. If you are lucky, the ghost will even appear to you in human form in the camera. This is a treasure trove of evidence as you can tell the ghosts sex, age range, and time period (by looking at the clothing). In addition, when the ghost appears there may be some distortion in the camera. More distortion indicates the ghost had a more violent death. \n "
       ]
      
    var body: some View {
        GeometryReader { proxy in
        Image("background-journal").resizable()
               .ignoresSafeArea()
            .overlay(
                ScrollViewReader { reader in
                    
                
                VStack(alignment: .center) {
                    Text(pageTitle[Int(page) - 1]).font(Font.custom("Mousedrawn", size: page == 1 ? 64 : 30)).padding(.bottom, 0.5).multilineTextAlignment(.center)
                    
                    if page != 1 {
                        
                        
                        ScrollView {
                            ScrollViewReader { value in
                                Text("").id(1)
                                Text(pageContent[page - 1])
                                    .multilineTextAlignment(.leading)
                                
                            }
                          
                              
                                         
                        }
                          }
                   
                    
                    
                   Spacer()
                    HStack(alignment: .bottom) {
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
                          
                            if (page < pageTitle.count) {
                                page = page + 1;
                            }
                        }) {
                            Image("next-icon")
                                .resizable()
                                .frame(width: 50.0, height: 50.0)
                                .foregroundColor(page < pageTitle.count ? Color(red: 92/255, green: 98/255, blue: 116/255, opacity: 1.0) : Color(red: 92/255, green: 98/255, blue: 116/255, opacity: 0.3))
                        }
                        Spacer()
                        Spacer()
                    }.padding(.bottom, 12)
                }.font(Font.custom("Mousedrawn", size: 20)).padding(12).padding(.top, 0).foregroundColor(Color(red: 92/255, green: 98/255, blue: 116/255, opacity: 1.0))
                .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .top
          )
                }
    )
        Spacer()
        }
       
    }
    
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}
