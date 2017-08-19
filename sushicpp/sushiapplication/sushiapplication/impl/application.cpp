#include "../application.hpp"

using namespace std;

using namespace sushi::core;
using namespace sushi::application;
using namespace sushi::window;

using namespace sushi::drivers;

void                        Application::initialise         (applicationDriver* platformDriver,
                                                             const initialiseCallback& initCallback) {

    instance = new Application(platformDriver);
    instance->initialisationCallback = initCallback;

    instance->platformDriver->initialise();
}

void                        Application::destroy            () {

    instance->platformDriver->destroy();

    delete instance;
}


Application::Application                                    (applicationDriver* platformDriver):

    CoreObject(),

    platformDriver(nullptr),
    graphicsDevice(nullptr),
    storageManager(nullptr) {


}

Application::~Application                                   () {

    delete platformDriver;
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


const vector<Window*>&      Application::getTrackedWindows  () const {

    return trackedWindows;
}

// ReSharper disable once CppMemberFunctionMayBeStatic
Window*                     Application::spawnWindow        (WindowLogic* logic,
                                                             const u16string& title,
                                                             const Rectangle& location) const {

    auto    window = new Window(platformDriver->getWindowDriver(), logic);

            window->setTitle(title);
            window->setLocation(location);

            logic->initialise(nullptr);

    return  window;
}
