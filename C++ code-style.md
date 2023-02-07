# WICRI C++ 代码风格指南

---

## 引言

### 目的

本文件参考Google开源项目风格指南与湖南大学无锡智能控制研究院（研究院）现有项目代码风格，全称定为“WICRI C++ 代码风格指南（风格指南/指南）”，针对研究院内部C++代码风格提出了部分具体的撰写要求与建议，旨在增强团队协作水平，降低团队成员在协作过程中在代码可读性、易维护性等方面产生的成本。

### 应用范围和场景

本指南暂时仅供规控技术室内部C++编程人员使用。本指南多数条目均为硬性规定，是开发人员必须遵守的规定，此外还存在一些建议规定，会在相关条目附近给出 `[建议]`标识。

---

## 编写规范

### 头文件

#### 头文件保护

使用 `#ifndef` `#define` `#endif`进行头文件保护，而不使用微软的 `#pragma once`。为了保证唯一性，头文件保护的命名需要基于项目代码路径 `[建议]`，比如 `wicri/cpp/coding/wicri_code_style_guide.h`，则文件的保护应该像这样：

```cpp
#ifndef WICRI_CPP_CODING_WICRI_CODE_STYLE_GUIDE_H
#define WICRI_CPP_CODING_WICRI_CODE_STYLE_GUIDE_H

#endif // WICRI_CPP_CODING_WICRI_CODE_STYLE_GUIDE_H
```

一般情况下，给出统一风格的、能够正确进行头文件保护的名称即可：

```cpp
#ifndef STYLE_GUIDE_H
#define STYLE_GUIDE_H

#endif // STYLE_GUIDE_H
```

> **Attention:**
> 注意文件结尾的 `#endif`处必须给出行内注释，注释内容与当前头文件保护的宏名称相同。

#### 头文件自足

包含自身头文件的`.cpp`文件不需要包含其他头文件就可以独立编译成功，若需要引入其他头文件，应当在头文件当中包含。

#### 头文件依赖

对于需要在头文件里使用其他文件中定义的类时，如果**只需使用类的声明**而不是具体定义，应该使用前置声明代替包含整个文件，如下：

```cpp
/* 仅需使用类声明时，不建议引用包含整个文件 */
#include "someClass.h" // 不建议

/* 而是建议使用前置声明代替 */
class SomeClass;
class OtherClass {
  private:
    SomeClass* someobj;
};
```

> **Attention:**
> 前置声明的使用隐藏了直观的依赖关系，可能会被后续库的改动破坏。请尽量避免前置声明那些定义**在其他项目中的实体**，并严禁为实现前置声明而重构代码。

#### 头文件包含顺序

顺序如下：C库、C++库、其他库.h、项目内的.h，如果此文件是cpp文件，那么要首先包含其对应的头文件，然后再按前述顺序。每个层级用空行分隔，同一层级的文件顺序按英文字母先后顺序排列。例如：

```cpp
/* 如果该文件是cpp文件，首先包含自己的头文件 */
#include "wicri_code_style_guide.h"

/* C库 */
#include <stdio.h>

/* C++库 */
#include <iostream>
#include <map>

/* 其他库 */
#include "lib/Beta.h"

/* 项目内 */
#include "someClass.h"
```

> **Suggestion:**
> 通常按照clang-format格式化自动排序即可。

### 作用域

#### 命名空间

命名空间内不使用缩进，与头文件保护类似，需在命名空间结束注释出命名空间的名字。例如：

```cpp
namespace wicri {
bool some_func() {
    return true;
}
} // namespace wicri
```

> **Attention:**
> 命名空间将全局作用域细分为独立、具名的作用域, 可有效防止全局作用域的命名冲突。但命名空间具有迷惑性，内联命名空间更是如此。命名空间下的实体被引用时会导致代码冗长。故应当尽量少的使用命名空间来解决问题，在使用时给命名空间一个直观的名字。

#### 全局变量

使用单例模式替代和管理全局变量：

```cpp
/*使用单例模式替代extern全局变量*/
class Singleton {
  private:
    /*members here*/

  private:
    Singleton(/*args*/){
        /*implemetations*/
    };
    Singleton(const Singleton&);
    Singleton& operator=(const Singleton&);

  public:
    static Singleton& getInstance() {
        static Singleton instance;
        return instance;
    }
};
```

> **Attention:**
> 根据经验，全局变量往往仅是作为一个常量或静态变量提供或保存信息，这种方式破坏了封装性，并且使得代码维护困难。若一定要用全局变量，请考虑使用单例模式。

