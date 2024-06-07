import hilog from '@ohos.hilog'

class Logger {
  // 域
  private domain: number
  // 日志前缀
  private prefix: string
  // 格式化
  private format: string = '%{public}s, %{public}s'

  constructor(prefix: string = 'myTag', domain: number = 0xFF00) {
    this.prefix = prefix
    this.domain = domain
  }

  // 输出 debug 日志方法
  debug(...args: string[]): void {
    hilog.debug(this.domain, this.prefix, this.format, args);
  }

  // 输出 info 日志方法
  info(...args: string[]): void {
    hilog.info(this.domain, this.prefix, this.format, args);
  }

  // 输出 warn 日志方法
  warn(...args: string[]): void {
    hilog.warn(this.domain, this.prefix, this.format, args);
  }

  // 输出 error 日志方法
  error(...args: string[]): void {
    hilog.error(this.domain, this.prefix, this.format, args);
  }
}

export default new Logger('myApp',0xFF00)