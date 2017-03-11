#include "application-methods.h"
#include "application.h"

#include "../window/window.h"

#include <stdlib.h>

SU_PSTRONG(struct ma_application)   ma_make_application                 (struct ma_application_driver generator, SU_PSTRONG(void) customData) {

    SU_PSTRONG(struct ma_application) app = (SU_PSTRONG(struct ma_application)) malloc(sizeof(struct ma_application));

    app->drivers            = generator;
    app->customData         = customData;

    generator.initialize(app, customData);

    app->device_graphics    = NULL;
    app->device_audio       = NULL;

    return app;
}

void                                ma_kill_application                 (SU_PMUT(struct ma_application) application) {

    free(application->drivers.window_driver);
    application->drivers.window_driver = NULL;

    free(application);
    application = NULL;
}


SU_PWEAK(struct te_window)          ma_get_window_from_current_thread   () {

    return NULL;
}
