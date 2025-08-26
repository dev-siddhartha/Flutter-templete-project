//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <unique_device_identifier/unique_device_identifier_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) unique_device_identifier_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "UniqueDeviceIdentifierPlugin");
  unique_device_identifier_plugin_register_with_registrar(unique_device_identifier_registrar);
}
