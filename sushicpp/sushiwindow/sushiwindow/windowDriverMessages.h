#pragma once

namespace sushi::window {
    
    enum WindowDriverMessages: int {
    
        sizeChanged = 0,
        titleChanged,
        stateChanged
    };
}
