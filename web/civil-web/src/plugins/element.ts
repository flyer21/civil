import { ElButton } from 'element-plus'
import lang  from 'element-plus/lib/locale/lang/zh-cn'
import * as  locale   from 'element-plus/lib/locale'
import { App } from '@vue/runtime-core'
 

export default (app:App) => {
  locale.use(lang)
  app.use(ElButton)
}
