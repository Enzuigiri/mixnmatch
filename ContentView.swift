import SwiftUI


struct PatternTypePicker : View {
    @Binding var selected : Int
    var body : some View{
        
        HStack{
            Button(action: {
                self.selected = 0
            }) {
                Text("Completed")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background((selected == 0) ? Color("layer2") : Color("layer1"))
            .foregroundColor(.black)
            .cornerRadius(16)
            .padding(.vertical, 8)
            .padding(.leading, 8)
            .animation(.default)
            
            Button(action: {
                self.selected = 1
            }) {
                Text("Not Completed")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background((selected == 1) ? Color("layer2") : Color("layer1"))
            .foregroundColor(.black)
            .cornerRadius(16)
            .padding(.vertical, 8)
            .padding(.trailing, 8)
            .animation(.default)
            
        }
    }
}

struct ContentView: View {
    
    var cardLength: Int = 5
    @State var selected = 0
    
    @State private var type : Int = 0
    var outfitViewModel : OutfitViewModel = OutfitViewModel()
    @State var currentOutfitIndex : Int = OutfitViewModel.shared.outfits.count

    
    var body: some View {
        var _ = print("current", currentOutfitIndex)
        NavigationView(){
            GeometryReader{
                geometry in
                VStack(spacing : 0) {
                    HStack{
                        VStack(alignment: .leading){
                            Text("Pattern type")
                            PatternTypePicker(selected: $selected).frame(width: 440, height: 72)
                                .background(Color("layer1"))
                                .cornerRadius(16)
                        }
                        .padding(.leading, 64)
                        Spacer().frame(width: 32)
                        VStack(alignment: .leading){
                            Text("Pattern Group")
                            ScrollView(.horizontal){
                                HStack{
                                    ForEach(0..<4){
                                        _ in
                                        Rectangle()
                                            .frame(width: 270, height: 72)
                                            .cornerRadius(16)
                                            .foregroundColor(.gray)
                                            .opacity(0.3)
                                            .padding(.trailing, 8)
                                        
                                    }
                                }
                            }
                        }
                        
                    }.frame(height: 176)
                    
                    ScrollView(.horizontal){
                        HStack(spacing: 32){
                            NavigationLink(destination: StepOneView(
                                currentOutfitIndex: $currentOutfitIndex
                            )){
                                ZStack{
                                    Rectangle()
                                        .frame(width: 500)
                                        .cornerRadius(24)
                                        .foregroundColor(Color("layer1"))
                                    Circle()
                                        .frame(width: 350, height: 350)
                                        .foregroundColor(Color("layer2"))
                                    Text("+")
                                        .font(.system(size: 140))
                                        .fontWeight(.heavy)
                                    
                                }
                            }.padding(.trailing)
                            ForEach(0..<outfitViewModel.outfits.count){
                                index in
                                
                                    ZStack(alignment: .bottomLeading){
                                        Rectangle()
                                            .frame(width: 500)
                                            .cornerRadius(24)
                                            .foregroundColor(Color("layer1"))
                                        
                                            .padding(.vertical, 32)
                                        AvatarView(outfitModel: outfitViewModel.outfits[index])
                                            .padding(.vertical, 72)
                                        
                                        Rectangle()
                                            .frame(width: 150, height: 200)
                                            .cornerRadius(24)
                                            .foregroundColor(Color("layer2"))
                                            .padding(32)
                                            .offset(y: -32)
                                    }
                                    
                                
                            }
                        }.padding(.horizontal, 64)
                            .padding(.bottom, 32)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
