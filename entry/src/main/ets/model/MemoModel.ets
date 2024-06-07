@Observed
class MemoModel {
  id: number
  updateTime: number
  title: string
  content: string

  constructor(id: number, updateTime: number, title: string, content: string) {
    this.id = id
    this.updateTime = updateTime
    this.title = title
    this.content = content
  }
}

export default MemoModel