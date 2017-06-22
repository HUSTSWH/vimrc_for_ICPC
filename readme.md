Vim配置：用VimScript实现一键编译运行及样例测试
---
#前言#
发现我的编译方式不合适，是在陕西邀请赛的现场上。彼时的我启用Vim写ICPC相关代码已经接近一年，对Vim主要快捷键已经趋于熟悉。Vim强大的功能使得我在代码编写和修改的时候得心应手，然而在编辑以外的部分，情况却不是那么的美好。Vim是一个编辑器，为了编译其中代码，我每次都需要在Vim中键入

    :!g++ % -Wall
    :!./a.out
随后是手动输入测试样例。然而这样的方法过于愚蠢，大量的时间浪费在了样例的输入上（为了避免交题的时候未去除文件重定向，我队往往采用手输的方式）而且每次测试，我都需要重复敲击上述两个命令，这在赛场紧张十分容易出错，非常危险。

恰好，我从宽神知乎号上得知“一键编译运行”的存在，这仿佛为我打开了新世纪的大门。我才终于知道，利用**make**和**VimScript**能完全自动化地完成编译运行任务，而对这些所付出的代价仅仅是数十行的.vimrc配置。更惊喜的是，vimrc的配置提供了一个安全、自动化的，对代码黑箱的样例测试与方便的利用print log的debug方式。我再也不用手动输入编译命令、手术样例而浪费宝贵的时间，也再也不必因为时间紧迫慌神而在上述过程出错了。
#目的#
本vimrc完全面向ACM-ICPC刷题及竞赛现场环境的场景。因此，我对该配置文件作出了如下要求：

 * 要简单，易读。赛场上需要花时间把配置文件从纸质文档上抄到电脑上，因此内容一定要在不牺牲逻辑性和可读性的情况下短！短！短！
 * 要灵活。按下F9，该编译编译，编译成功运行程序从文件读样例，编译失败要能方便debug，跑完样例要能既把输出显示在当前屏幕上又能继续改代码。把99.9%的时间放在想代码、写代码、读代码、改代码的工作上面去。
 * 要人性化。编译出来一堆错误，不能单靠肉眼慢慢定位，要能直接显示；编译前自动保存，避免新代码、老运行的情况出现；要能方便条件编译print调试，免得交题前疯狂删调试print代码。

#实现方法#
本vimrc具有以下特性：

 * 自动保存
 * 一键编译运行
 * make编译
 * 利用VimScript中的函数实现自动编译、运行
 * Vim的window工具：代码、输入、输出的分屏显示
 * 除此之外，还对代码书写提供了一定帮助，例如头文件模板的导入、少数常用扩写如pb:push_back、pi:pair<int, int> 等，这个不是本次的重点

编译内容用如下配置完成：

    :set makeprg=g++\ %\ -Wall\ -g\ -o\ %<\ -DSONG
加入到vimrc以后，单文件的编译就变成了：

    :make
我以前一直以为用make必须写makefile，因为觉得每个题写一遍makefile很浪费时间而作罢，想不到还有这种操作。

自动编译运行的函数列表如下：

    Run()
    CompileRun()

使用时只需输入

    :call CompileRun()
就可以完成编译运行了，当然我们可以更进一步，把这个命令映射到一个键位上，例如，我想每次按下F9就能调用这个函数，在vimrc中加入如下键位映射：

    map <F9> :call CompileRun()<CR>  "句末的<CR>表示Enter键
    imap <F9> <Esc>:call CompileRun()<CR> "插入模式中的键位映射

值得注意一点，CompileRun()中有个小技巧，那就是通过

    let v:statusmsg = ''
    silent make
    if empty(v:statusmsg)
        ...
来判断编译是否成功，这个只保证了在Terminal模式下有效，对于gVim到底是否可行是个未知数。

最后，来看看编译参数。编译命令相当于：

    g++ test.cpp -g -o test -Wall -DSONG  "test为当前文件名
-Wall使所有warning输出， -g保证编译器不对代码做任何优化，只有这样才能调用gdb进行调试， -DSONG给print调试提供了一个方式，可以在C\C++代码中键入

    #ifdef SONG
    //print somethint
    #endif
进行调试，这样既能在本机上看到调试信息，又能交题后不产生额外输出。END

### 参考文档： ###

1. [VimScript编译运行命令相关](http://blog.chinaunix.net/uid-21202106-id-2406761.html)
2. [详细版单文件编译运行命令配置（推荐）](https://www.oschina.net/code/snippet_574132_13351)
3. [Vim中quickfix使用](http://easwy.com/blog/archives/advanced-vim-skills-quickfix-mode/)

第二个是最重要的，对我的这个配置帮助很大。

2017/06/21
