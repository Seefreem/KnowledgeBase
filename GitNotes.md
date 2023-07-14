最重要的指令参数：-h 也就是获取帮助
如：
git -h
git add -h
git remote -h
--------------------基本概念----------------------
## 工作目录：
文件夹/文件目录，其中存放着我们能够直接编辑的文件。

## 暂存区(index(暂存区))：
临时存放我们的修改内容。

## HEAD：
是一个指针，指向最后一次的提交

## 注意：
用户名只会管理已经track的文件。通过"git add 文件"将文件添加到项目中，
对文件进行track。

## remote 远程仓库
git remote xxx 对远程仓库进行操作

## origin 一般指远程仓库，又叫远程主机名
一般涉及到远程分支操作时会使用这个参数

--------------------用户----------------------
git 查看用户名 
git config user.name

git 查看邮箱
git config user.email

修改用户名和邮箱
git config --global user.name "name"
git config --global user.email "2197036755@qq.com"

--------------------远程仓库----------------------
创建 SSH Key 进行免密登陆：
https://blog.csdn.net/weixin_42310154/article/details/118340458
https://www.jianshu.com/p/dd3be8cb5b90

创建远程仓库的方法：
1 在网页端用鼠标创建
2 命令行创建：
git init .
git add README.md
git commit -m "xxx"
# git remote 是对远程仓库的操作命令 git remote add [shortname] [url]
git remote add origin git@github.com:Seefreem/repoName.git
# 在github网站上创建repo，然后执行下面的命令
git push -u origin master

# 删除远程仓库
git remote rm name  
# 修改仓库名
git remote rename old_name new_name  

# 查看当前远程仓库名：
git remote -v
有时候添加远程仓库时填写错了仓库名，就导致无法推送代码。于是需要删除远程仓库链接，并重新添加：
git remote remove origin

git remote add origin git@github.com:Seefreem/xxx.git
git push -u origin master

# 提交本地仓库到远程仓库
S1 在github 上建立一个 repository
S2 follow the commands below：

## push an existing repository from the command line
git remote add origin git@github.com:Seefreem/reviewer.git # 设置本地rep的远程rep
git branch -M main  # 修改分支名为 main
git push -u origin main # 将本地代码提交到远程仓库

## …or create a new repository on the command line
echo "# reviewer" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:Seefreem/reviewer.git
git push -u origin main

## …or import code from another repository
You can initialize this repository with code from a Subversion, Mercurial, or TFS project.

----------------------基本操作流程--------------------
S1：创建仓库(repo)
S2：新增文件
S3：track文件
S4：提交修改
S5：更新到远程仓库

----------------------track文件--------------------
将文件添加到git中；对文件进行track；对文件进行管理：
# 添加多个文件
git add filename1 [filename2 ...] 

# 添加所有未track的文件；添加所有新增文件
git add * 

删除暂存区中的文件（从暂存区中删除的文件仍然存在于工作空间中）：
git reset filename [filename1 ...]

----------------------提交修改--------------------
修改包括对已经被track的文件的修改，还包括新增和删除文件。
修改文件所在目录的操作被分解为删除源文件，新增目录和新增目录下的新文件。
git commit -m "代码提交信息"
commit之后HEAD更新，提交的内容存放在HEAD指向的节点中。

----------------------放弃修改--------------------
如果不指定切换到哪个分支，那就是切换到当前分支，HEAD的指向没有变化。

# 1、只放弃工作区的改动，index(暂存区) 保持不变，
  其实就是从当前 index(暂存区) 恢复 工作区：
  =放弃工作区中全部的修改；删除工作区的全部修改；
git checkout .

# 放弃工作区中某个文件的修改；删除工作区中的某个文件的修改：
git checkout -- filename
# 先使用 git status 列出文件，然后 
git checkout -- app/Http/Controllers/Read/Read3Controller.php

