//
//  Main.swift
//  Shared
//
//  Created by Elisabeth Whiteley on 29/08/2020.
//

import SwiftUI


struct Main: View {
    
    // @Binding var showMenu: Bool
    @State private var searchText = ""
    @EnvironmentObject var data: Data
    @Binding var currentUserId: String

    
    var body: some View {
        Color.black
               .ignoresSafeArea()
            .overlay(
            
        HStack() {
            VStack(alignment: .center) {
                
                
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    
                    
                    NavigationLink(destination: Achievements()) {
                        HStack {
                            Image("icon-spirit-box")
                                .resizable()
                                .frame(width: 80.0, height: 80.0)
                        }
                        .frame(width: 84, height: 84)
                        .foregroundColor(Color.black).cornerRadius(12)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color("color-spiritbox-screen"), lineWidth: 4))
                    }.padding(.top, 50)
                }.padding(.top, -50)
                
                    Spacer()
            }
            .navigationBarTitleDisplayMode(.large)
        }
        )
    }
    
    func hasCurrentUser() -> Bool {
        if let user = data.users.first {
            if data.users.first(where: {$0.id == currentUserId }) == nil {
                currentUserId = user.id
            }
            return true
        }
        return false
    }
}

struct Main_Previews : View {
    @State
    private var userId = ""
    
    var body: some View {
        Main(currentUserId: $userId)
    }
}

#if DEBUG
struct Main2_Previews : PreviewProvider {
    static var previews: some View {
        Main_Previews()
    }
}
#endif
