# RxSwift实现MVVM高仿喜马拉雅的函数响应式编程


### RxSwift 简介

[ReactiveX](http://reactivex.io/)（简写: Rx） 是一个可以帮助我们简化异步编程的框架。

它拓展了[观察者模式](https://zh.wikipedia.org/wiki/%E8%A7%82%E5%AF%9F%E8%80%85%E6%A8%A1%E5%BC%8F)。使你能够自由组合多个异步事件，而不需要去关心线程，同步，线程安全，并发数据以及I/O阻塞。

[RxSwift](https://github.com/ReactiveX/RxSwift) 是 [Rx](https://github.com/Reactive-Extensions/Rx.NET) 的 Swift 版本。

它尝试将原有的一些概念移植到 iOS/macOS 平台。

你可以在这里找到跨平台文档 [ReactiveX.io](http://reactivex.io/)。

<!-- more -->

### RxSwift 参考资料

- [RxSwift 中文文档](https://beeth0ven.github.io/RxSwift-Chinese-Documentation/)
- [RxSwift + ReactorKit 构建信息流框架](https://www.jianshu.com/p/dff7b0368d2b)
- [Flux 架构入门教程](http://www.ruanyifeng.com/blog/2016/01/flux.html)
- [RxSwift + MJRefresh 打造自动处理刷新控件状态](http://blog.csdn.net/lincsdnnet/article/details/78328428)
- [RxSwift 项目实战记录](http://blog.csdn.net/lincsdnnet/article/details/77896404)

### RxSwift 项目实战

#### 动画演示

![喜马拉雅演示动画](http://ovy8j7ypb.bkt.clouddn.com/1.25%E5%96%9C%E9%A9%AC%E6%8B%89%E9%9B%85%E6%BC%94%E7%A4%BA%E5%9B%BEgithub.gif)

#### 源码下载

[RxSwift实现MVVM高仿喜马拉雅的函数响应式编程](https://github.com/sessionCh/RxXMLY)

***注意事项***

- 1.源码下载后，执行 pod update --no-repo-update 更新第三方库；
- 2.项目运行中，如果数据获取失败，一般是链接失效，需要自己重新去抓取相关的链接；
- 3.项目仅供学习参考用，如有问题，欢迎指正；
- 4.项目所使用的图片资源均是从原 ***喜马拉雅 FM*** 中扣出来的，图片资源巨多，只保留了 ***@2*** 倍的图片，依然还有两千多张，所有导致项目源码的体积很大。 

#### 项目计划

目前只是花了些零散的时间做了些基础的功能，项目中事件响应机制和逻辑部分基本是采用 RxSwift 方式来进行的，UI 组件的创建方式基本采用协议方式创建和添加，这种模式值得大家在合适的场合借鉴和采用。

当前已完成以下部分：

- 1.【首页-推荐、精品】模块，其他模块可类比；该模块从数据抓取，数组处理和数据显示，均采用 MVVM 模式开发，对于学习 RxSwift 进行 MVVM 开发比较有借鉴作用；
- 2.【登录】模块，比较形象的展现了 ***函数响应式编程*** 在进行状态转化方面的优势
- 3.【我的、设置】模块，简易版 MVVM 模式开发，实现了比较典型的导航栏渐变和顶部图片下拉缩放的效果，如：QQ 空间，喜马拉雅 FM 我的页面的效果；
- 4.【播放页面】模块待完善。

未来计划从以下两个方面着手：

- 1.架构方面：目前重在学习 RxSwift 函数响应式编程，未来计划对项目架构进行进一步调整，构建成 RxSwift + ReactorKit 的信息流架构；
- 2.功能方面：后期将加入音视频播放的功能。

#### 效果截图

![高仿喜马拉雅截图1-1](http://upload-images.jianshu.io/upload_images/1126310-d4fa407856a53136.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![高仿喜马拉雅截图1-2](http://upload-images.jianshu.io/upload_images/1126310-34850bc3e862281c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![高仿喜马拉雅截图1-3](http://upload-images.jianshu.io/upload_images/1126310-9c5eec8b7519c9a0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![高仿喜马拉雅截图1-4](http://upload-images.jianshu.io/upload_images/1126310-7e4192dd98de6071.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


#### 项目结构

![喜马拉雅-目录结构](http://upload-images.jianshu.io/upload_images/1126310-c54e0e33682b4ccb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![喜马拉雅-第三方库](http://upload-images.jianshu.io/upload_images/1126310-9df8a179885aab1d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

