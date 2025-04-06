// 要約：
// このコードは、SwiftUIを使用した基本的なToDoアプリケーションのエントリーポイントを定義しています。
// アプリケーションの構造とメインのビュー（ContentView）を設定しています。

// SwiftUIフレームワークをインポート
import SwiftUI

// アプリケーションのエントリーポイントを定義する@mainアノテーション付きの構造体
@main
struct ToDoApp: App {
    // アプリケーションのUIシーンを定義するbodyプロパティ
    var body: some Scene {
        // WindowGroupを使用してアプリケーションのメインウィンドウを設定
        WindowGroup {
            // アプリケーションのメインビューとしてContentViewを指定
            ContentView()
        }
    }
}
