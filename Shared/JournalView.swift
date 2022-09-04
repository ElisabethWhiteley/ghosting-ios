//
//  JournalView.swift
//  Ghosting
//
//  Created by Elisabeth Teigland Whiteley on 01/05/2022.
//

import SwiftUI
 
struct JournalView: View {
    @State private var page = 1
    
    private var pageTitle = ["Ghost hunting for dummies", "Equipment", "Locating ghosts", "Determining animosity level", "Methods of extraction"]
    private var pageContent = [
        "",
        "\n DIVINING RODS \n You can use divining rods to locate ghosts from quite a distance. They are however unreliable in buildings with multiple floors, as they work by sensing where the ghosts essence has sunk into the earth. Holding the rods in front of you horizontally, the rods will move in the direction of the nearest ghostly essenceba. When the rods point inwards in opposite directions (like an X), it means the spirit is at, underneath or above this point. \n \n  SPIRIT BOX \n A spirit box is used to communicate with ghosts. When in close proximity to the ghost, turn the spirit box on and try asking some questions. Most ghosts will answer when you talk directly to them, however, if a ghost talks through the spirit box without being prompted, it may indicate it is an agitated spirit.",
        "\n Ghosts may roam, but tend to be tethered to a small area, e.g. a specific room within a house. \n However, the more powerful ghosts may be able to move further.You can use several methods for determining the location of the ghost. \n Besides checking your ghost hunting equipment within each area for any kind of paranormal activity, divining rods are useful for trying to find the direction of the nearest ghost from long distances.",
        "\n A ghosts power is tied to its level of animosity/anger. \n It is important to determine how powerful the ghost is to get the ghost to move on without angering it further. Using too harsh a method on a ghost will make it more active and anger it, while being too careful is likely to provoke an attack.\n The more angry a ghost is, the more powerful it becomes, and the more it will be able to interact with its environment. Look for clues to how powerful the ghost is by using your equipment in the area where the ghost resides.",
        "\n 1. Ask the ghost to leave. Be nice, and not demanding. Tell them things such as ‘its time to go’, ‘you should move on, ‘its ok’, ‘go be at peace’. Be polite, use words such as please often. \n \n 2. Cleanse the area with sage. Be clear about your intentions by stating them as you go ‘I am cleansing this place. All negative spirits must leave’ be firm but don’t threaten. \n 3. Demand that the ghost leave. Use its relatives against it  (e.g for kids: ‘your mommy would be so dissappointed in you’, for men/women, threaten to bring their spouse to chastise them). Try to use a latin invocation: ‘Inquietum spiritum invocamus, vos relinquemus’. \n \n 4. Demonic exorcism: ‘Exorcizamus te, maligne spiritus, ad infernum ubi es’ \n Warning: will provoke the ghost. Stay safe"]
      
    var body: some View {
        GeometryReader { proxy in
        Image("background-journal").resizable()
               .ignoresSafeArea()
            .overlay(
                
                VStack(alignment: .center) {
                    Text(pageTitle[Int(page) - 1]).font(Font.custom("Mousedrawn", size: page == 1 ? 64 : 30)).padding(.bottom, 0.5).multilineTextAlignment(.center)
                    
                    if page != 1 {
                        ScrollView {
                            Text(pageContent[page - 1])
                                .multilineTextAlignment(.leading)
                                         
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
