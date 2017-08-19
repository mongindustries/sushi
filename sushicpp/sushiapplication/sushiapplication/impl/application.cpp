#include "../application.hpp"
#include "sushicore/FastFail.h"

using namespace std;

using namespace sushi::core;
using namespace sushi::application;

using namespace sushi::drivers;

void                        Application::initialise         (applicationDriver* platformDriver,
                                                             const initialiseCallback& initCallback) {

}

void                        Application::destroy            () {

}


Application::Application                                    (void* platformDriver) :

    platformDriver(nullptr),
    graphicsDevice(nullptr),
    storageManager(nullptr) {

}

Application::~Application                                   () {


}


const applicationDriver*    Application::getPlatformDriver  () const {

    return platformDriver;
}

const void*                 Application::getGraphicsDevice  () const {

    return graphicsDevice;
}

const void*                 Application::getStorageManager  () const {

    return storageManager;
}


const vector<void*>&        Application::getTrackedWindows  () const {

    return trackedWindows;
}


void*                       Application::spawnWindow        (void* logic,
                                                             const u16string& title,
                                                             const Rectangle& location) {

    FastFail::instance->crash(failureTypes::unimplemented());

    return nullptr;
}
