#include "engine.h"
#include "database.h"
#include "settings.h"
#include <qqml.h>

void Engine::registerTypes(const char *uri)
{
    // @uri harbour.saber.engine
    qmlRegisterType<Settings>(uri, 1, 0, "Settings");
    qmlRegisterType<Database>(uri, 1, 0, "Database");
}