#### 静态变量

不要使用静态变量`[建议]`。当有精彩实现时，也要遵守不要使用调用次数超过两次或调用所在行距离较远的静态变量。

> **Attention:**
> 静态变量同时使代码违反了面向对象编程的封装与函数式编程中函数的独立性和引用透明性（即对于同样的输入，必须返回同样的输出），一般可以通过传参、返回、类成员变量等不破坏封装性的方式替换。

### 类

#### 声明顺序

类中的各类定义遵循以下顺序：

1. typedef
1. enum
1. 常量
1. 成员变量
1. 构造和析构函数
1. 成员函数

其中每一项都要以public、protected、private的顺序进行排列。

> **Attention:**
> 一般而言，typedef、enum和常量会在类内外被反复调用，public的成员或函数是供外部使用的接口，成员变量（不论public还是private）能让外部知晓类包含哪些属性，这些要在上方首先声明，方便类外调用者快速对类的整体结构进行了解。

#### 构造函数

定义较为复杂的类时，构造函数应当只包含简单的初始化功能。在构造函数能够保证实例不是半构造对象的前提下，使用`Init()`函数进行有意义的初始化。`[建议]`

```cpp
/* 有意义的构造函数使用Init()函数初始化 */
class AClass {
  private:
    AClass(){
        /* members assignments here */
    };

  public:
    auto Init(/* args */) -> void /* or other returnType */ {
        /* statements and assignments */
        /* maybe you can return something */
    }
};
```

#### 拷贝构造函数

仅需要拷贝一个对象时才定义拷贝构造函数，否则（例如上节中的单例模式）可以预先定义的宏声明`DISALLOW_COPY_AND_ASSIGN`并在private域中调用宏，避免编译器隐式声明的拷贝构造函数导致的不确定行为。如下：

```cpp
/* 拷贝构造函数不必要时可将其DISALLOW */
#define DISALLOW_COPY_AND_ASSIGN(ClassName) \
    ClassName(const ClassName&);            \
    ClassName& operator=(const ClassName&)

/* 单例模式中可以使用此宏 */
class Singleton {
  private:
    /* members here */

  private:
    DISALLOW_COPY_AND_ASSIGN(Singleton); /* 代替了原来的两行，更直观 */
    Singleton(/* args */){
        /* implemetations */
    };

  public:
    static Singleton& getInstance() {
        static Singleton instance;
        return instance;
    }
};
```

#### 结构体

1. 结构体起别名时，使用`using`而不是`typedef`。
1. 禁止使用匿名结构体，将结构体真名设置为下划线+别名。
1. 仅当定义复合数据、具备简单函数和运算符重载时使用结构体，其他一律使用class。

```cpp
/* 为结构体起别名使用using */
using SimpleXY = struct _SimpleXY {
    int x, y;
};

using XY = struct _XY {
    int   x, y, z, a, b, c;
    float r, s, t, u, v, w;

    /* 重载简单函数 */
    auto Simple() -> _SimpleXY {
        SimpleXY xy = {x, y};
        return xy;
    }
    /* 重载运算符 */
    auto operator==(const _XY& xy) -> bool {
        return x = xy.x and y == xy.y and z == xy.z;
    }
};
```

> **Attention:**
> 在C++中，结构体除了一般需要起别名来避免实例化时要先声明`struct`关键字之外，与`class`几乎没有区别。而对于C++编程者而言，结构体和类给人的印象不同。前者通常代表对一个复合数据结构的定义，而后者通常代表了对一个复杂系统的定义。为避免含义混乱，上文的第3条将结构体的使用限制在对复合数据结构的定义和简单使用中。

#### 继承

1. 仅当`B`一定**是**一个`A`的时候，`B`才能继承自`A`：
    - 所有继承必须是public`[建议]`。
    - 若使用private继承，应当使用组合代替继承`[建议]`。
1. 对于重载的虚函数或虚析构函数, 使用override关键字进行标记。
1. 如果类中有一个virtual函数，则析构函数必须声明为virtual。

> **Attention:**
> 实现继承通过原封不动的复用基类代码减少了代码量，这是继承的优势。然而，通常情况下由于子类的实现代码散布在父类和子类间之间，要理解其实现变得更加困难。子类不能重写父类的非虚函数，当然也就不能修改其实现。基类也可能定义了一些数据成员，因此还必须区分基类的实际布局。
> public继承代表了”is a“关系，即`B`一定**是**一个`A`。而private继承代表了”has a“关系，即`B`**包含**一个`A`，在这种情况下，继承的劣势大于优势，应当使用组合方式实现功能。