2、强制放弃 index(暂存区) 和 工作区 的改动：
git checkout -f
这是不可逆的操作，会直接覆盖，但是还是很有用的。

----------------------分支--------------------
在你创建仓库的时候，master 是“默认的”分支。在其他分支上进行开发，
完成后再将它们合并到主分支上。

# 创建一个叫做“feature_x”的分支，并切换过去；创建新分支：
git checkout -b feature_x
# 切换回主分支；切换分支：
git checkout master
# 再把新建的分支删掉；删除分支；删除本地分支：
git branch -d feature_x
# 删除远程分支：
git push origin -d feature_x
# 除非你将分支推送到远端仓库，不然该分支就是 不为他人所见的：
git push origin <branch>


# 合并分支：
S1 切换到分支A
S2 将分支B的代码合并到分支A上，合并之后分支B的代码不变：
git checkout branchA
git merge branchB

在合并改动之前，你可以使用如下命令预览差异：
git diff <source_branch> <target_branch>

# 终止合并；取消合并：
git merge --abort

换掉本地改动：
git checkout -- <filename>
此命令会使用 HEAD 中的最新内容替换掉你的工作目录中的文件。
已添加到暂存区的改动以及新文件都不会受到影响。

----------------------获取远程仓库的更新--------------------
拉取远程仓库的更新后的代码：
git pull
以在你的工作目录中 获取（fetch） 并 合并（merge） 远端的改动。
也就是说git pull 实现了git fetch和git merge两个操作。

如果你在一个分支上执行下面的命令：
git pull origin test3
则git会拉取远程的test3分支，并且将test3分支和当前的本地分支进行合并。

如果你只是想要更新本地的这个分支， 那么使用git pull就行。

假如你想丢弃你在本地的所有改动与提交，可以到服务器上获取最新的版本历史，
并将你本地主分支指向它：（注意，本地的所有历史都将丢失，慎用）
git fetch origin
git reset --hard origin/master

获取远程仓库的所有更新：
git fetch --all
此操作能够获取到远程仓库中新的分支。

----------------------解决冲突--------------------
手动修改冲突的代码之后，文件属于修改状态。需要手动添加进暂存区(index(暂存区))：
git add modifiedFileName

----------------------标签--------------------
为软件发布创建标签是推荐的。这个概念早已存在，在 SVN 中也有。
你可以执行如下命令创建一个叫做 1.0.0 的标签：
git tag 1.0.0 1b2e1d63ff
1b2e1d63ff 是你想要标记的提交 ID 的前 10 位字符。
可以使用下列命令获取提交 ID：
git log
你也可以使用少一点的提交 ID 前几位，只要它的指向具有唯一性。

----------------------可视化工具--------------------
内建的图形化 git：gitk
彩色的 git 输出：
git config color.ui true

----------------------stash操作--------------------
stash能将工作空间和暂存区的内容统一保存起来/隐藏起来，
使得工作空间和暂存区都是干净的。方便其他操纵。
然后再将保存的/隐藏的内容显示出来。

# 保存/隐藏修改：
git stash
这里会执行两个操作：
git add -u 和 隐藏
换句话说就是，没有track的文件将不会受到影响。

# 恢复/弹出修改：
git stash pop [index]
git stash apply [index]   
index 默认是0，也就是栈顶的元素。

# 查看隐藏栈中的元素：
git stash list

# 丢掉某个已保存的版本：
git stash drop [index]
index默认为0

# 查看某个已保存的版本的基本信息：
git stash show [index]
index默认为0

# 清空保存区/隐藏区内容：   
git stash clear

----------------------提交历史/log--------------------
  查看提交历史：
  git log [-number]
  number 是指查看最近的几个提交
  

