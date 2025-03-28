// @formatter:on
import { SymbolGlyphModifier } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

@Builder
export function HomeBuilder(name: string, param: Object) {
  Home();
}

@Component
struct Home {
  @StorageProp("statusBarHeight") statusBarHeight: number = 0;

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

  // 退出计次
  private backCount: number = 0;

  // 状态
  @State message: string = "Hello World!";

  aboutToAppear(): void {
    const ctx = this.getUIContext().getHostContext() as common.UIAbilityContext;
    const windowClass = ctx.windowStage.getMainWindowSync();

    const promiseArr: Promise<void>[] = [];

    if (canIUse("SystemCapability.Window.SessionManager")) {
      promiseArr.push(windowClass.setSpecificSystemBarEnabled("status", true));
      promiseArr.push(windowClass.setSpecificSystemBarEnabled("navigation", true));

      Promise.all(promiseArr).then(() => {
        windowClass.setWindowSystemBarProperties({
          statusBarColor: '#ffffff',
          statusBarContentColor: '#000000',
          navigationBarColor: '#00ff00',
          navigationBarContentColor: '#00ffff'
        })
      })
    }
  }

  handleBackPress(): boolean {
    if (this.backCount === 0) {
      this.backCount++;
      this.getUIContext().getPromptAction().showToast({ message: "再按一次退出", alignment: Alignment.Top });
      setTimeout(() => {
        this.backCount = 0;
      }, 1000)
    } else {
      const ctx = this.getUIContext().getHostContext() as common.UIAbilityContext;
      ctx.terminateSelf();
    }

    return true;
  }

  build() {
    NavDestination() {
      Button(this.message)
    }
    .title("Title")
    .menus(this.navigationMenuItems)
    .toolbarConfiguration(this.navigationToolBarItems)
    .hideToolBar(true)
    .hideTitleBar(false)
    .height('100%')
    .width('100%')
    .backgroundColor(0xffffff)
    .onBackPressed(() => this.handleBackPress())
    .safeAreaPadding({ top: px2vp(this.statusBarHeight) }) // 设置组件安全区域
  }
}