#### 类模板

类模板在项目主要逻辑代码中不要使用，只将类模板用作一个库在设计时可以利用的一个优秀工具，使用类模板时应当考虑代码可读性。

> **Attention:**
> 由于定义类模板时，编译器只能够在编译过程中将头文件的模板变量进行替换，而对应`.cpp`文件当中的模板参数依然没有得到替换（由于没有被调用），会导致`fatal error LNK1120:1个无法解析的外部命令`错误。所以在定义类模板头文件时，将实现也写在头文件当中，不要采取`.h`头文件和`.cpp`实现文件分离的形式。

#### 运算符重载

只有在结构体中使用运算符重载，详见上文`结构体`一节。

> **Attention:**
> 结构体通常代表一组复合数据，而类一般不需要运算符的实现，若需要，说明其应当被设计成结构体，然后被一个类包含。在类中若真的需要近似运算符的功能，可以使用`Equals()`、`LessThan()`、`PrintThe()`等代替`“==”, “<”, “<<”`

### 函数

#### 函数命名

1. 使用驼峰命名法，即函数中间不使用分隔符，每个单词首字母大写。
1. 缩写单词看作一个单词进行首字母大写，而非全部大写，例如`UpdateUrl()`而非`UpdateURL()`。
1. 函数命名使用精简的描述性表达，详细描述放在注释中，例如`GetVehicleState()`而非`GetVehicleStateInfomation()`。

1. 函数返回值设计与函数命名相关联

    - 带有`Get`, `Cal`, `Make`, `Gen`等前缀的函数应当具有返回值，其中get不应当具有计算过程，或不实现复杂计算；cal实现计算后返回，make实现按一定规则制作并返回复杂数据结构，gen实现计算与返回复杂数据结构。
    - 带有`Judge`, `Can`, `Could`, `Has`等前缀的函数应当具有`bool`类型的返回值，明确其功能为判断，由于使用大驼峰命名法，is或if开头的函数中i需要大写，可读性较差，建议使用其他代替。
    - 以`Update*SomeVar*`, `Reset*SomeVar*`等命名的函数应当具有`void`或`bool`（较不常见）的返回值，且没有参数，明确其功能为利用全局变量或类内其他成员更新类成员变量。有参数的此类函数应当见4。
    - 以`Set/Update*SomeVar*With`命名的函数应当具备与`*SomeVar*`同类型或近似类型的参数，即以后者本身或其数据更新前者。

#### 函数定义

1. 函数应当简短、凝练、功能单一、自文档化。
1. 函数长度的最大建议值为50行`[建议]`，最大不能超过80行。
1. 复杂的函数返回值类型使用auto进行后置声明`[建议]`。

```cpp
/* 一个完全由某个条件决定，从而每次只能执行一部分的函数 */
auto AComplexFunction(bool b) -> void {
    if (b) {
        /* many statements */
    } else {
        /* many statements */
    }
}

/* 不如将它分成两个函数 */
auto ASimpleFunction() -> void {
    /* many statements */
}

auto AsimpleFunctionNotB() -> void {
    /* many statements */
}
```

```cpp
/* 建议 */
auto somenamespace::SomeClass::SomeFunc() -> SomeType /* 可以省略前面的域:: */ {
    return something;
}
/* 不建议 */
somenamespace::SomeClass::SomeType somenamespace::SomeClass::SomeFunc() {
    return something;
}
```

> **Attention:**
> auto类型推导过程在编译时已经确定，不会产生性能损耗。后置返回值类型可以继承语句前方的域声明，这可以将函数名称的位置提前，在没有域声明时，一连串的函数声明均使用auto进行后置返回值类型声明的话，可以使函数名对齐在第5列，从而得到更好的阅读效果。
> 建议对除返回基本数据类型之外的所有函数都使用后置返回值类型。

#### 函数输入和输出

1. 类外函数要满足引用透明性，只能够通过显式参数确定输出。
1. 假设不考虑相关类成员变量对输出的影响，则类成员函数也满足引用透明性。
1. 函数中不允许使用全局变量和静态变量作为隐含参数。
1. 函数不允许使用不带`const`的引用参数。
1. 即便函数有多个输出，也全部在`return`中通过`make_tuple`显式声明。

