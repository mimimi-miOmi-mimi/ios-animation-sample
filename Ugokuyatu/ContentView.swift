import SwiftUI

struct ContentView: View {
    @State var isRedRectangleAnimation = false
    @State var isBlueRectangleAnimation = false
    @State var isGreenRectangleAnimation = false
    @State var isBlackRectangleAnimation = false
    @State var isGrayRectangleAnimation = false
    @State var isOrangeRectangleAnimation = false

    var body: some View {
        VStack(spacing: 10) {
            ScrollView {
                makeViews()
            }
            ScrollView(.horizontal) {
                makeButtons()
            }
        }
    }

    private func makeViews() -> some View {
        VStack(spacing: 10) {
            Group {
                if isRedRectangleAnimation {
                    makeTransitionView(background: .red, text: "上から出てくるやつ", from: .top)
                } else {
                    Spacer().frame(height: 100)
                }

                VStack(spacing: .zero) {
                    makeRectangle(background: .orange, text: "タップするとしたになんか出るやつ")
                        .onTapGesture {
                            withAnimation {
                                isOrangeRectangleAnimation.toggle()
                            }
                        }
                    VStack(spacing: 10) {
                        Text("なんか1")
                            .foregroundColor(.black)
                            .font(.system(size: 13))
                        Text("なんか2")
                            .foregroundColor(.black)
                            .font(.system(size: 13))
                        Text("なんか3")
                            .foregroundColor(.black)
                            .font(.system(size: 13))
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.95, height: isOrangeRectangleAnimation ? 100 : 0)
                    .background(.orange)
                    .cornerRadius(10)
                }

                if isGreenRectangleAnimation {
                    makeRectangle(background: .green, text: "じわじわうかびあがってくるやつ")
                } else {
                    Spacer().frame(height: 100)
                }

                if !isBlackRectangleAnimation {
                    makeRectangle(background: .black, text: "じわじわきえていくやつ")
                } else {
                    Spacer().frame(height: 100)
                }

                makeRotationView(background: .gray, text: "回転するやつ", isGrayRectangleAnimation)

                if isBlueRectangleAnimation {
                    makeTransitionView(background: .blue, text: "下から出てくるやつ", from: .bottom)
                } else {
                    Spacer().frame(height: 100)
                }
            }
        }
    }

    private func makeButtons() -> some View {
        HStack(spacing: 10) {
            Spacer()
            Group {
                makeButton("Red") {
                    withAnimation {
                        isRedRectangleAnimation = true
                    }
                }
                makeButton("green") {
                    withAnimation(.easeIn(duration: 5)) {
                        isGreenRectangleAnimation = true
                    }
                }
                makeButton("black") {
                    withAnimation(.easeOut(duration: 5)) {
                        isBlackRectangleAnimation = true
                    }
                }
                makeButton("gray") {
                    withAnimation {
                        isGrayRectangleAnimation = true
                    }
                }
                makeButton("blue") {
                    withAnimation {
                        isBlueRectangleAnimation = true
                    }
                }
            }
            Spacer()
        }
    }

    private func makeRectangle(background color: Color, text: String) -> some View {
        VStack {
            Spacer()
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 13))
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width * 0.95, height: 100)
        .background(color)
        .cornerRadius(10)
    }

    private func makeTransitionView(background color: Color, text: String, from edge: Edge) -> some View {
        makeRectangle(background: color, text: text)
            .transition(.move(edge: edge))
    }

    private func makeRotationView(background color: Color, text: String, _ flag: Bool) -> some View {
        makeRectangle(background: color, text: text)
            .rotationEffect(Angle.degrees(flag ? 180 : 0))
            .animation(.spring(), value: flag)
    }

    private func makeButton(_ text: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(.white)
        }
        .frame(width: 60, height: 50)
        .background(Color.brown)
        .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
