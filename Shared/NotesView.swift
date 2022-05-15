//
//  NotesView.swift
//  Ghosting
//
//  Created by Elisabeth Teigland Whiteley on 01/05/2022.
//

import SwiftUI
 
struct NotesView: View {
    @State private var page = 1
    
    
    private var suspectInfo = [
        "Name: Trevor Bartlet \n Year of death: 1974 \n Age: 47 \n - Was at a bar, stepped into road and got hit by a car. Dead instantly. Friends say drunk at time of death, left bar in good mood. \n - Wife (Gertrude) says nice, but quick to anger. Had issues with his boss. \n - Not religious says wife \n - 3 kids: Dorothy (10), Patty (15) and Michael (17).  \n Favorite things: baseball.",
        "Name: Betsy Woolward \n Year of death: 1956 \n Age: 32 \n - Stabbed to death by husband (Atticus) during dispute.  \n Domestic violence reports dating back to the beginning of their 13 year marriage.  \n - Friends say she was sweet, always helpful, never a bad word to say about anyone.  \n Favorite things: Blueberry muffins, tea, rabbits (to eat or as pets??).",
        "Name: Morgan Bell \n Year of death: 1905 \n Age: 5 \n - Cause of death: influenza, died alone during the night. \n Rich family, owns a lot of land. Mother says child was always content. Nanny says otherwise (bullied by older siblings). \n Favorite things: teddy, apples.",
        "Name: Dmitri Kalinski \n Year of death: 1989 \n Age: 19 \n - 5 GSW to the chest, shot at close range. Family say nothing except show pictures of him as a boy. \n Profession: Unemployed (russian mob?) \n  Favorite things: pocket knife, ex girlfriend Beatrice.",
        "Name: Maggie Lockley \n Year of death: 1924 \n Age: 7 \n - Cause of death: drowned? Unclear. \n Family had 6 children, 4 of whom died early in suspicious circumstances. \n Alcoholic mother?? \n Father owned apothecary, family lived in apartment above it.  \n Favorite things: blanket, family dog, sweets.",
        "Name: Ballie ?? \n Year of death: 1934 \n Age: 60s? \n - Cause of death: likely hypothermia. \n Homeless, often stayed outside the establishments on or near this street. Very little known. Perhaps former military? \n Favorite things: food, money, alcohol.",
        "Name: Calen Heckell \n Year of death: 1903 \n Age: 59 \n - Cause of death: tuberculosis. Sick for a long time. \n Profession: Professor of Medicine \n Left behind 2 kids (Mark, 23, and Mary, 15). Wife died in childbirth with Mary.  \n Favorite things: children, golf."]
      
    var body: some View {
        Color.black
               .ignoresSafeArea()
            .overlay(
                VStack(alignment: .leading) {
                    Text("Suspect #\(page)").font(Font.custom("Mousedrawn", size: 24)).padding(.bottom, 0.5)
                    Text(suspectInfo[page - 1]).lineSpacing(8)
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
                            if (page < suspectInfo.count) {
                                page = page + 1;
                            }
                        }) {
                            Image("next-icon")
                                .resizable()
                                .frame(width: 50.0, height: 50.0)
                                .foregroundColor(page < suspectInfo.count ? Color(red: 92/255, green: 98/255, blue: 116/255, opacity: 1.0) : Color(red: 92/255, green: 98/255, blue: 116/255, opacity: 0.3))
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
