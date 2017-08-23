#include "../application.hpp"

#include "ApplicationDriver.hpp"

#include <sushiwindow/window.hpp>
#include <sushiwindow/windowLogic.hpp>

#include <sushigraphics/graphicsDevice.hpp>

using namespace std;

using namespace sushi::core;
using namespace sushi::application;
using namespace sushi::window;
using namespace sushi::graphics;

using namespace sushi::drivers;

Application*                            Application::instance           = nullptr;


void                                    Application::initialise         (ApplicationDriver* platformDriver,
                                                                         const initialiseCallback& initCallback) {

    instance = new Application(platformDriver);

    instance->initialisationCallback = initCallback;

    instance->platformDriver->initialise();
}

void                                    Application::destroy            () {

    instance->platformDriver->destroy();

    delete instance;
}


Application::Application                (ApplicationDriver* platformDriver):

    CoreObject(),

    platformDriver(platformDriver),

    graphicsDevice(new GraphicsDevice(platformDriver->getGraphicsDriver())),
    storageManager(nullptr) {

}

Application::~Application               () {

    delete graphicsDevice;

    delete platformDriver;
}


const ApplicationDriver*                Application::getPlatformDriver  () const {

    return platformDriver;
}

const GraphicsDevice*                   Application::getGraphicsDevice  () const {

    return graphicsDevice;
}

const void*                             Application::getStorageManager  () const {

    return storageManager;
}


const vector<Window*>&                  Application::getTrackedWindows  () const {

    return trackedWindows;
}


const Application::initialiseCallback&  Application::getInitCallback    () const {

    return this->initialisationCallback;
}

// ReSharper disable once CppMemberFunctionMayBeStatic
Window*                                 Application::spawnWindow        (WindowLogic* logic,
                                                                         const u16string& title,
                                                                         const Rectangle& location) const {

    auto    window = new Window(platformDriver->getWindowDriver(), logic);

            window->setTitle    (title);
            window->setLocation (location);

    trackedWindows.push_back(window);

    logic->initialise(nullptr);

    return  window;
}
