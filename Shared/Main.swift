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
        HStack() {
            VStack(alignment: .center) {
                
                
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    
                    NavigationLink(destination: CashView(currentUserId: $currentUserId, amount: "")) {
                        HStack {
                            Image(systemName: "coloncurrencysign.circle")
                            Text("60").fontWeight(.bold).padding(.leading, -5)
                        }
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color.black)
                        .background(Color.green)
                        .clipShape(Circle())
                    }.padding(.top, 50)
                    
                    NavigationLink(destination: Users(currentUserId: $currentUserId)) {
                        VStack {
                            Image(systemName: "person.crop.circle.fill").foregroundColor(.green).font(.system(size: 80))
                            Text(data.users.first(where: {$0.id == currentUserId })?.name ?? "")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }.frame(maxWidth: 100)
                    
                    
                    NavigationLink(destination: Achievements()) {
                        HStack {
                            Image(systemName: "star.circle")
                            Text("950").fontWeight(.bold).padding(.leading, -5)
                        }
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color.black)
                        .background(Color.yellow)
                        .clipShape(Circle())
                    }.padding(.top, 50)
                }.padding(.top, -50)
                
                HStack {
                    Spacer()
                    NavigationLink(destination: AddFood(currentUserId: $currentUserId)) {
                        Text("I've tasted something new!")
                            .fontWeight(.bold)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 15)
                            .background(Color.orange)
                            .cornerRadius(40)
                            .foregroundColor(.black)
                        
                    }.padding(.vertical, 5)
                    Spacer()
                }
                
                SearchBar(text: $searchText)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                
                if hasCurrentUser() {
                    FoodList(searchText: searchText, currentUserId: $currentUserId)
                } else {
                    Spacer()
                }
                
                
            }
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image("icon-greeneggs")
                            .resizable()
                            .frame(width: 42.0, height: 42.0)
                        
                        Text("Green Eggs").font(.largeTitle)
                    }
                }
            }
            .navigationBarItems(trailing:
                                    NavigationLink(destination: Users(currentUserId: $currentUserId)) {
                                        
                                        Image(systemName: "line.horizontal.3")
                                            .foregroundColor(.green).font(.system(size: 36))
                                        
                                    }
            )
        }
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
