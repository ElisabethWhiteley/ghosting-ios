//
//  Main.swift
//  Shared
//
//  Created by Elisabeth Whiteley on 29/08/2020.
//

import SwiftUI


struct Main: View {
    
    var body: some View {
        Color.black
               .ignoresSafeArea()
            .overlay(
            
        HStack() {
            VStack(alignment: .center) {
                
                Text("Phantasm").font(Font.custom("Raven Song", size: 64)).foregroundColor(Color.white).padding(.bottom, 24)
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    
                   Spacer()
                    NavigationLink(destination: SpiritBoxView()) {
                        HStack {
                            Image("icon-spirit-box")
                                .resizable()
                                .frame(width: 80.0, height: 80.0)
                                .cornerRadius(6)
                        }
                        .frame(width: 84, height: 84)
                    }.padding(.top, 50).padding(.leading, 10)
                    Spacer()
                    NavigationLink(destination: VideoCameraView()) {
                        HStack {
                            Image("icon-video-camera")
                                .resizable()
                                .frame(width: 60.0, height: 60.0)
                        }
                        .frame(width: 84, height: 84)
                        .foregroundColor(Color.black)
                        .background(Color.white)
                        .cornerRadius(6)
                    }.padding(.top, 50).padding(.trailing, 10)
                Spacer()
                }.padding(.top, -50)
                
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    Spacer()
                NavigationLink(destination: JournalView()) {
                    HStack {
                        Image("icon-journal")
                            .resizable()
                            .frame(width: 60.0, height: 60.0)
                    }
                    .frame(width: 84, height: 84)
                    .foregroundColor(Color.black)
                    .background(Color.white)
                    .cornerRadius(6)
                }.padding(.top, 50).padding(.leading, 10)
                Spacer()
                NavigationLink(destination: NotesView()) {
                    HStack {
                        Image("icon-notes")
                            .resizable()
                            .frame(width: 55.0, height: 65.0)
                    }
                    .frame(width: 84, height: 84)
                    .foregroundColor(Color.black)
                    .background(Color.white)
                    .cornerRadius(6)
                }.padding(.top, 50).padding(.leading, 10)
                Spacer()
                }
                
                HStack(alignment: .center) {
                    Spacer()
                    NavigationLink(destination: PeripheralScan()) {
                        HStack {
                            Image("icon-spirit-box")
                                .resizable()
                                .frame(width: 80.0, height: 80.0)
                        }
                        .frame(width: 84, height: 84)
                        .foregroundColor(Color.black).cornerRadius(12)
                        .cornerRadius(6)
                    }.padding(.top, 50)
                Spacer()
                NavigationLink(destination: DowsingRodView()) {
                    HStack {
                        Image("dowsing-rod")
                            .resizable()
                            .frame(width: 55.0, height: 65.0)
                    }
                    .frame(width: 84, height: 84)
                    .foregroundColor(Color.black)
                    .background(Color.white)
                    .cornerRadius(6)
                }.padding(.top, 50).padding(.leading, 10)
                Spacer()
                }
                
                
          
                    Spacer()
            }
            .navigationBarTitleDisplayMode(.large)
        }
        )
    }
}

struct Main_Previews : View {
    @State
    private var userId = ""
    
    var body: some View {
        Main()
    }
}

#if DEBUG
struct Main2_Previews : PreviewProvider {
    static var previews: some View {
        Main_Previews()
    }
}
#endif
