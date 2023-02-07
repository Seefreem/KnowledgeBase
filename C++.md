
# Table of Contents
- [C++11](#cpp-11)
  - [New key words](#New-key-words)
  - [New features](#New-features)
  - [lambda](#lambda)
- [string](#string)
- [STL](#STL)
  - [Containers](#containers)
    - [vector](#vector)
    - [deque](#deque)
    - [queue](#queue)
    - [stack](#stack)
    - [list](#list)
    - [set](#set)
    - [map](#map)
  - [Algorithms](#algorithms)
  - [iterators](#iterators)
- [pointer](#pointer)
  - [nullptr](#nullptr)
  - [shared_ptr](#shared_ptr)
  - [unique_ptr](#unique_ptr)
  - [week_ptr](#week_ptr)
- [类型转换](#类型转换)
  - [static_cast](#static_cast)
  - [dynamic_cast](#dynamic_cast)
  - [reinterpret_cast](#reinterpret_cast)
  - [const_cast](#const_cast)
- [标准库](#标准库)
  - [](#)
- [其他](#其他)

# cpp-11
参考链接 https://www.coolcou.com/cpluscplus11/cplusplus11-tutorial/cpluscplus11-sfinea-rules.html

## New-key-words
alignas
alignof decltype
auto（重新定义）
static_assert：静态assert，作用于编译时，其参数需要为常量表达式。
using（重新定义）：作用于 typedef 一致，可以用于重命名，非常好用。
noexcept：用于标识函数是否会抛出异常。默认参数是true，表示不会抛出异常，false则表示可能抛出。
          当参数为true时，函数若抛出异常，那么就会调用std::terminate终止程序。
export（弃用，不过未来可能留作他用）
nullptr
constexpr：用于定义常量，和C中的const一样，只是这个常量在编译时产生，而不是初始化程序时产生。从而更加安全。
thread_local
override： 在成员函数后，表示重写（注意区分重载和重写）
final： 在成员函数后，表示不能重写


## New-features
==初始化操作：
  在 C++11中统一使用{}（初始化列表）来初始化变量，可以是普通的变量，也可以是对象。

==枚举类型不再和int类型互相转换：
  enum class Color { red, blue, green };
  int x = Color::red;       //C++98/03中允许，C++11中错误：不存在Color->int的转换
  Color y = 7;              //C++98/03中，C++11中错误：不存在int->Color conversion的转换
  Color z = red;            //C++98/03中允许，C++11中错误：red不在作用域内
  Color c = Color::red;     //C++98/03中错误，C++11中允许

==位域：
  “变量类型 变量名:正整数”，表示这个变量占据的bit数。
  struct {int a:9; int b:7;}这其中a占据9bite，b占据7bite，也就是前面一个变量占据了后面一个变量的一个位。

==原子类型&原子操作：
  这是为多线程准备的，以往的多线程会需要加锁和开锁，原子类型本身就是互斥的操作，从而可以实现lock-free的多线程代码。
  只是对于位域来说，原子类型可能还是不安全。

==lambda函数：
  实际上是局部的伪函数。lambda笑脸。

==显式地删除成员函数：
  这样可以增加可读性。

==原生字符串常量：
  可以避免复杂的转义字符。

==支持C98中的func宏：
  __func__预定义标识符，其基本功能就是返回所在函数的名字。此外这个宏还可以用于指类名和结构体名。
  #include <iostream>
  using namespace std;
  struct TestStruct {
      TestStruct () : name(__func__) {}
      const char *name;
  };
  int main() {
      TestStruct ts;
      cout << ts.name << endl;     // TestStruct
  }
  需要注意的是，__func__的定义是在类、函数等的声明/定义之后。
  
  二、宏定义 https://blog.csdn.net/nyist_zxp/article/details/107890791
  2.1 __FILE__
  2.2 __LINE__
  2.3 #line
  2.4 __func__ 和 __FUNCTION__
  2.5 __DATE__
  2.6 __TIME__

==_Pragma操作符:
  有时候为了防止一个文件被重复引用，导致问题，我们往往声明这个文件只能被包含一次。
  那么现在有三种办法：
  1   #pragma once
  2   #ifndef THIS_HEADER
      #define THIS_HEADER
      // 一些头文件的定义
      #endif
  3   _Pragma("once"); _Pragma() 是一个和sizeof()一样的操作符，那么就可以集成到其他的宏当中去。

==变长参数的宏定义以及 __VA_ARGS__：
  这个常用于打印日志：
  #include <stdio.h>
  #define LOG(...)   {\
      fprintf(stderr,"%s: Line %d:\t", __FILE__, __LINE__);\
      fprintf(stderr, __VA_ARGS__);\
      fprintf(stderr,"\n");\
  }
  int main() {
      int x = 3;
      // 一些代码...
      LOG("x = %d", x); // 2-1-5.cpp: Line 12:      x = 3
  }
  宏 __FILE__ 表示文件名。宏 __LINE__ 表示代码行数。
  __VA_ARGS__ 代表自定义宏的参数列表。

==宽窄字符串的连接：
  在之前的C++标准中，将窄字符串（char）转换成宽字符串（wchar_t）是未定义的行为。
  而在C++11标准中，在将窄字符串和宽字符串进行连接时，支持C++11标准的编译器会将窄字符串转换成宽字符串，然后再与宽字符串进行连接。

==long long类型：
  long long 类型首先是整型，并且至少64位。
  等效的表达：
    long long：           long long、signed long long、long long int、signed long long int
    unsigned long long：  unsigned long long int
  相关的宏：
  #include <climits> 
  LLONG_MIN、LLONG_MAX、ULLONG_MAX
  注意，这些并不在std 命名空间内

==C++11 扩展的整型：
  程序员常会在代码中发现一些整型的名字，比如UINT、__int16、u64、int64_t，等等。
  这些类型有的源自编译器的自行扩展，有的则是来自某些编程环境（比如工作在Linux内核代码中），不一而足。
  C++11规定，扩展的整型必须和标准类型一样，有符号类型和无符号类型占用同样大小的内存空间。
  而由于C/C++是一种弱类型语言，当运算、传参等类型不匹配的时候，整型间会发生隐式的转换，这种过程通常被称为整型的提升（Integral promotion）。

==C++11 宏__cplusplus：
  这种类型的头文件可以被#include到C文件中进行编译，也可以被#include到C++文件中进行编译。
  这样该做法成为了C与C++混用头文件的典型做法。
  __cplusplus这个宏通常被定义为一个整型值。
  比如程序员在想确定代码是使用支持C++11编译器进行编译时，那么可以按下面的方法进行检测：
    #if __cplusplus < 201103L
      #error "should use C++11 implementation" //  #error 会终止编译
    #endif

  混用头文件的方法：
    #ifdef __cplusplus
    extern "C" {
    #endif
    // 一些代码
    #ifdef __cplusplus
    }
    #endif

==断言：
  断言一般用于调试，在发行版本中往往不会有断言。
  C++11中有三种断言：
  1 assert(sxpr)：这是运行时断言，如果不运行到这段代码，那么就不会检测到这个逻辑错误。
    可以通过定义 NDEBUG 宏来禁用 assert。
  2 #error：这是编译时的逻辑检测，如果运行到这里，那么就会停止编译。
  3 static_assert(expr, "Info")：这是编译时断言，又叫静态断言，表达式必须是常量表达式。
  某些标准库中会有自己的静态断言。

==抛出异常：
  以前的版本使用throw() + try + catch()来捕捉异常，并且防止异常扩散。
  C++11中统一换成了noexcept。它有几种用法，并且可以是表达式：
    1 void excpt_func() noexcept; 
    2 void excpt_func() noexcept (常量表达式);
    3 template <class T>
        void fun() noexcept(noexcept(T())) {}
    noexcept(true) 表示该函数不会抛出异常，如果抛出了，那程序就会调用std::terminate 中断程序执行。
    noexcept(false) 表示该函数可能抛出异常，这时候可以用try-catch接住。
    不带参数的时候默认参数为true。
  C++11默认将delete函数设置成noexcept，就可以提高应用程序的安全性。
  C++11标准中让类的析构函数默认也是noexcept(true)的。当然，如果程序员显式地为析构函数指定了noexcept，
  或者类的基类或成员有noexcept(false)的析构函数，析构函数就不会再保持默认值。
    
==属性的初始化：
  以前的初始化方式有三种：“=”、“()”和初始化列表。
  但是限制是，在类定义时 “=”和“()” 只能作用于静态常量，不能作用于其他的情况。
  C++11 中使用"{}"的方式能够作用于任何一种情况。并且这种初始化是在调用构造函数之前，
  初始化优先级：{} > 初始化列表 > 初始化函数中的赋值语句。

  对于 “非常量的静态成员变量” 都需要到类之外去定义和初始化一遍。这样才能保证编译完之后，这个静态变量只存在于一个文件中。

==sizeof()：
  在c++98中不能对类的非静态的属性使用sizeof，但是可以对类的对象的非静态成员变量使用sizeof。
    如 sizeof(Pelple::hand):编译器报错。
  在C++11中，则可以。
    如 sizeod(Pelple::hand),编译通过。

==定义别名：
  原来使用 typedef，像定义宏一样。
  现在可以使用 using Defender = DefenderT<int>; 

==firnd声明：
  友元函数和友元类可以访问声明友元的类的所有private内容。
  C++11的改进是，声明友元的时候可以不添加class关键字。有下面的三种方式：
  class Poly;
  typedef Poly P;
  class LiLei {
      friend class Poly;  // C++98通过, C++11通过
  };
  class Jim {
      friend Poly;          // C++98失败, C++11通过
  };
  class HanMeiMei {
      friend P;             // C++98失败, C++11通过
  };
  这样方便在模板中声明友元。如果friend后面是普通的变量类型，那么friend将被忽略。
  这样做的好处是，我可以将模板的参数声明为 friend，这样我写测试代码的时候，
  我可以将测试代码封装成类，然后将这个类作为友元函数声明到模板定义的类中。
  这样我在测试的时候就可以访问被测试的类的所有private内容了。
  增加了安全性也增加了开发的便捷性。

==虚函数、纯虚函数和重载：
  虚函数是指函数前面添加了 virtual 的函数，虚函数有函数体。
  纯虚函数是指函数前面添加了 virtual 并且没有函数体，在函数末尾加上了"=0"的函数。只是函数声明。
  重载是指子类中的函数于父类函数的函数原型一样（函数名、参数列表等一样），那么就称之为重载。
  不仅仅函数具有重载，模板也具有重载——相同的模板名，不同的参数表。
  重载可以是重载普通的函数，也可以是重载虚函数。对于纯虚函数，则是需要定义函数。
  
  定义一个函数为虚函数，不代表函数为不被实现的函数。
  定义他为虚函数是为了允许用基类的指针来调用子类的这个函数。
  定义一个函数为纯虚函数，才代表函数没有被实现。
  定义纯虚函数是为了实现一个接口，起到一个规范的作用，规范继承这个类的程序员必须实现这个函数。
  换句话说就是，对于有virtual的虚函数，当父类指针被赋值为子类的指针时，这时候调用虚函数，
  就是调用的子类中重载之后的函数。而不是父类中的同名函数。而普通的重载则是调用的父类中的函数。

  我的理解：
  重载是为了应对不同的参数情况，即函数名一样，但是参数表不一样，返回值可以不一样，访问权限可以不一样。
  并且重载存在于同一个作用域或者不同的继承登记中。

  重写则是完全一样的函数声明（函数名和参数列表）。

  虚函数的作用则是使得父类能够调用子类中重写的函数。如果父类中的一个函数被virtual修饰，
  那么这个函数在被子类重写之后，将子类对象强转为父类对象时，这个函数仍然是调用的子类中定义的函数。
  如果没有virtual修饰，那么就只能调用父类中自己定义的函数。

  多态包含了重载、重写和虚函数。

  virtual修饰具有继承特性。
  由此产生两个问题：
    1 我希望我的这个函数不被重写，因为我通过这个函数定义了一套标准，或者保证了某种安全性。
      那么我就可以在这个函数之后添加 final 关键字，表示不能被重写。但是可以进行重载。
    2 由于继承太多了，我并不知道多个祖先类中是否对某个函数进行了 virtual修饰，或者我想
      重写某个virtual函数，但是我不知道是哪个祖先类定义的，因此我也不知道我的重写是否成功了。
      于是可以使用 override 关键字来修饰我写的函数，放在我的函数参数表和函数体之间。
      它的作用是，表明我写的这个函数必定会重写祖先类们中的某个被virtual修饰的函数。
      如果找不到这么一个函数，那么就会报错。这有助于我确定我是否成功重写了某个虚函数。
      不做检查则可能引入很多的问题，比如我函数名中的单词写错了，但是别人并没有写错那个单词。
      那么别人在调用函数的时候就不是调用我写的这个函数，而是调用了某个祖先类定义的函数。
      从而出现奇怪的问题。

  还有值得注意的是，final/override也可以定义为正常变量名，只有在其出现在函数后时才是能够控制继承/派生的关键字。

==模板：
  模板也可以有默认参数。
  对于模板类来说，默认参数应该放在右边。对于模板函数来说，默认参数位置随意，但是为了统一，写代码的时候统一放右边。
  模板参数可以通过两种方式设置。1 是通过传进去的参数自动推导。2 是用<>显式定义；
  template <class T, class U = double>
  void f(T t = 0, U u = 0);
  void g() {
      f(1, 'c');        // f<int,char>(1,'c'), 自动推导模板参数
      f(1);             // f<int,double>(1,0), 使用了默认模板参数double
      f();              // 错误: T无法被推导出来
      f<int>();         // f<int,double>(0,0), 使用了默认模板参数double
      f<int,char>();    // f<int,char>(0,0)
  }

==外部模板：
  和外部变量类似，外部模板通过 extern 标识。标识这个玩意儿在其他文件中定义好了，这里不再重复定义，只是拿来用。
  同样的外部类模板也是一样的。
  声明外部变量和模板是针对编译流程的优化，可以不做。
  模板的实例化是在编译的时候完成的。编译完成之后编译器会将完全一样的代码合并，删除多余的备份。
  而声明外部模板就类似于，告诉编译器，这个实例化的模板版本在外部文件中实现了，这里只是引用。
  实例化模板的方式有两种：1 显式实例化，也就是用尖括号实例化；2 声明外部模板，注意前提是外部真的存在这个实例化。
  对于模板：  template <typename T> void fun(T) {}
  显式实例化： template void fun<int>(int);
  外部声明：  extern template void fun<int>(int);

==模板参数：
  对于初始化模板，以前不可以使用局部类型（相反则是全局类型）和匿名类型（也就是通过匿名类型的对象）。
  对于C++11 则可以使用局部类型和匿名类型来初始化模板。
  但是仍然不能将匿名类型的声明和模板的初始化写在一起，它们需要单独的语句。
==子类继承构造函数：
  当基类具有多个版本的构造函数时，如果子类可能使用到每一种构造函数，那么子类中需要为每一种基类的构造函数
  写派生类的相关构造函数，以完成参数的传递。
  这就导致代码变多。
  这时候可以使用 using Base::Base; 这样做的话，编译器会针对基类的各种构造函数版本产生派生类的
  构造函数，并且会对带有默认参数的基类构造函数进行展开，枚举每种可能的情况，并产生对应的派生类的构造函数。
  但是这种操作并不会继承基类的默认参数的值。
  对于基类的构造函数的这种操作同样可以使用到基类的其他成员函数上。
  using using Base::Base的方法只是减少了程序员的编程量，并没有实质上取消派生类对基类构造函数的对应
  版本的构造函数的构建。在编译的时候，会根据实际使用到的基类构造函数去选择性的生成派生类的构造函数版本。

  遇到的问题有两个，第一，如果两个基类的两个构造函数的参数表一样，那么using 构造出的派生类的两个构造函数
  将完全一样，导致错误，这时候就需要程序员手动定义派生类的构造函数了。
  第二，派生类中using了基类的带参数构造函数后，自己不会产生默认的无参构造函数，那么在实例化的时候如果不传参数，就会报错。

==委派构造函数:
  同样当构造函数很多，并且构造函数中存在重复代码的时候，就可以考虑优化。
  这时候就出现了委派构造函数。委派构造函数也是构造函数，委派构造函数是指，
  将构造函数中公共的部分放在单独的一个构造函数中。这个函数被成为目标构造函数。
  然后在其他构造函数的初始化列表中调用这个目标构造函数。调用目标构造函数的函数就叫委派构造函数。
  这种调用自身构造函数的方法就像调用基类的构造函数一样。目标函数也是构造函数。只是初始化列表中
  不能同时出现目标构造函数和其他成员属性。因此，可以将其他成员属性放在目标构造函数的初始化列表中。
  并且，这种调用自身构造函数的做法可以递归，也可以用于模板的初始化。

==显式转换操作符 explicit：
  在C++中“=”的使用往往涉及到隐式类型转换，如int转为double。隐式类型转换实际上调用的是操作符（ 如double() ）。
  除了操作符之外，构造函数也可以被隐式调用，比如参数全都有默认值的构造函数，以及无参构造函数。
  相反显式调用则是指用"()"、"{}"和强制类型转换操作符等方法。主要还是增加可读性。
  要使一个构造函数或者操作符是显式调用，那么就需要他们的声明之前加上 explicit 关键字。
  这样这些函数就不能通过"="进行隐式调用了。

==初始化列表：
  也就是"{}"初始化方式。
  对于C++11内部的类型，默认支持初始化列表的初始化方法。
  但是对于自定义的数据类型、操作符、类和函数则需要额外的代码才能支持初始化列表。
  同时，初始化列表是唯一一个阻止类型收窄的初始化方式。类型收窄是指在赋值的过程中会造成部分数据丢失的情况，
  注意是要产生数据丢失，而不是看数据类型是否是从大类型转为小类型。
  初始化列表初始化的例子：
  int a[] = {1, 3, 5};          // C++98通过，C++11通过
  int b[] {2, 4, 6};            // C++98失败，C++11通过
  vector<int> c{1, 3, 5};      // C++98失败，C++11通过
  map<int, float> d =
        {{1, 1.0f}, {2, 2.0f} , {5, 3.2f}}; // C++98失败，C++11通过
  int * i = new int(1);
  double * d = new double{1.2f};
  对于自定义的函数(类的初始化是通过调用构造函数实现的)，要使用初始化列表，则需要使用
  <initializer_list> 头文件中的 initialize_list<T> 模板。
  例子：
  void Fun(initializer_list<int> iv){ }
  int main() {
      Fun({1, 2});
      Fun({}); // 空列表
  }
  初始化列表会创建一个list中间变量，可以像普通的列表一样去遍历它。
  更骚的操作是重载一个自定义的数组类的“[]”操作符和“=”操作符，让C++具有像MATLAB数组操作一样的功能——
  也就是通过"vab[{indexes}] = 6" 的方式将indexes指定的数组元素全都赋值为6。

==POD(plain old data):
  平凡旧数据，也就是说能够进行二进制拷贝的数据。拷贝之后，数据仍然不变。那什么情况下拷贝之后就变了？
  判断是否是POD可以用<type_traits>头文件中的 template <typename T> struct std::is_pod;
  如：cout << is_pod<int>::value << endl; // 1

==非受限联合体：
  C++98中，只有POD类型才能作为联合体(union)的成员。
  C++11中，取消了联合体对于数据成员类型的限制。标准规定，任何非引用类型都可以成为联合体的数据成员，
  这样的联合体即所谓的非受限联合体（Unrestricted Union）。
  只是还是有一个要求，那就是自定义的类型需要有平凡的构造函数和析构函数。而编译器会在有自定义构造函数
  的情况下删掉平凡的构造函数，导致定义的联合体不能创建对象。
  这时候就需要自己手动给非受限联合体定义构造函数和析构函数，这两个函数可以是非平凡的。

==用户自定义字面量：
  问题：当需要传递一个类的对象给一个函数的时候，我们需要先创建这个类的对象，然后把对象当做参数传递给函数。
  目标：直接通过对象的参数创建匿名对象，并且同时传递给函数。避免单独创建一个对象。
  解决办法：自定义字面量。也就是自定义一个操作符，这个操作符能够作为字面量的后缀，以完成对字面量的
  处理和创建相应的对象的功能。
  如：
  struct RGBA{
      uint8 r;
      uint8 g;
      uint8 b;
      uint8 a;
      RGBA(uint8 R, uint8 G, uint8 B, uint8 A = 0):
          r(R), g(G), b(B), a(A){}
  };
  // 注意这里的自定义操作符是在结构体之外的。和运算符重载的定义方式不一样。
  RGBA operator "" _C(const char* col, size_t n) { ... }
  
  void blend(RGBA && col1, RGBA && col2) {
      // Some color blending action
      cout << "blend " << endl << col1 << col2 << endl;
  }
  int main() {
      blend("r255 g240 b155"_C, "r15 g255 b10 a7"_C);
  }
  注意，在字面量操作符函数的声明中，operator ""与用户自定义后缀之间必须有空格。
  但是在使用中却没有空格。

  我很好奇，为什么不直接在参数所在位置定义一个变量，并且传参：
  Func([new] class1(arg1, arg2));

==匿名对象
  除了常规的定义对象的方法：
  AnonymousObject ano = AnonymousObject(3); // 调用的是构造函数，而不是复制构造函数
  AnonymousObject ano(3);
  还有构造匿名对象的方法：
  AnonymousObject(2);
  这样构造出来的对象属于auto类型，生命周期只在这个作用域中。匿名对象的常见用法就是作为函数参数。
  但是它可以用于定义“用后即焚”的变量。这种方式可以被用于写日志对象的场景。

==内联命名空间：
  情景：在一些情况下，我们想要将一个命令名空间中的代码拆分成几个独立的代码，但是又不能移出这个命名空间。比如不同版本的库文件。
       这个时候就可以使用命名空间来分割不同版本的代码。但是访问代码的时候就需要加上版本号相关的命名空间的名字。增加了代码量。
       并且子空间中的模板不能在父空间中特化，即使使用了using也不行。（这也是inline出现的关键原因）
  问题：找到一种方便的办法既能隔离不同的代码，又能在父空间中使用子空间中的模板？
  解决办法：使用inline 关键字取消namespace，结合#ifdef MAC 来使用。
  这样我们可以根据宏来选择将哪个子空间打开。
  但是我们还是可以通过"::"的方式去访问没有打开的命名空间。

==模板的别名：
  typedef和using能够起到一样的取别名的功能。
  我们可以通过<type_traits>头文件中的 is_same<type1, type2>::value 来判断两个类型是否是同样的类型，并验证上面的结论。
  但是using还可以用于模板的别名：
  template<typename T> using MapString = std::map<T, char*>;
  MapString<int> numberedString;

==SFINEA规则：
  即SFINEA - Substitution failure is not an error。
  意思就是，在模板重载的情况下，编译器会根据参数去决定采用哪一个重载的模板版本。
  当找不到对应的版本时，不会报错。编译会继续进行。
  例子：
  struct Test {
    typedef int foo;
  };
  template <typename T>
  void f(typename T::foo) {}  // 第一个模板定义 - #1
  template <typename T>
  void f(T) {}                   // 第二个模板定义 - #2 重载之后的模板
  int main() {
      f<Test>(10);     // 调用#1.
      f<int>(10);      // 调用#2. 由于SFINEA，虽然不存在类型int::foo，也不会发生编译错误
  }

==一段神奇的代码：
  #include <iostream>
  template <int I> struct A {};
  char xxx(int); // 声明了一个函数，只是声明
  char xxx(float);  // 声明了另一个函数，只是声明
  template <class T> A<sizeof(xxx((T)0))> f(T){}
  // 在上面的代码中，先运算(T)0，也就是类型强转，然后执行 xxx(type)，再执行sizeof(xxx)，
  // 最后特化 A<> 模板，作为函数f() 的返回值类型。
  int main() {
      f(1);
      std::cout<< sizeof(xxx((int)0)) <<std::endl; 
      std::cout<< sizeof(xxx((float)0)) <<std::endl; 
  }


## lambda
http://c.biancheng.net/view/3741.html
==语法结构：
  lambda 表达式定义了一个匿名函数，并且可以捕获一定范围内的变量。lambda 表达式的语法形式可简单归纳如下：
  [ capture ] ( params ) opt -> ret { body; };
  其中 capture 是捕获列表，params 是参数表，opt 是函数选项，ret 是返回值类型，body是函数体。
==用法案例：
  auto f = [](int a) -> int { return a + 1; };
  std::cout << f(1) << std::endl;  // 输出: 2

  对于简单类型的返回值，编译器可以根据return语句自动推导：
  auto x1 = [](int i){ return i; };  // OK: return type is int
  auto x2 = [](){ return { 1, 2 }; };  // error: 无法推导出返回值类型

==捕获外部变量的方式：
  lambda 表达式还可以通过捕获列表捕获一定范围内的变量：
    [] 不捕获任何变量。
    [&] 捕获外部作用域中所有变量，并作为引用在函数体中使用（按引用捕获）。
    [=] 捕获外部作用域中所有变量，并作为副本在函数体中使用（按值捕获）。
    [=，&foo] 按值捕获外部作用域中所有变量，并按引用捕获 foo 变量。
    [bar] 按值捕获 bar 变量，同时不捕获其他变量。
    [this] 捕获当前类中的 this 指针，让 lambda 表达式拥有和当前类成员函数同样的访问权限。
      如果已经使用了 & 或者 =，就默认添加此选项。捕获 this 的目的是可以在 lamda 中使用当前类的成员函数和成员变量。
    
    auto x1 = []{ return i_; };                    // error，没有捕获外部变量
    auto x2 = [=]{ return i_ + x + y; };           // OK，捕获所有外部变量——值传递
    auto x3 = [&]{ return i_ + x + y; };           // OK，捕获所有外部变量——引用传递
    auto x4 = [this]{ return i_; };                // OK，捕获this指针
    auto x5 = [this]{ return i_ + x + y; };        // error，没有捕获x、y
    auto x6 = [this, x, y]{ return i_ + x + y; };  // OK，捕获this指针、x、y
    auto x7 = [this]{ return i_++; };              // OK，捕获this指针，并修改成员的值
    捕获列表可以写清楚每一个变量的捕获方式。
==注意事项：
  使用值捕获的时候，捕获发生在定义lambda函数的位置，如果在捕获之后，在使用之前，被捕获的变量的值发生了变化，
  lambda中的值并不会发生变化。
  auto f = [=]{ return a; };      // 按值捕获外部变量
  a += 1;                         // a被修改了
  std::cout << f() << std::endl;  // 输出a在修改前的值

# string
http://c.biancheng.net/view/400.html

字符串分割：
C++中没有python 和 Java 中的split函数，于是只有手动实现split了：
接助两个关键工具：stringstream，也就是字符流。
还有一个就是istream& getline (istream& is, string& str, char delim);
终止符不仅仅可以自己指定，还默认包括换行符。

#include <sstream> // stringstream
void split(const std::string& srcStr, std::vector<std::string>& targetStr, const char delim) {
    std::stringstream sin(srcStr);
    std::string temp;
    // 流输入分割
    while(std::getline(sin, temp, delim))
        targetStr.push_back(temp);
} 
其他分割方式：
https://developer.aliyun.com/article/75575#:~:text=%E5%8E%9F%E5%9E%8B%EF%BC%9A%20char%20*strtok(char,%E4%B8%AA%E8%A2%AB%E5%88%86%E5%89%B2%E7%9A%84%E4%B8%B2%E3%80%82


# STL
C++ STL（标准模板库）是一套功能强大的 C++ 模板类，提供了通用的模板类和函数，
这些模板类和函数可以实现多种流行和常用的算法和数据结构，如向量、链表、队列、栈。

C++ 标准模板库的核心包括以下三个组件：
容器（Containers）	容器是用来管理某一类对象的集合。C++ 提供了各种不同类型的容器，比如 deque、list、vector、map 等。
算法（Algorithms）	算法作用于容器。它们提供了执行各种操作的方式，包括对容器内容执行初始化、排序、搜索和转换等操作。
迭代器（iterators）	迭代器用于遍历对象集合的元素。这些集合可能是容器，也可能是容器的子集。

https://en.cppreference.com/w/cpp/header
https://zh.cppreference.com/w/cpp/header


## containers
==各种容器的元素在内存中的储存方式：
  1 vector（向量）：相当于数组，自动扩展大小。它可以像数组一样被操作，可以将vector 看作动态数组。
    在创建一个vector 后，它会自动在内存中分配一块连续的内存空间进行数据存储，
    初始的空间大小可以预先指定也可以由vector 默认指定，这个大小即capacity （）函数的返回值。
    当存储的数据超过分配的空间时vector 会重新分配一块内存块，效率非常低。
  2 deque（队列）：它不像vector 把所有的对象保存在一块连续的内存块，而是采用多个连续的存储块，并且在一个
    映射结构中保存对这些块及其顺序的跟踪。向deque 两端添加或删除元素的开销很小，它不需要重新分配空间。
  3 list（列表）：是一个线性链表结构，它的数据由若干个节点构成，每一个节点都包括一个信息块（即实际存储的数据）、
    一个前驱指针和一个后驱指针。它无需分配指定的内存大小且可以任意伸缩，这是因为它存储在非连续的内存空间中，
    并且由指针将有序的元素链接起来。
  4 set, multiset, map, multimap 是一种非线性的树结构，具体的说采用的是一种比较高效的特殊的
    平衡检索二叉树—— 红黑树结构。

==各种容器优劣分析：
  https://blog.csdn.net/u014465639/article/details/70241850
  1 Vector：
    优点：
      A 支持随机访问，访问效率高和方便，支持[ ] 操作符和vector.at()。
      B 节省空间，因为它是连续存储，在存储数据的区域都是没有被浪费的，
        但是要明确一点vector 大多情况下并不是满存的，在未存储的区域实际是浪费的。
    缺点：
      A 在内部进行插入、删除操作效率非常低。
      B 只能在vector 的最后进行push 和pop ，不能在vector 的头进行push 和pop 。
      C 当动态添加的数据超过vector 默认分配的大小时要进行内存的重新分配、拷贝与释放，这个操作非常消耗能。
  2 List：
    优点：
      不使用连续的内存空间这样可以随意地进行动态操作，插入、删除操作效率高；
    缺点：
      A 不能进行内部的随机访问，即不支持[ ] 操作符和vector.at()，访问效率低。
      B 相对于verctor 占用更多的内存。
  3 Deque：
    优点：
      A 支持随机访问，方便，即支持[ ] 操作符和vector.at() ，但性能没有vector 好；
      B 可以在两端进行push 、pop 。
    缺点：
      在内部进行插入、删除操作效率低。
  4 关联容器：
    A 其内部实现是采用非线性的二叉树结构，具体的说是红黑树的结构原理实现的；
    B set 和map 保证了元素的唯一性，mulset 和mulmap 扩展了这一属性，可以允许元素不唯一；
    C 元素是有序的集合，默认在插入的时候按升序排列。

  基于以上特点：
    A 关联容器对元素的插入和删除操作比vector 要快，因为vector 是顺序存储，而关联容器是链式存储；
      比list 要慢，是因为即使它们同是链式结构，但list 是线性的，而关联容器是二叉树结构，
      其改变一个元素涉及到其它元素的变动比list 要多，并且它是排序的，每次插入和删除都需要对元素重新排序；
    B 关联容器对元素的检索操作比vector 慢，但是比list 要快很多。vector 支持随机访问，
      list是逐个遍历，关联容器是搜索红黑树。关联容器查找的复杂度基本是Log(N) 。
    C 在使用上set 区别于vector,deque,list 的最大特点就是set 是内部排序的，
      这在查询上虽然逊色于vector ，但是却大大的强于list 。
    D 在使用上map 的功能是不可取代的，它保存了“键- 值”关系的数据。

==需求分析于解决方案：
  对于插入和删除较多的情况，可以选择list、map、set等容器。
  对于随机访问需求多的情况，可以使用vector和deque。
  对于查找需求较多的情况，可以使用map、set等容器。
  对于交叉的需求情况，可以酌情考虑结合使用不同的容器。
  对于查找需求要求高的，还可以使用 unordered_map 和 unordered_set等给予hash的容器。

==C++11容器：
  https://zh.cppreference.com/w/cpp/header
  https://blog.csdn.net/kingsoft188/article/details/121139289
  https://www.cnblogs.com/xenny/p/9689784.html


### vector
https://zh.cppreference.com/w/cpp/header/array
https://www.runoob.com/w3cnote/cpp-vector-container-analysis.html

cheeting-shit：https://blog.csdn.net/u014465639/article/details/70241850

==初始化例子：
  vector<int> vec1;        //默认初始化，vec1为空
  vector<int> vec2(vec1);  //使用vec1初始化vec2
  vector<int> vec3(vec1.begin(),vec1.end());//使用vec1初始化vec2
  vector<int> vec4(10);    //10个值为0的元素
  vector<int> vec5(10,4);  //10个值为4的元素
  vector<string> vec6(10,"null");   //10个值为null的元素
  vector<string> vec7(10,"hello");  //10个值为hello的元素

==常用操作例子：
  vec1.push_back(100);            //添加元素
  int size = vec1.size();         //元素个数， 注意是元素个数，不是数组长度
  bool isEmpty = vec1.empty();    //判断是否为空
  cout<<vec1[0]<<endl;            //取得第一个元素
  vec1.insert(vec1.end(),5,3);    //从vec1.back位置插入5个值为3的元素
  vec1.pop_back();                //删除末尾元素
  vec1.erase(vec1.begin(),vec1.end());                 //删除之间的元素，其他元素前移
  cout<<(vec1==vec2)?true:false;  //判断是否相等==、！=、>=、<=...
  vector<int>::iterator iter = vec1.begin();           //获取迭代器首地址
  vector<int>::const_iterator c_iter = vec1.begin();   //获取const类型迭代器
  vec1.clear();                   //清空元素，size变为零

==遍历方法（四种）：
  int main() {
    std::vector<int> array1(10);
    array1.insert(array1.begin(), 3, 15);
    // 第一种：脚标法
    for (auto i = 0; i < array1.size(); ++i) {
        std::cout<< array1[i] << std::endl;
    }
    // 第二种：for-each法
    // 注意这种方法获取到的是元素的值，因此通过这种方法去修改元素的话，是不会改变原来数组中的元素的。
    // 要修改数组中的元素，就需要建立引用：for (auto& i : array1)
    for (auto i : array1) {
        std::cout<< i << std::endl;
    }
    // 第三种：迭代器法
    array1.insert(array1.begin(), 15);
    for (auto i = array1.begin(); i != array1.end(); ++i) {
        std::cout<< *i << std::endl;
    }
    // 第四种：逆序遍历法
    // 需要注意，逆序遍历法的迭代器也是自加一，而不是减一
    for (auto ri = array1.rbegin(); ri != array1.rend(); ++ri) {
        std::cout<< *i << std::endl;
    }
    return 0;
  }
  其他：<algorithm>
  有时候使用index会导致数组越界。那么一种替代方案是：std::find_if():
    #include <iostream>
    #include <algorithm>
    #include <vector>
    #include <iterator>
    
    int main()
    {
        std::vector<int> v{1, 2, 3, 4};
        int n1 = 3;
        int n2 = 5;
        auto is_even = [](int i){ /*Other processes*/ return i%2 == 0; };
    
        auto result3 = std::find_if(begin(v), end(v), is_even);
    
        (result3 != std::end(v))
            ? std::cout << "v contains an even number: " << *result3 << '\n'
            : std::cout << "v does not contain even numbers\n";
    }

### deque
https://www.cainiaojc.com/cpp/cpp-deque.html

注意区分：
front和back返回的是首位的元素；
begin & rend和end & rbegin 返回的是头指针和尾指针，并且尾指针是不存储元素的。
for-each得到的是元素而不是迭代器。

### queue
==初始化：
  queue <int> fquiz;
==操作：
  front	该函数返回第一个元素。元素起着非常重要的作用，因为所有的删除操作都是在front元素上执行的。
  back	该函数返回最后一个元素。该元素起着非常重要的作用，因为所有插入操作都在后面元素上执行。
  push	该函数用于在末尾插入一个新元素。
  pop	该函数用于删除第一个元素。


### stack
https://www.cainiaojc.com/cpp/cpp-stack.html
栈相对来说比较简单一些。
==初始化：
  stack <int> newst;
==操作： 
  top	该函数用于访问堆栈的顶部元素。该元素起着非常重要的作用，因为所有插入和删除操作都是在顶部元素上执行的。
  push	该函数用于在堆栈顶部插入新元素。
  pop	该函数用于删除元素，堆栈中的元素从顶部删除。

### list
https://www.cainiaojc.com/cpp/cpp-list.html
头文件：#include <list>
具有排序sort函数，可以传递一个比较函数进去。
但是vector和deque都没有sort函数。

### set
#include <set>
集合是存储排序键的关联容器，其中每个键都是唯一的，可以插入或删除但不能更改。
需要注意的是，对于集合，插入也是insert，删除也是erase。
集合支持find操作。而线性容器并不支持。
find的返回值是对应key的指针，或者是end()指针，表示没找到。
count返回的是对应key的元素个数。如果没找到那就是0。

set的含义是集合，它是一个有序的容器，里面的元素都是排序好的，支持插入，删除，查找等操作，就像一个集合一样。
所有的操作的都是严格在logn时间之内完成，效率非常高。
set和multiset的区别是：set插入的元素不能相同，但是multiset可以相同。Set默认自动排序。使用方法类似list。
因为set具有排序的功能，因此，需要传递比较函数进去。如果不传递，就使用默认的比较函数。
而list的

set< int > iset(ivec.begin(), ivec.end());

### map
#include <map>
C++ STL中标准关联容器set, multiset, map, multimap内部采用的就是一种非常高效的平衡检索二叉树：红黑树。
但是不一样的是，map、vector和deque三种容器都支持"[]"操作符，只是有一些区别。
但是注意，构建红黑树的条件是元素个数超过一定数目。

map的[]操作不是随机访问，而是查找红黑树，并且以 "map[key1] = value1"的方式使用时可以具有找不到就插入新的元素的功能。
deque属于分块顺序存储，可以通过[] 实现随机访问，但是并不是完全的随机访问。
vector的[]操作则是随机访问。

==初始化：
  std::map<int, string> map1;
  map1[101] = "Nikita";
  map1.insert(map  <int,string>::value_type(2, "Diyabi"));//插入元素
  map1.insert(pair <int,string>            (1, "Siqinsini"));
  map1.insert(make_pair<int,string>        (4, "V5"));
  string str = map1[3];                  //根据key取得value，key不能修改
  还可以用初始化列表进行初始化。

==遍历：
  1 使用迭代器
    for( map::iterator ii=Employees.begin(); ii!=Employees.end(); ++ii)
    {
        cout << (*ii).first << ": " << (*ii).second << endl;
    }
    for (auto i = map1.begin(); i != map1.end(); ++i) {
        std::cout << i->first << " " << i->second << std::endl;
    }
  2 使用for-each
    for (auto i : map1) {
        std::cout << i.first << " " << i.second << std::endl;
    }
## algorithms
https://c-cpp.com/cpp/algorithm.html
https://www.apiref.com/cpp-zh/cpp/algorithm.html
头文件 <algorithm>
==查找：
  std::find,
  std::find_if, 
  std::find_if_not
  
  返回值是指针。
  三种用法：
  // 查找第一个等于某一个数的元素，并返回指针
  constexpr InputIt find(InputIt first, InputIt last, const T& value)
  // 根据判断函数，查找第一个使得判断函数返回值为true的元素，并返回指针
  constexpr InputIt find_if(InputIt first, InputIt last, UnaryPredicate p)
  // 根据判断函数，查找第一个使得判断函数返回值为false的元素，并返回指针
  constexpr InputIt find_if_not(InputIt first, InputIt last, UnaryPredicate q)

  案例：
  std::vector<int> v{1, 2, 3, 4};
    int n1 = 3;
    auto is_even = [](int i){ return i%2 == 0; };
    auto result1 = std::find(begin(v), end(v), n1);
    auto result3 = std::find_if(begin(v), end(v), is_even);

==查找最大值和最小值：
  std::min_element
  返回值是迭代器。
  ForwardIt min_element(ForwardIt first, ForwardIt last)
  ForwardIt min_element(ForwardIt first, ForwardIt last, Compare comp)

  例子：
  std::vector<int> v{3, 1, 4, 1, 5, 9};
  std::vector<int>::iterator result = std::min_element(v.begin(), v.end());

==遍历：
  std::for_each：
    遍历每一个元素，并且对每一个元素进行一个操作：
    std::vector<int> nums {3, 4, 2, 8, 15, 267};
    // 注意这里的捕获为空，但是参数是容器中的元素的类型
    auto print = [](const int& n) { std::cout << " " << n; }; 
    std::for_each(nums.begin(), nums.end(), print); // (begin(), end(), function)

  std::for_each_n:
    std::vector<int> ns{1, 2, 3, 4, 5};
    // (begin, number, function)
    std::for_each_n(ns.begin(), 3, [](auto& n){ n *= 2; });

==复制：
  std::copy, std::copy_if:
    // 注意，第三个参数是目标容器的插入迭代器，表示在这个位置开始插入，先插入，再移动迭代器。
    std::copy(from_vector.begin(), from_vector.end(), to_vector.begin());
    // copy_if 的第四个参数是函数指针，函数返回真，则执行拷贝，函数的参数是源容器中的元素。
    std::copy_if(InputIt first, InputIt last, OutputIt d_first, UnaryPredicate pred)
    
  对于浅拷贝和深拷贝的问题：
  所有的拷贝都是执行的内存拷贝，也就是浅拷贝。C++默认支持的数据类型是深拷贝，但是用户自定义的类型
  就需要自己写拷贝函数，以实现深拷贝——重载"="运算符。

==交换：
  std::swap：
  swap支持基本类型的交换，也支持STL容器的交换：
    int a = 5, b = 3;
    std::swap(a,b);

==排序：
  std::sort：
  默认是升序排列。排序逻辑可以理解为从左往右的排序。
  比较函数接收两个容器元素，返回两个元素的比较结果，如：
  bool operator()(int a, int b) const {   
      return a < b;
  } 
  保持参数表和比较表达式中参数的顺序，那么大于和小于符号就表示了排序结果中的升序和降序。
  比如这里，"a < b"，表示排序结果是升序。左边的元素小于右边的元素。形象地称之为 less。
  相反，如果比较表达式是"a > b"，那么排序的结果就是降序，称之为 greater。
  
  几种使用方法：
  std::array<int, 10> s = {5, 7, 4, 2, 8, 6, 1, 9, 0, 3}; 

  std::sort(s.begin(), s.end()); // 默认 less          // 升序
  std::sort(s.begin(), s.end(), std::greater<int>()); // 降序
  std::sort(s.begin(), s.end(), customLess);          // 升序
  std::sort(s.begin(), s.end(), [](int a, int b) {    // 降序
        return a > b;   
    });
==比较：
  std::max：返回最大值 https://c-cpp.com/cpp/algorithm/max.html
  std::min：返回最小值 https://c-cpp.com/cpp/algorithm/min.html
  std::equal：用于比较两个线性序列是否相等。
  支持四种调用方式：
  const T& max(const T& a, const T& b)
  const T& max(const T& a, const T& b, Compare comp)
  T max( std::initializer_list<T> ilist)
  T max( std::initializer_list<T> ilist, Compare comp )
  min类似。

  std::equal：
  bool equal(InputIt1 first1, InputIt1 last1, InputIt2 first2)
  bool equal(InputIt1 first1, InputIt1 last1, 
           InputIt2 first2, BinaryPredicate p)
  bool equal(InputIt1 first1, InputIt1 last1, 
           InputIt2 first2, InputIt2 last2 )
  bool equal( InputIt1 first1, InputIt1 last1,
            InputIt2 first2, InputIt2 last2,
            BinaryPredicate p )
  其中 BinaryPredicate p 是比较函数，当两个元素相等时，返回true，不相等时返回false。

## iterators
  


# pointer
指针使用过程中常见的问题：
  有些内存资源已经被释放，但指向它的指针并没有改变指向（成为了野指针），并且后续还在使用；
  有些内存资源已经被释放，后期又试图再释放一次（重复释放同一块内存会导致程序运行崩溃）；
  没有及时释放不再使用的内存资源，造成内存泄漏，程序占用的内存资源越来越多。
C++11 新标准在废弃 auto_ptr 的同时，增添了 unique_ptr、shared_ptr 以及 
weak_ptr 这 3 个智能指针来实现堆内存的自动回收。
C++ 智能指针底层是采用引用计数的方式实现的。简单的理解，智能指针在申请堆内存空间的同时，
会为其配备一个整形值（初始值为 1），每当有新对象使用此堆内存时，该整形值 +1；
反之，每当使用此堆内存的对象被释放时，该整形值减 1。
当堆空间对应的整形值为 0 时，即表明不再有对象使用它，该堆空间就会被释放掉。

实际上，每种智能指针都是以类模板的方式实现的。
如shared_ptr<T>（其中 T 表示指针指向的具体数据类型）的定义位于<memory>头文件，并位于 std 命名空间中。

## nullptr
nullptr 是 nullptr_t 类型的右值常量，专用于初始化空类型指针。nullptr_t 是 C++11 新增加的数据类型，
可称为“指针空值类型”。也就是说，nullpter 仅是该类型的一个实例对象（已经定义好，可以直接使用），
如果需要我们完全定义出多个同 nullptr 完全一样的实例对象。

例如:
int * a1 = nullptr;
char * a2 = nullptr;
double * a3 = nullptr;
换句话说就是nullptr本身就是指针。


## shared_ptr
也就是计数指针。
声明方法：
std::shared_ptr<int> p1;             //不传入任何实参
std::shared_ptr<int> p2(nullptr);    //传入空指针 nullptr
std::shared_ptr<int> p3(new int(10));
std::shared_ptr<int> p3 = std::make_shared<int>(10);
//调用拷贝构造函数
std::shared_ptr<int> p4(p3);//或者 std::shared_ptr<int> p4 = p3;
//调用移动构造函数
std::shared_ptr<int> p5(std::move(p4)); //或者 std::shared_ptr<int> p5 = std::move(p4);

shared_ptr的初始化：
  1 使用普通的指针，但同一个普通指针不能给多个智能指针赋值。
  2 使用shared_ptr。
shared_ptr在释放内存的时候并不会递归释放所指内存中的指针所指的内容。因此对于这种情况需要用户自定义
的delete函数：
  //调用拷贝构造函数
  std::shared_ptr<int> p4(p3);//或者 std::shared_ptr<int> p4 = p3;
  //调用移动构造函数
  std::shared_ptr<int> p5(std::move(p4)); //或者 std::shared_ptr<int> p5 = std::move(p4);
  实际上借助 lambda 表达式，我们还可以像如下这样初始化 p7，它们是完全相同的：
  std::shared_ptr<int> p7(new int[10], [](int* p) {delete[]p; });

除此之外还提供了相关的函数，以帮助判断指针当前的状态，比如有多少计数，是否唯一，取值，重置等等。

## unique_ptr
unique_ptr 由 C++11 引入，旨在替代不安全的 auto_ptr。unique_ptr 是一种定义在头文件<memory>中的智能指针。
它无法复制到其他unique_ptr，无法通过值传递到函数，也无法用于需要副本的任何标准模板库 （STL）算法。
只能通过std::move()移动 unique_ptr，即对资源管理权限可以实现转移。
这意味着，内存资源所有权可以转移到另一个unique_ptr，并且原始 unique_ptr 不再拥有此资源。



## week_ptr
当两个 shared_ptr 所指内存中存在指针域，并且互相指，那么就形成了循环引用。这时候释放这两个 shared_ptr 指针的时候，
就不能正确释放 shared_ptr 所指的内存。
为了避免这种情况就设计了 weak_ptr ，这个指针只能查看 shared_ptr 的状态，而不能访问其所指内存。
但可以通过lock函数获取一个shared_ptr以访问所指内存。

weak_ptr 被设计为与 shared_ptr 共同工作，可以从一个 shared_ptr 或者另一个 weak_ptr 对象构造而来。

weak_ptr 是为了配合 shared_ptr 而引入的一种智能指针，没有重载 operator* 和 operator-> ，因此取名为 weak，表明其是功能较弱的智能指针。

它的最大作用在于协助 shared_ptr 工作，可获得资源的观测权。观察者意味着 weak_ptr 只对 shared_ptr 进行引用，而不改变其引用计数，
当被观察的 shared_ptr 失效后，相应的 weak_ptr 也相应失效。

使用 weak_ptr 的成员函数 use_count() 可以观测资源的引用计数，
另一个成员函数 expired() 的功能等价于 use_count()==0，但更快，表示被观测的资源(也就是shared_ptr管理的资源)已经不复存在。

weak_ptr可以使用一个非常重要的成员函数lock()从被观测的 shared_ptr 获得一个可用的 shared_ptr 管理的对象， 从而操作资源。
但当 expired()==true 的时候，lock() 函数将返回一个存储空指针的 shared_ptr。


# 类型转换
类型转换分为显式类型转换和隐式类型转换。
隐式转一般出现在四种场合：
  1 赋值的时候：int *pi = 0; // 0被转化为int *类型
  2 运算的时候：3 + 3.1
  3 做函数参数的时候
  4 做函数返回值的时候
显式转换：
	static_cast、dynamic_cast、reinterpret_cast 和 const_cast

最好不要使用C语言的类型转换方式。
## static_cast
In short: 
  1 基础数据类型转换（基本类型）
  2 同一继承体系中类型的转换（父子类型）
  3 任意类型与空指针（void *）之间的转换（指针类型）

用法：static_cast < type-id > ( expression )

说明：该运算符把expression转换为type-id类型，但没有运行时类型检查来保证转换的安全性。

它主要有如下几种用法：
  1 用于类层次结构中基类和子类之间指针或引用的转换。
    进行上行转换（把子类的指针或引用转换成基类表示）是安全的；
    进行下行转换（把基类指针或引用转换成子类指针或引用）时，由于没有动态类型检查，所以是不安全的。
  2 用于基本数据类型之间的转换，如把int转换成char，把int转换成enum。这种转换的安全性也要开发人员来保证。
  3 把void指针转换成目标类型的指针*(不安全!!)
  4 把任何类型的表达式转换成void*类型。

## dynamic_cast
In short: 
执行派生类指针或引用与基类指针或引用之间的转换。
  1 其他三种都是编译时完成的，dynamic_cast是运行时处理的，运行时要进行运行时类型检查；
  2 基类中要有虚函数，因为运行时类型检查的类型信息在虚函数表中，有虚函数才会有虚函数表；
  3 可以实现向上转型和向下转型，前提是必须使用public或protected继承；

用法：dynamic_cast < type-id > ( expression )

dynamic_cast主要用于类层次间的上行转换和下行转换，还可以用于类之间的交叉转换。
在类层次间进行上行转换时，dynamic_cast和static_cast的效果是一样的；
在进行下行转换时，dynamic_cast具有类型检查的功能，比static_cast更安全。

当父类子类有同名非虚函数的时候，调用的是转换后的指针类型的函数；
当父类子类有同名虚函数的时候呢，调用的是指针转换前指向的对象类型的函数。

## reinterpret_cast
In short: 
从字面意思理解是一个“重新解释的类型转换”。
也就是说对任意两个类型之间的变量我们都可以个使用reinterpret_cast在他们之间相互转换，
无视类型信息。不推荐使用。
https://www.cnblogs.com/woshidaan-caw/p/12702383.html

用法：reinpreter_cast<type-id> (expression)

说明：type-id必须是一个指针、引用、算术类型、函数指针或者成员指针。
它可以把一个指针转换成一个整数，也可以把一个整数转换成一个指针
（先把一个指针转换成一个整数，在把该整数转换成原类型的指针，还可以得到原先的指针值）。

使用场景：
  从指针类型到一个足够大的整数类型
  从整数类型或者枚举类型到指针类型
  从一个指向函数的指针到另一个不同类型的指向函数的指针
  从一个指向对象的指针到另一个不同类型的指向对象的指针
  从一个指向类函数成员的指针到另一个指向不同类型的函数成员的指针
  从一个指向类数据成员的指针到另一个指向不同类型的数据成员的指针

## const_cast
In short: 
  1 只能对指针或者引用去除或者添加const属性
  2 对于变量直接类型不能使用const_cast
  3 不能用于不同类型之间的转换，只能改变同种类型的const属性

用法：const_cast<type_id> (expression)

说明：该运算符用来修改类型的const属性。

常量指针被转化成非常量指针，并且仍然指向原来的对象；
常量引用被转换成非常量引用，并且仍然指向原来的对象；常量对象被转换成非常量对象。

作者：深红的眼眸
链接：https://www.jianshu.com/p/6ebc3c31c491
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。


# 标准库
# 其他
注意函数的返回值不能是函数内的变量的引用，因为局部变量在退出之后会被释放掉。
就算是容器对象也不行。但是可以是智能指针的引用。前提是，你得定义智能指针。
比如下面的函数在被调用之后，就很可能出现段错误：
  vector<string> split(string& srcStr, const char delim) {
      vector<string> splitedStr{"aaa"};
      return splitedStr;
  } 
一个保险的建议是，将返回值当做引用参数传进去。这样就会减小赋值开销，也能避免申请内存。


