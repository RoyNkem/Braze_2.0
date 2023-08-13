//
//  ExpandableText.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

struct ExpandableText: View {
    
    @State private var expanded: Bool = false
    @State private var truncated: Bool = false
    @State private var shrinkText: String
        
    private var text: String
    let font: UIFont
    let lineLimit: Int
    
    private var moreLessText: String {
        if !truncated {
            return ""
        } else {
            if lineLimit == 10 {
                return "show less"
            } else {
                return " ... show more"
            }
        }
    }
    
    init(_ text: String, lineLimit: Int, font: UIFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)) {
        
        self.text = text
        self.lineLimit = lineLimit
        _shrinkText =  State(wrappedValue: text)
        self.font = font
    }
    
    //MARK: body content
    var body: some View {
                
        ZStack(alignment: .bottomLeading) {
            Group {
                Text(self.expanded ? text : shrinkText) + Text(moreLessText)
                    .bold()
                    .foregroundColor(.blue)
            }
            .animation(.easeInOut, value: expanded)
            .lineLimit(expanded ? 10 : lineLimit)
            .background(
                // Render the limited text and measure its size
                Text(text)
                    .lineLimit(lineLimit)
                    .custom(font: .medium, size: 15)
                    .background(
                        GeometryReader { visibleTextGeometry in
                            Color.clear.onAppear() {
                                
                                let size = CGSize(width: visibleTextGeometry.size.width, height: .greatestFiniteMagnitude)
                                let attributes:[NSAttributedString.Key:Any] = [NSAttributedString.Key.font: font]
                                
                                ///Binary search until mid == low && mid == high
                                var low  = 0
                                var high = shrinkText.count
                                var mid = high ///start from top so that if text contain we does not need to loop
                            
                                while ((high - low) > 1) {
                                    
                                    let attributedText = NSAttributedString(string: shrinkText + moreLessText, attributes: attributes)
                                    let boundingRect = attributedText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
                                    
                                    if boundingRect.size.height > visibleTextGeometry.size.height {
                                        truncated = true
                                        high = mid
                                        mid = (high + low)/2
                                    } else {
                                        if mid == text.count {
                                            break
                                        } else {
                                            low = mid
                                            mid = (low + high)/2
                                        }
                                    }
                                    
                                    shrinkText = String(text.prefix(mid))
                                }
                                if truncated {
                                    shrinkText = String(shrinkText.prefix(shrinkText.count))
                                    //-2 extra as highlighted text is bold
                                }
                            }
                        })
                    .hidden() // Hide the background
            )

            if truncated {
                Button(action: {
                    expanded.toggle()
                }, label: {
                    HStack { //extend tapping area to last line, As it is not possible to get 'show more' location
                        Spacer()
                        Text("")
                    }
                    .opacity(0)
                })
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 10) {
            ExpandableText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut laborum", lineLimit: 6)
            ExpandableText("Small text", lineLimit: 3)
            ExpandableText("Render the limited text and measure its size, R", lineLimit: 1)
            ExpandableText("Create a ZStack with unbounded height to allow the inner Text as much, Render the limited text and measure its size, Hide the background Indicates whether the text has been truncated in its display.", lineLimit: 3)
            
            
        }.padding()
    }
}
