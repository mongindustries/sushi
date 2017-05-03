#include <android/native_activity.h>

#include <memory>

#include <application.hpp>

using namespace sushi::app;

void ANativeActivity_onCreate(ANativeActivity* activity, void* data, size_t dataSize) {

    std::unique_ptr<applicationDriver> driver = std::make_unique<application_driver>();

    application::initialize(driver, activity);
}
