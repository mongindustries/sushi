// FastFail.cpp
// sushicore - sushicpp
// 
// Created: 00:50 08/15/2017
// Author: Michael Ong

#include "../FastFail.h"

#include <string>
#include <iostream>

using namespace sushi::core;

using namespace std;

FastFail*   FastFail::instance          = instance = new FastFail();


FastFail::FastFail                      () {

    instance = new FastFail();
}

FastFail::~FastFail                     () {

}

// ReSharper disable once CppMemberFunctionMayBeStatic
void        FastFail::crash             (const exception error) const {

    cerr    << "Program Crashed with exception "
            << error.what()
            << endl;
}

// ReSharper disable once CppMemberFunctionMayBeStatic
void        FastFail::nonFatal          (const exception error) const {

    cerr    << "Program non-fatal error with exception "
            << error.what()
            << endl;
}


using namespace failureTypes;

char const* unimplemented::what         () const {

    return ("Unimplemented functionality: "     + string(exception::what())).c_str();
}

char const* unexpectedPayload::what     () const {

    return ("Unexpected payload delivered: "    + string(exception::what())).c_str();
}

char const* driverNotInstalled::what    () const {

    return ("Driver not installed: "            + string(exception::what())).c_str();
}
