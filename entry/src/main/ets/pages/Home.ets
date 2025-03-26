// @formatter:on
import { SymbolGlyphModifier } from '@kit.ArkUI';

@Builder
export function HomeBuilder(name: string, param: Object) {
  Home();
}

@Component
struct Home {
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

  // 状态
  @State message: string = "Hello World!";

  build() {
    NavDestination() {
      Button(this.message)
    }
    .title("Title")
    .menus(this.navigationMenuItems)
    .toolbarConfiguration(this.navigationToolBarItems)
    .hideToolBar(true)
    .hideTitleBar(!true)
    .height('100%')
    .width('100%')
    .backgroundColor(0xffffff)
  }
}