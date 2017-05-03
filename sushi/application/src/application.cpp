#include "application.hpp"

#include <window/src/window.hpp>

using namespace std;
using namespace sushi::app;
using namespace sushi::wnd;

application::application                            ():

    device_graphics (nullptr),
    device_sound    (nullptr),
    device_storage  (nullptr) {

}

application::~application                           () {

}


application* const  application::get_instance       () {

    if (instance == nullptr) {

        instance = new application();
    }

    return instance;
}


void                application::initialize         (unique_ptr<applicationDriver>& driver, void* const data) {

    auto    ix          = get_instance  ();
            ix->driver  = move          (driver);

    ix->driver->initialize(ix, data);
}

void                application::destroy            () {

    instance->driver->destroy(get_instance());
}


void                application::run                () {

    instance->driver->run(get_instance());
}


void                application::bindWindow         (const shared_ptr<window>& window) {

}

void                application::unbindWindow       (const shared_ptr<window>& window) {


}


void                application::receivedLowMemory  (application *const application) {

}
