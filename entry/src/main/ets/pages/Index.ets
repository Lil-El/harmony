// @formatter:on
import { SymbolGlyphModifier } from '@kit.ArkUI';


@Entry
@Component
struct Index {
  // 路由页面栈
  private pageStack: NavPathStack = new NavPathStack();

  // 路由：菜单项
  private navigationMenuItems: Array<NavigationMenuItem> = [
    { value: "通知", symbolIcon: new SymbolGlyphModifier($r("sys.symbol.bell_fill")) },
    {
      value: "模式",
      symbolIcon: new SymbolGlyphModifier($r("sys.symbol.moon_fill")),
      // isEnabled: false,
      action: () => {
        this.getUIContext().getPromptAction().showToast({
          message: "暂不可用"
        })
      }
    }
  ];

  // 路由：工具栏
  private navigationToolBarItems: Array<ToolbarItem> = [
    { value: "首页" },
    { value: "广场" },
    { value: "我的" }
  ];

  @Builder
  navBuilder(name: string) {
    if (name === "PageA") {
      myNavDestination();
    }
  }

  // 状态
  @State message: string = "Hello World!";

  build() {
    Navigation(this.pageStack) {
      Button(this.message)
        .onClick(() => {
          this.pageStack.pushPath({ name: "PageA" })
        })
    }
    .title("Title")
    .menus(this.navigationMenuItems)
    .toolbarConfiguration(this.navigationToolBarItems)
    .hideToolBar(!true)
    .hideTitleBar(!true)
    .mode(NavigationMode.Split)
    .navBarWidth(375 / 2)
    .navBarPosition(NavBarPosition.Start)
    .navDestination(this.navBuilder)
    .height('100%')
    .width('100%')
    .backgroundColor("#eeeeee")
  }
}

@Component
struct myNavDestination {
  build() {
    NavDestination() {
      Text("myNavDestination")
    }
  }
}