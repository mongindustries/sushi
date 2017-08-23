#pragma once

namespace sushi::window {
    
    enum class WindowDriverMessages: int {
    
        sizeChanged = 0,
        titleChanged,
        stateChanged
    };
}
