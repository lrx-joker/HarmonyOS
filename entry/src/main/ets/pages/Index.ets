import CustomAddDialog from '../component/CustomAddDialog'
import CustomEditDialog from '../component/CustomEditDialog'
import CustomSearch from '../component/CustomSearch'
import CustomTitle from '../component/CustomTitle'
import MemoItem from '../component/MemoItem'
import MemoTable from '../database/MemoTable'
import MemoModel from '../model/MemoModel'

@Entry
@Component
struct Index {

  // 缓存的原始数组
  originMemoList: MemoModel[] = []

  // 页面中展示的memo列表
  @State memoList: MemoModel[] = []

  // 是否展示新建memo自定义弹窗
  @State isAddDialogShow: boolean = false

  // 新建暂存标题
  @State addTitle: string = ''
  // 新建暂存内容
  @State addContent: string = ''

  // 是否展示编辑笔记自定义弹窗
  @State isEditDialogShow: boolean = false

  // 编辑弹窗标题输入的暂存内容
  @State editTitle: string = ''
  // 编辑弹窗文本输入的暂存内容
  @State editContent: string = ''

  // 当前编辑的memo索引
  editingMemoIndex: number = -1

  // 数据库初始化
  private MemoTable = new MemoTable(() => {})

  // 点击笔记时的方法
  clickMemo = (memo: MemoModel) => {
    for (let i = 0;i < this.originMemoList.length; i++) {
      if (this.originMemoList[i].id == memo.id){
        this.editingMemoIndex = i
        this.isEditDialogShow = true
        this.editTitle = memo.title
        this.editContent = memo.content
      }
    }
  }

  // 新增笔记的方法
  createMemo = () => {
    const date: Date = new Date()
    const newMemo: MemoModel = new MemoModel(0, date.getTime(), this.addTitle, this.addContent)
    this.MemoTable.insertData(newMemo, (id: number) => {
      newMemo.id = id
      this.originMemoList.push(newMemo)
      this.memoList = this.originMemoList
      this.refreshByOrder()
      this.closeDialog()
    })
  }

  // 删除笔记的方法
  deleteMemo = () => {
    if (this.editingMemoIndex !== -1) {
      this.MemoTable.deleteData(this.originMemoList[this.editingMemoIndex], () => {
        this.originMemoList.splice(this.editingMemoIndex, 1)
        this.memoList = this.originMemoList
        this.refreshByOrder()
        this.closeDialog()
      })
    }
  }

  // 修改笔记的方法
  saveMemo = () => {
    const date: Date = new Date()
    this.originMemoList[this.editingMemoIndex].updateTime = date.getTime()
    this.originMemoList[this.editingMemoIndex].title = this.editTitle
    this.originMemoList[this.editingMemoIndex].content = this.editContent
    this.MemoTable.updateData(this.originMemoList[this.editingMemoIndex], () => {
      this.memoList = this.originMemoList
      this.refreshByOrder()
      this.closeDialog()
    })
  }

  // 关闭弹窗的方法
  closeDialog = () => {
    this.isAddDialogShow = false
    this.addTitle = ''
    this.addContent = ''
    this.isEditDialogShow = false
    this.editTitle = ''
    this.editContent = ''
    this.editingMemoIndex = -1
  }

  // 页面初始化前向页面加载数据
  aboutToAppear() {
    this.originMemoList = []
    this.memoList = []
    this.order = false
    this.keywords = ''
    this.isAddDialogShow = false
    this.isEditDialogShow = false
    this.addTitle = ''
    this.addContent = ''
    this.editingMemoIndex = -1
    this.editTitle = ''
    this.editContent = ''

    this.MemoTable.getRdbStore(() => {
      this.MemoTable.query((result: MemoModel[]) => {
        this.originMemoList = result
        this.memoList = this.originMemoList
        this.refreshByOrder()
      })
    })
  }

  // 排序状态
  @State @Watch('refreshByOrder') order: boolean = true

  // 排序状态变化事件监听函数
  // 冒泡排序方法
  refreshByOrder() {
    let orderList: MemoModel[] = this.memoList
    const length = orderList.length
    for (let i = 0; i < length - 1; i++) {
      for (let j = 0; j < length - i - 1; j++) {
        const timeA = orderList[j].updateTime
        const timeB = orderList[j+1].updateTime

        if ((timeA > timeB && this.order) || (timeA < timeB && !this.order)) {
          const temp = orderList[j]
          orderList[j] = orderList[j+1]
          orderList[j+1] = temp
        }
      }
    }
    this.memoList = orderList
  }

  // 搜索关键词
  @State @Watch('onKeywordsChange') keywords: string = ''

  // 清空搜索关键词的方法
  cleanKeywords = () => {
    this.keywords = ''
  }

  // 监听搜索关键词的过滤方法
  onKeywordsChange() {
    if (this.keywords.length === 0) {
      this.memoList = this.originMemoList
      this.refreshByOrder()
    } else {
      let resultList: MemoModel[] = []

      for (const memoItem of this.originMemoList) {
        if (memoItem.content.includes(this.keywords) || memoItem.title.includes(this.keywords)) {
          resultList.push(memoItem)
        }
      }
      this.memoList = resultList
    }
  }

  build() {
    Stack() {
      // 背景图片
      Image($r('app.media.bg'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)
      // 主体页面
      Column() {
        // 标题栏
        CustomTitle({
          order: $order,
          isAddDialogShow: $isAddDialogShow
        })
        // 分割线
        Divider()
          .color('#604637')
        // 搜索框
        CustomSearch({ keywords: $keywords, cleanKeywords: this.cleanKeywords })
        // 笔记列表
        Scroll() {
          Column() {
            ForEach(
              this.memoList,
              (memo: MemoModel, index: number) => {
                // 笔记点击方法
                MemoItem({ memo: this.memoList[index], onMemoClick: this.clickMemo })
              },
              (memo: MemoModel) => {
                return memo.title,memo.content
              }
            )
          }
        }
      }
      .width('100%')
      .height('100%')
      // 新建弹窗新增笔记方法
      if (this.isAddDialogShow) {
        CustomAddDialog({
          addTitle: $addTitle,
          addContent: $addContent,
          onClose: this.closeDialog,
          onCreate: this.createMemo
        })
      }
      // 编辑弹窗
      if (this.isEditDialogShow) {
        CustomEditDialog({
          editTitle: $editTitle,
          editContent: $editContent,
          onClose: this.closeDialog,
          onDelete: this.deleteMemo,
          onSave: this.saveMemo
        })
      }

    }
    .width('100%')
    .height('100%')
  }
}