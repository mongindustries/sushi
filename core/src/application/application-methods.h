#include "application.h"

#include "../core/pointer-ownership.h"
#include "../core/pointer-attribute.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

struct ma_application_driver;
struct ma_application;

struct te_window;

SU_PSTRONG(struct ma_application)       ma_make_application                 (struct ma_application_driver generator, SU_PSTRONG(void) customData);

int                                     ma_kill_application                 (SU_PMUT(struct ma_application) application);


void                                    ma_loop_application                 (SU_PREF(struct ma_application) application);


SU_NULLABLE SU_PWEAK(struct te_window)  ma_get_window_from_current_thread   ();

#ifdef __cplusplus
}
#endif // __cplusplus
