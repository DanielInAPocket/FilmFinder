//
//  ToastModifier.swift
//  FilmFinder
//
//  Created by Daniel Klinge on 21/09/2024.
//

import SwiftUI
import SFSafeSymbols

struct ToastModifier: ViewModifier {

    @Binding var isPresenting: Bool
    @State var duration: Double
    @State var tapToDismiss: Bool
    @State private var offset: CGFloat = 0

    var toast: Toast?
    var onTap: (() -> Void)?

    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geometry in
                    ZStack(alignment: .top) {
                        if let toast, isPresenting {
                            ToastView(for: toast)
                                .padding([.leading, .trailing])
                                .offset(x: 0, y: geometry.safeAreaInsets.top + offset)
                                .transition(
                                    .move(edge: .top).combined(with: .opacity)
                                )
                                .onTapGesture {
                                    onTap?()
                                    if tapToDismiss {
                                        dismiss()
                                    }
                                }
                                .simultaneousGesture(
                                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                        .onChanged { gesture in
                                            let draggedOffset = gesture.translation.height
                                            if draggedOffset < 0 {
                                                self.offset = draggedOffset
                                            }
                                        }
                                        .onEnded { _ in
                                            if offset < -20 {
                                                dismiss()
                                            } else {
                                                offset = 0
                                            }
                                        }
                                )

                                .task {
                                    try? await Task.sleep(for: .seconds(duration))
                                    dismiss()
                                }
                        }

                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .ignoresSafeArea()
                }
            }
    }

    func dismiss() {
        withAnimation(.spring) {
            isPresenting = false
            offset = 0
        }
    }
}

public extension View {
    func toast(
        isPresenting: Binding<Bool>,
        duration: Double = 5.0,
        tapToDismiss: Bool = true,
        toast: Toast?,
        onTap: (() -> Void)? = nil,
        completion: (() -> Void)? = nil
    ) -> some View {
        modifier(ToastModifier(
            isPresenting: isPresenting,
            duration: duration,
            tapToDismiss: tapToDismiss,
            toast: toast,
            onTap: onTap
        ))
    }

}
