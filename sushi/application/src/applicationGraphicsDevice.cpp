//
// Created by Michael Ong on 20/5/17.
//

#include "applicationGraphicsDevice.hpp"

using namespace std;

using namespace sushi::app;

SU_SYN_PROP     (applicationGraphicsDevice, weak_ptr<applicationGraphicsDeviceDriver>, driver)

SU_SYN_PROP_RO  (applicationGraphicsDevice, shared_ptr<void>, nativeInstance)
