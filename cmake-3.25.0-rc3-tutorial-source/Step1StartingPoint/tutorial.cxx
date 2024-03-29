// A simple program that computes the square root of a number
#include <cmath>
// #include <cstdlib> // TODO 5: Remove this line
#include <iostream>
#include <string>
#include <TutorialConfig.h>

// TODO 11: Include TutorialConfig.h

int main(int argc, char* argv[])
{
  if (argc < 2) {
    // TODO 12: Create a print statement using Tutorial_VERSION_MAJOR
    //          and Tutorial_VERSION_MINOR
    std::cout << "Version numbers: " << Tutorial_VERSION_MAJOR 
              << " " << Tutorial_VERSION_MINOR << std::endl;
    std::cout << "Usage: " << argv[0] << " number" << std::endl;
    return 1;
  }

  // convert input to double
  // TODO 4: Replace atof(argv[1]) with std::stod(argv[1])
  // 字符串转数字：atof(argv[1])、std::stod(argv[1])
  const double inputValue = std::stod(argv[1]);

  // 数值类型转字符串：
  // std::to_string()

  // calculate square root
  const double outputValue = sqrt(inputValue);
  std::cout << "The square root of " << inputValue << " is " << outputValue
            << std::endl;
  return 0;
}
/*
补充：
字符串转数字：
C语言转换形式(转为int):
  ...
  std::string str;
  int i = atoi(str.c_str());
  ...

C++转换形式(C++11)(转为int):
  ...
  std::string str;
  int i = std::stoi(str);
  ...

其他还有：
stol(long), stof(float), stod(double) 等.

*/
