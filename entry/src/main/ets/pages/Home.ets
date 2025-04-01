// @formatter:on
import { SymbolGlyphModifier } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';
import BackToExit from '../utils/BackToExit';
import commonAttributeModifier, { titleAttributeModifier } from "ets/components/NavDestination/AttributeModifier"

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

  private commonAttrModifier: commonAttributeModifier = new commonAttributeModifier();

  @State private titleAttrModifier: titleAttributeModifier = new titleAttributeModifier("首页");

  // 退出
  private back2Exit: BackToExit = new BackToExit(this.getUIContext());

  // 状态
  @State message: string = "Change Title '主页'";

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

  build() {
    NavDestination() {
      Button(this.message).onClick(() => this.titleAttrModifier.title = "主页")
    }
    .attributeModifier(this.titleAttrModifier)
    .menus(this.navigationMenuItems)
    .toolbarConfiguration(this.navigationToolBarItems)
    .attributeModifier(this.commonAttrModifier)
    .onBackPressed(() => this.back2Exit.backPressed())
    .safeAreaPadding({ top: px2vp(this.statusBarHeight) }) // 设置组件安全区域
  }
}