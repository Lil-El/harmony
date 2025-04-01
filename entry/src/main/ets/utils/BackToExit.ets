import { common } from "@kit.AbilityKit";

export default class BackToExit {
  count: number = 0

  context: UIContext;

  constructor(context: UIContext) {
    this.context = context;
  }

  backPressed(): boolean {
    if (this.count === 0) {
      this.count++;
      this.context.getPromptAction().showToast({ message: "再按一次退出", alignment: Alignment.Top });
      setTimeout(() => {
        this.count = 0;
      }, 1000)
    } else {
      const ctx = this.context.getHostContext() as common.UIAbilityContext;
      ctx.terminateSelf();
    }

    return true;
  }
}