# trouble shooting
+++“WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!”
据说是对方IP发生变化。
S1：删除~/.ssh/known_hosts 文件中对应的主机IP，如果不知道是哪一个，那就直接将文件删掉。
S2：直接使用git clone等命令，重新登录一下命令行git就可以了。
但是可能还会出现下面的问题：
+++“The authenticity of host 'github.com (::1)' can't be established.
    ECDSA key fingerprint is SHA256:bKJKwVyMY6vBxRWrwHipu94x3i9jSCgiU9Aq1Lqyfts.
    Are you sure you want to continue connecting (yes/no/[fingerprint])?”
并且就算你输入正确的github密码也会出错。
参考下面的链接操作：
https://blog.csdn.net/weixin_47266712/article/details/124760778

操作之后，运行 ssh -T git@github.com
还是出现问题，但是注意到末尾有一个提示：
  Offending ECDSA key in /home/seelur/.ssh/known_hosts:1
    remove with:
    ssh-keygen -f "/home/seelur/.ssh/known_hosts" -R "github.com"
  ECDSA host key for github.com has changed and you have requested strict checking.
  Host key verification failed.
于是执行：
  ssh-keygen -f "/home/seelur/.ssh/known_hosts" -R "github.com"
  ssh -T git@github.com，输入yes，链接成功！

===================
问题描述：
执行 git push 时，报错：
fatal: unable to access 'https://github.com/Seefreem/KnowledgeBase.git/': Failed to connect to github.com port 443 after 21067 ms: Couldn't connect to server

解决办法：
 git remote add origin git@github.com:Seefreem/KnowledgeBase.git
然后 
 git push 



# 嵌套git
嵌套git的情况下，上层git可能无法管理子目录下的git仓库中的文件。
要管理子目录下的文件，就需要删除子目录下的.git，并且通过下面的命令更新上层git的缓存。
git rm -rf --cached 子目录名

--------------------gitlab----------------------------
# transfer project
转移项目之后，实际上是重定位到新的项目。
此时，使用原来项目的人，如果他上传了一个他本地有，但是远程仓库没有的分分支，
那么在远程仓库中就没办法访问他上传的分支。

在上传分支的时候本地可能会给出下面的提示：

remote: To create a merge request for feat/n_show, visit:
remote:   http://10.10.10.100/decision_and_planning/jiu_zhi/-/merge_requests/new?merge_request%5Bsource_branch%5D=feat%2Fn_show
remote: 
remote: 
remote: Project 'jiuzhi_project/jiu_zhi' was moved to 'decision_and_planning/jiu_zhi'.
remote: 
remote: Please update your Git remote:
remote: 
remote:   git remote set-url origin git@10.10.10.100:decision_and_planning/jiu_zhi.git
remote: 
remote: 
To 10.10.10.100:jiuzhi_project/jiu_zhi.git
   ea1b114..260a641  feat/n_show -> feat/n_show

这时候按照提示，我们运行：
  git remote set-url origin git@10.10.10.100:decision_and_planning/jiu_zhi.git
然后再将本地有，远程没有的分支，推送到远程仓库之后，别人应该就能访问了。

另一种解决办法就是，先拉取远程分支，将本地的URL映射为新的URL。
但最好还是直接更新本地的URL，使用上面的提示中的命令。

# git覆写上一次的提交
git 覆盖上一次的提交
  git commit --amend -m "an updated commit message"


# 思考

为什么要进行版本控制？
得先回答什么是版本控制。
因为我们想要记录软件的开发历史。之所以这样做，有很多的原因。
其中一个很重要的原因是，多人协调并行开发。因为追踪了历史，所以每个人修改的代码都被标记起来了，这样当我们修改了别人的代码的时候就能得到提示。从而可以找到对方确认是否可以修改。也就是我们常说的合并冲突和解决冲突。

另一个原因是，版本回退，在开发的过程中往往会遇到这样的问题，那就是，某个功能在之前的代码中运行良好，但是在最新的代码中却有问题。
因从处于调试或者使用的目的，我们需要找到之前可运行的代码。这就需要我们在之前有保存代码。也就是要求我们之前有做版本控制。

