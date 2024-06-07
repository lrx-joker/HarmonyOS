import preferences from '@ohos.data.preferences'

export class PreferencesUtil{
  private LOG_TAG: string = '-----MyPreferences'
  preferencesMap: Map<String,preferences.Preferences> = new Map()

  //加载preferences
  async loadPreferences(context, password: string){
    try {
      let pref = await preferences.getPreferences(context, password)
      this.preferencesMap.set(password, pref)
      console.log(this.LOG_TAG, `加载preferences成功：${password}`)
    }catch (e){
      console.log(this.LOG_TAG, `加载preferences失败：${password}`, JSON.stringify((e)))
    }
  }

  //设置值
  async setData(password: string, key: string, value: preferences.ValueType){
    if (!this.preferencesMap.has(password)){
      console.log(this.LOG_TAG, `${password}还没初始化`)
      return
    }
    try{
      let pref = this.preferencesMap.get(password)
      //写入数据
      await pref.put(key, value)
      //写入数据后使用flush()方法保存刷新一下
      await pref.flush()
      console.log(this.LOG_TAG, '数据保存成功')
    }catch (e){
      console.log((this.LOG_TAG, '数据保存失败', JSON.stringify((e))))
    }
  }

  //获取值
  async getData(password: string, key: string, defaultValue: preferences.ValueType){
    if (!this.preferencesMap.has(password)) {
      console.log(this.LOG_TAG, `${password}还没有初始化`)
      return
    }
    try {
      let pref = this.preferencesMap.get(password)
      let prefValue = await pref.get(key, defaultValue)
      console.log(this.LOG_TAG, '获取数据成功', JSON.stringify(prefValue))
      return prefValue
    }catch (e){
      console.log(this.LOG_TAG, '获取数据成功', JSON.stringify((e)))
    }
  }
}

let preferencesUtil = new PreferencesUtil()
export default preferencesUtil as PreferencesUtil