> **Attention:**
> 引用透明性：确定的输入一定能够使函数给出确定的输出，假设与此函数相关的类成员变量是几个symbol，则确定的输入一定能够使函数给出确定的关于这些symbol的确定表达式。
> 引用参数必须带const，这一方面避免了引用参数的意外改变，也限制了以引用参数作为输出的方式。
> 即便函数有多个输出，也不建议使用引用参数曲线救国，而是利用C++ 11的tuple特性和C++ 17的结构化绑定特性处理多个返回值情况，具体使用方式如下：

```cpp
/* 定义一个除法，返回结果与余数 */
#include <tuple>
using std::tuple, std::make_tuple;

auto divide(int dividend, int divisor) -> std::tuple<int, int> {
    auto fraction  = dividend / divisor;
    auto remainder = dividend % divisor;
    return make_tuple(fraction, remainder);
}

/* 调用除法 */
auto [fraction, remainder] = divide(16, 3);
```

#### 默认参数

不要使用默认参数，在调用时显式的赋值所有参数。

### 变量

#### 变量命名

1. 普通变量命名使用全小写加下划线形式进行命名，例如`some_var`, `table_name`。
1. 类的数据成与普通变量方式一样，但必须加结尾的下划线，例如`some_member_`, `my_state_`等。
1. 结构体成员变量不需要加下划线，但结构体的真实名字前面加下划线。（详见4.3.4结构体）
1. 对非类成员变量的指针（一般为临时变量，记得`delete`和置`nullptr`）加`p_`。
1. 除了指针和复杂函数中需要多次调用的临时变量外，禁止使用变量前缀。

> **Attention:**
> 在一个自文档化的代码中，尽量不要在类成员变量、类名、函数名等使用前缀。
> 不建议在临时变量前添加前缀。若希望区分临时变量，应当按照下一节中的auto类型推导方式进行声明。

#### 变量定义

所有临时变量使用auto进行类型自动推导：

```cpp
auto temp_var = func();
auto num      = a + b * 2;
```

> **Attention:**
> `auto`声明的变量需要在声明时正确赋值，例如想要声明一个`double`类型的变量`a`，应当使用`auto a = 1.`而非`auto a = 1`，后者会将`a`声明为`int`类型。

不使用全局变量和静态变量（详见作用域一节）`[建议]`。

### 注释

#### 注释要求

1. 行注释的标识符与注释内容之间有一个空格
1. 多行注释必须使用块注释
1. 行注释要么在语句右侧，要么在整个代码块的上一行。
1. 不使用`@berif`，`@param`等注释格式。
1. 凡是涉及到缩写、复杂函数、复杂流程、复杂变量等，必须在正确位置给出注释。
1. 为保护商业机密，`main`分支或交付代码中的`.cpp`文件不允许有注释。

#### 注释格式

以下格式只提供一个模板，不做严格要求。
头文件：

```cpp
/**
 * Created Time: 2022.09.06
 * File name:    FileName.h
 * Author:       Author Name(author_email@wicri.org)
 * Brief:        Some descriptions here. 可用中文。
 * Include:      Class: SomeClass1, SomeClass2
 * Copyright:    2019 WICRI
 */
/**
 * Modified Time: 2022.09.07
 * Author:       Author Name(author_email@wicri.org)
 * Modified Brief: Some descriptions here. 可用中文。
 */
```

类注释：

```cpp
/** SomeClass类
 * 实现SomeClass的某些功能，balabala
 * 类的某些说明
 */
class SomeClass {};
```

函数注释：

```cpp
/** 构造函数
 * 初始化: name_
 */
SomeClass() : name_(name);

// 加法
int Add(int nVar1, int nVar2);
```

参数注释：

```cpp
CalResult(/*type=*/mytype, value, /*the sort option*/ Mystr){};
```

分支注释：

```cpp
/* 情况满足 */
if (a) {
    /* statements */
}
/* 情况不满足或如何 */
else {
    /* statements */
}
```

TODO注释：

```cpp
/** TODO by Some One
 * do some change about codes here */

// or
// TODO: Fly to the moon
```

> **Attention:**
> 保证注释的颜色统一，**内部不存在被编辑器高亮的部分**是很重要的一点，这可以使开发者免于干扰，仅在需要阅读注释的时候才会将视线焦点置于注释之上。

### 整体风格

#### 命名

除函数和变量两节中给出的命名规则外，还需遵守：

