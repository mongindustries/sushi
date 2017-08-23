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

}

FastFail::~FastFail                     () {

}

// ReSharper disable once CppMemberFunctionMayBeStatic
void        FastFail::crash             (const exception error) const {

    cerr    << "💥 Program Crashed with exception "
            << error.what()
            << endl;

    abort();
}

// ReSharper disable once CppMemberFunctionMayBeStatic
void        FastFail::nonFatal          (const exception error) const {

    cerr    << "💥 Program non-fatal error with exception "
            << error.what()
            << endl;
}

using namespace failureTypes;



driverNotInstalled::driverNotInstalled(const string &what, const string &fileName, const int &lineNumber):

    runtime_error("DRIVER_NOT_INSTALLED: " + fileName + "-" + to_string(lineNumber) + ": " + what ) {

}


unexpectedPayload::unexpectedPayload(const string &what, const string &fileName, const int &lineNumber):

    runtime_error("UNEXPECTED_PAYLOAD: " + fileName + "-" + to_string(lineNumber) + ": " + what ) {

}

unimplemented::unimplemented(const string &what, const string &fileName, const int &lineNumber):

    runtime_error("UNIMPLEMENTED: " +  fileName + "-" + to_string(lineNumber) + ": " + what ) {

}