以上两个主要原因都是对内的，当然不仅仅是这两个原因。
对外，版本控制提供了一个交流的对象。我们可以将开发之外的人统一看成用户。当我们给用户提供可使用的程序时，如果我们直接在用户的设备上修改代码，或者每天更新几次代码，会给用户带来使用上的不便。用户反馈问题时，问题也不能对应一份固定的代码，导致调试困难。因为很可能双方在讨论问题的时候，说的甚至不是同一份代码。

此外，对外发布的版本还有助于项目管理，项目管理最关心的开发问题就是，实现了哪些功能，还有哪些问题。项目管理不可能每天每时每刻都派人跟进开发的进度。所以，每个发布版本的功能和问题就成了项目管理的重要参考。

还有一个原因是问题收敛，通过版本管理，并且定期发布版本，我们能够统计每个版本的问题数量，从而分析在开发和维护的过程中，问题数量是否在减少，如果不减反增，那么就应该考虑是否出现了重大的问题。

进行版本控制的原因也不能脱离版本管理工具来谈。版本管理工具本就是版本管理的一部分。比如git，有了git，那么我们的代码就变得可追溯，可恢复，可同步，可备份。git是多人协同开发的一个非常有帮助的工具。使用git本身也是进行版本管理的原因之一。

总之，版本控制涉及到并行开发、bug控制、项目管理、链接用户等方面的优点。

## 在版本控制的过程中应该注意什么呢？
首先需要注意的是大家都遵守一个统一的框架，无论是代码框架还是文件组织方法。这样才能保证大家写的代码并不是随意杂乱地组合到一起，而是遵循同一个标准。

另外就是代码风格得一致，这样代码的可读性就更高。代码的维护和转接的时间成本就更低。

最后就是代码审核，代码审核应该严肃对待，审核内容包括：文件组织、代码风格、基本逻辑、变量维护、容器维护、指针维护等。至于算法细节、代码的详细逻辑可以通过测试结果来审核，而不是完全深入到每一个细节。因为那样既痛苦又低效。



# 如何查看针对一个 git 仓库的 clone 和 pull 操作历史?
https://www.jianshu.com/p/7e4cef3863e7 

查看项目的git-reflog, 但是要注意记录是有时间限制的(默认只保留90天).
所有引起HEAD指针变动的操作，都会被记录在git reflog命令中。
我们可知，引起HEAD指针变化的操作有：
```shell
  git checkout branchName：切换分支 。
  git commit：提交。
  git reset commit：重置。
  git checkout commit：签出某一个提交。
  git merge：合并操作。
  git rebase：基变。
  git pull：相当于 fetch + merge 。
  git pull : Fast-forward：没有冲突，快速前进。
  git pull --rebase：相当于fetch + rebase。
  git clone：初始化ref 。
```
```shell
# 在项目根目录下输入下列命令
git reflog --date=iso|grep pull
```
但是上述命令仅仅是查看本地仓库的改动，而看不到远程仓库的。
比如刚进行了clone操作，那么 "git reflog --date=iso"的输出是：
```shell
f38e86b (HEAD -> main, origin/main, origin/HEAD) HEAD@{2023-07-05 09:27:58 +0800}: clone: from git@10.10.10.100:decision_and_planning/kuangka_decision_code.git
```
输出中有标注操作是 "clone"。

进行了一次checkout之后的结果如下：
```shell
b0c0312 (HEAD -> feat/adjust_to_breton, origin/feat/adjust_to_breton) HEAD@{2023-07-05 09:29:49 +0800}: checkout: moving from main to feat/adjust_to_breton
f38e86b (origin/main, origin/HEAD, main) HEAD@{2023-07-05 09:27:58 +0800}: clone: from git@10.10.10.100:decision_and_planning/kuangka_decision_code.git
```

那么如何看远程分支的记录呢？
似乎没办法看。