1. 使用描述性的命名。
1. 不要使用缩写，严禁使用不明的(nerr)、易产生歧义的（pre）、去除元音的（updt(update)）单词缩写。
1. 类名不使用分隔符，首字母大写：`MyPowerfulClass`。
1. 枚举使用全大写加下划线，或者至少开头有一个全大写的单词。例如`NOT_EXIST`或`ERROR_Not_Exist`。
1. 命名空间通常以小写字母命名，顶级空间名称取决于项目名称或团队名称。
1. 宏必须使用全大写加下划线的形式。

#### 缩进、换行和空格

1. 4空格缩进，严禁使用制表符缩进。
1. 不要频繁使用多于一次的换行。
1. 命名空间的下一层级必须从0开始缩进。
1. public等域标识符缩进2字符。
1. 构造函数初始化列表若需要另起一行，则缩进8字符。
1. 单行代码宽度不易超过编辑器的宽度，通常在100左右。最长不要超过120。
1. 单个函数的代码行数建议不要超过编辑器的高度，通常在50行左右，最长尽量不要超过80行。
1. 花括号不另起一行。
1. else前换行（可见分支注释一节的示例）。
1. 行尾不允许有空格。
1. 圆括号内没有空格。
1. 循环、分支语句或函数体如果只有一行，则应当在花括号内侧添加空格。
1. 赋值与二元运算符前后总是有空格，但表达式的子式可以不添加空格。
1. 一元运算符不要添加空格。

> **Suggestion:**
> 设置编辑器将tab键自动替换为4个空格（一般默认就是）
> 养成通过缩进识别代码层级的习惯，而不是通过花括号等符号识别代码层级。
> 行尾空格编辑器一般都会自动删除。

### 其他

1. 不要在代码层使用异常处理。使用`error code`进行项目层的异常处理，即只允许正常出现的“异常”。
1. 不要使用运行时类型识别，即`dynamic_cast`。只能使用编译时类型推导。
1. `const`与其他关键字一起使用时候，`const`放在最前。
1. `new/delete`成对出现，谁分配谁释放，释放后必须设置为null。
1. 使用智能指针，不要使用C++指针。`[建议]`
1. `AddRef()/Release()` 成对出现。
1. 指针空值比较使用`nullptr`。
1. 浮点数比较严禁使用`==`，而是使用相减小于一个较小值判断。
1. 不使用浮点数作为`map`的`key`。
1. 不使用不能跨平台的定义，例如微软二次定义的数据类型（`DWORD`实际上就是`unsigned long`）。
1. 不对常用关键字起宏别名，例如给`double`起个`float64`的别名。

## 格式化工具

1. 安装C/C++扩展

1. 项目目录添加.clang-format文件

1. 设置 -> 扩展 -> C/C++ -> “Formatting” -> “C_Cpp:Clang_format_style”设置为file

1. .h或.cpp文件界面按Ctrl Shift + P，输入“format”，选择“使用…格式化文档”，选择“配置默认格式化程序”，选择“C/C++”

1. 设置 -> 文本编辑器 -> 格式化 -> 四个选项按需勾选

.clang-format文件建议内容：

```clang-format
BasedOnStyle: Google
Language: Cpp
Standard: Latest
AccessModifierOffset: -2
AlignArrayOfStructures: Left
AlignAfterOpenBracket: Align
AlignConsecutiveAssignments: true
AlignConsecutiveDeclarations: true
AlignTrailingComments: true
AllowShortBlocksOnASingleLine: Empty
AllowShortEnumsOnASingleLine: true
AllowShortFunctionsOnASingleLine: Empty
AllowShortIfStatementsOnASingleLine: WithoutElse
AlwaysBreakTemplateDeclarations: Yes
BinPackArguments: true
BreakBeforeBraces: Custom
BraceWrapping:
    BeforeElse: true
BreakConstructorInitializers: BeforeComma
ColumnLimit: 120
ConstructorInitializerIndentWidth: 8
ContinuationIndentWidth: 4
DerivePointerAlignment: false
FixNamespaceComments: true
IndentWidth: 4
KeepEmptyLinesAtTheStartOfBlocks: false
MaxEmptyLinesToKeep: 2
NamespaceIndentation: None
PointerAlignment: Left
ReflowComments: true
SpacesBeforeTrailingComments: 1
SpacesInAngles: false
SpacesInParentheses: false
SpacesInSquareBrackets: false
TabWidth: 4
UseTab: Never
```

请注意，clang-format文件中，冒号后面要有空格，否则程序不能正常识别。
也可以在<https://clang.llvm.org/docs/ClangFormatStyleOptions.html> 根据clangformat官方文档和我们的代码规范自行配置.clang-format文件。
