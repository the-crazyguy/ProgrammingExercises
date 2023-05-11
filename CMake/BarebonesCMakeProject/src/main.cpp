#include <iostream>
#include "test.h"
#include "foo.h"


int main(int argc, char** argv)
{
    std::cout << Add(1, 2) << std::endl;
    Greetings::HelloWorld();
    
    return 0;
}