#pragma once

/// Defines that the object owning this pointer will be the one that's doing the deletion.
#define SUSHI_PO_STRONG

/// Defines that the object owning this pointer will not be doing the deletion.
#define SUSHI_PO_WEAK


/// Defines that the pointer's ownership will be taken from the caller.
#define SUSHI_PT_TRANSFER

/// Defines that the pointer's ownership will only be referred by the callee.
#define SUSHI_PT_REF

/// Defines that the pointer's ownership will be referred and taken by the callee.
#define SUSHI_PT_COPY
