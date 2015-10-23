# Copyright (C) 2015 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := $(call my-dir)

libchromeos_cpp_extension := .cc
libchromeos_core_sources := \
    brillo/backoff_entry.cc \
    brillo/data_encoding.cc \
    brillo/errors/error.cc \
    brillo/errors/error_codes.cc \
    brillo/flag_helper.cc \
    brillo/key_value_store.cc \
    brillo/message_loops/base_message_loop.cc \
    brillo/message_loops/message_loop.cc \
    brillo/message_loops/message_loop_utils.cc \
    brillo/mime_utils.cc \
    brillo/osrelease_reader.cc \
    brillo/process.cc \
    brillo/process_information.cc \
    brillo/secure_blob.cc \
    brillo/strings/string_utils.cc \
    brillo/syslog_logging.cc \
    brillo/type_name_undecorate.cc \
    brillo/url_utils.cc \

libchromeos_linux_sources := \
    brillo/asynchronous_signal_handler.cc \
    brillo/daemons/daemon.cc \
    brillo/file_utils.cc \
    brillo/process_reaper.cc \

libchromeos_binder_sources := \
    brillo/binder_watcher.cc \

libchromeos_dbus_sources := \
    brillo/any.cc \
    brillo/daemons/dbus_daemon.cc \
    brillo/dbus/async_event_sequencer.cc \
    brillo/dbus/data_serialization.cc \
    brillo/dbus/dbus_method_invoker.cc \
    brillo/dbus/dbus_method_response.cc \
    brillo/dbus/dbus_object.cc \
    brillo/dbus/dbus_service_watcher.cc \
    brillo/dbus/dbus_signal.cc \
    brillo/dbus/exported_object_manager.cc \
    brillo/dbus/exported_property_set.cc \
    brillo/dbus/utils.cc \

libchromeos_http_sources := \
    brillo/http/curl_api.cc \
    brillo/http/http_connection_curl.cc \
    brillo/http/http_form_data.cc \
    brillo/http/http_request.cc \
    brillo/http/http_transport.cc \
    brillo/http/http_transport_curl.cc \
    brillo/http/http_utils.cc \

libchromeos_policy_sources := \
    policy/device_policy.cc \
    policy/libpolicy.cc \

libchromeos_stream_sources := \
    brillo/streams/file_stream.cc \
    brillo/streams/input_stream_set.cc \
    brillo/streams/memory_containers.cc \
    brillo/streams/memory_stream.cc \
    brillo/streams/openssl_stream_bio.cc \
    brillo/streams/stream.cc \
    brillo/streams/stream_errors.cc \
    brillo/streams/stream_utils.cc \
    brillo/streams/tls_stream.cc \

libchromeos_test_helpers_sources := \
    brillo/http/http_connection_fake.cc \
    brillo/http/http_transport_fake.cc \
    brillo/message_loops/fake_message_loop.cc \
    brillo/streams/fake_stream.cc \

libchromeos_test_sources := \
    brillo/any_unittest.cc \
    brillo/any_internal_impl_unittest.cc \
    brillo/asynchronous_signal_handler_unittest.cc \
    brillo/backoff_entry_unittest.cc \
    brillo/data_encoding_unittest.cc \
    brillo/dbus/async_event_sequencer_unittest.cc \
    brillo/dbus/data_serialization_unittest.cc \
    brillo/dbus/dbus_method_invoker_unittest.cc \
    brillo/dbus/dbus_object_unittest.cc \
    brillo/dbus/dbus_param_reader_unittest.cc \
    brillo/dbus/dbus_param_writer_unittest.cc \
    brillo/dbus/dbus_signal_handler_unittest.cc \
    brillo/dbus/exported_object_manager_unittest.cc \
    brillo/dbus/exported_property_set_unittest.cc \
    brillo/dbus/test.proto \
    brillo/errors/error_codes_unittest.cc \
    brillo/errors/error_unittest.cc \
    brillo/file_utils_unittest.cc \
    brillo/flag_helper_unittest.cc \
    brillo/http/http_connection_curl_unittest.cc \
    brillo/http/http_form_data_unittest.cc \
    brillo/http/http_request_unittest.cc \
    brillo/http/http_transport_curl_unittest.cc \
    brillo/http/http_utils_unittest.cc \
    brillo/key_value_store_unittest.cc \
    brillo/map_utils_unittest.cc \
    brillo/message_loops/fake_message_loop_unittest.cc \
    brillo/mime_utils_unittest.cc \
    brillo/osrelease_reader_unittest.cc \
    brillo/process_reaper_unittest.cc \
    brillo/process_unittest.cc \
    brillo/secure_blob_unittest.cc \
    brillo/streams/fake_stream_unittest.cc \
    brillo/streams/file_stream_unittest.cc \
    brillo/streams/input_stream_set_unittest.cc \
    brillo/streams/memory_containers_unittest.cc \
    brillo/streams/memory_stream_unittest.cc \
    brillo/streams/openssl_stream_bio_unittests.cc \
    brillo/streams/stream_unittest.cc \
    brillo/streams/stream_utils_unittest.cc \
    brillo/strings/string_utils_unittest.cc \
    brillo/url_utils_unittest.cc \
    brillo/variant_dictionary_unittest.cc \

libchromeos_CFLAGS := -Wall \
    -Wno-char-subscripts -Wno-missing-field-initializers \
    -Wno-unused-function -Wno-unused-parameter -Werror
libchromeos_CPPFLAGS := -Wno-non-virtual-dtor -Wno-sign-promo \
    -Wno-strict-aliasing
libchromeos_includes := external/gtest/include
libchromeos_shared_libraries := libchrome

# Shared library for target
# ========================================================
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := $(libchromeos_cpp_extension)
LOCAL_MODULE := libchromeos
LOCAL_SRC_FILES := $(libchromeos_core_sources) $(libchromeos_linux_sources)
LOCAL_C_INCLUDES := $(libchromeos_includes)
LOCAL_SHARED_LIBRARIES := $(libchromeos_shared_libraries)
LOCAL_STATIC_LIBRARIES := libmodpb64
LOCAL_CFLAGS := $(libchromeos_CFLAGS)
LOCAL_CPPFLAGS := $(libchromeos_CPPFLAGS)
LOCAL_RTTI_FLAG := -frtti
LOCAL_CLANG := true
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
include $(BUILD_SHARED_LIBRARY)

# Shared binder library for target
# ========================================================
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := $(libchromeos_cpp_extension)
LOCAL_MODULE := libchromeos-binder
LOCAL_SRC_FILES := $(libchromeos_binder_sources)
LOCAL_C_INCLUDES := $(libchromeos_includes)
LOCAL_SHARED_LIBRARIES := $(libchromeos_shared_libraries) \
    libbinder libutils
LOCAL_CFLAGS := $(libchromeos_CFLAGS)
LOCAL_CPPFLAGS := $(libchromeos_CPPFLAGS)
LOCAL_RTTI_FLAG := -frtti
LOCAL_CLANG := true
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
include $(BUILD_SHARED_LIBRARY)

# Shared dbus library for target
# ========================================================
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := $(libchromeos_cpp_extension)
LOCAL_MODULE := libchromeos-dbus
LOCAL_SRC_FILES := $(libchromeos_dbus_sources)
LOCAL_C_INCLUDES := $(libchromeos_includes)
LOCAL_SHARED_LIBRARIES := $(libchromeos_shared_libraries) libchromeos \
    libchrome-dbus libdbus
LOCAL_CFLAGS := $(libchromeos_CFLAGS)
LOCAL_CPPFLAGS := $(libchromeos_CPPFLAGS)
LOCAL_RTTI_FLAG := -frtti
LOCAL_CLANG := true
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH) external/dbus
include $(BUILD_SHARED_LIBRARY)

# Shared minijail library for target
# ========================================================
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := $(libchromeos_cpp_extension)
LOCAL_MODULE := libchromeos-minijail
LOCAL_SRC_FILES := brillo/minijail/minijail.cc \

LOCAL_C_INCLUDES := $(libchromeos_includes)
LOCAL_SHARED_LIBRARIES := $(libchromeos_shared_libraries) libchromeos \
    libminijail
LOCAL_CFLAGS := $(libchromeos_CFLAGS)
LOCAL_CPPFLAGS := $(libchromeos_CPPFLAGS)
LOCAL_RTTI_FLAG := -frtti
LOCAL_CLANG := true
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
include $(BUILD_SHARED_LIBRARY)

# Shared stream library for target
# ========================================================
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := $(libchromeos_cpp_extension)
LOCAL_MODULE := libchromeos-stream
LOCAL_SRC_FILES := $(libchromeos_stream_sources)
LOCAL_C_INCLUDES := $(libchromeos_includes)
LOCAL_SHARED_LIBRARIES := $(libchromeos_shared_libraries) libchromeos \
    libcrypto libssl
LOCAL_CFLAGS := $(libchromeos_CFLAGS)
LOCAL_CPPFLAGS := $(libchromeos_CPPFLAGS)
LOCAL_RTTI_FLAG := -frtti
LOCAL_CLANG := true
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
include $(BUILD_SHARED_LIBRARY)

# Shared http library for target
# ========================================================
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := $(libchromeos_cpp_extension)
LOCAL_MODULE := libchromeos-http
LOCAL_SRC_FILES := $(libchromeos_http_sources)
LOCAL_C_INCLUDES := $(libchromeos_includes)
LOCAL_SHARED_LIBRARIES := $(libchromeos_shared_libraries) libchromeos \
    libchromeos-stream libcurl
LOCAL_CFLAGS := $(libchromeos_CFLAGS)
LOCAL_CPPFLAGS := $(libchromeos_CPPFLAGS)
LOCAL_RTTI_FLAG := -frtti
LOCAL_CLANG := true
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
include $(BUILD_SHARED_LIBRARY)

# Shared policy library for target
# ========================================================
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := $(libchromeos_cpp_extension)
LOCAL_MODULE := libchromeos-policy
LOCAL_SRC_FILES := $(libchromeos_policy_sources)
LOCAL_C_INCLUDES := $(libchromeos_includes)
LOCAL_SHARED_LIBRARIES := $(libchromeos_shared_libraries)
LOCAL_CFLAGS := $(libchromeos_CFLAGS)
LOCAL_CPPFLAGS := $(libchromeos_CPPFLAGS)
LOCAL_RTTI_FLAG := -frtti
LOCAL_CLANG := true
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
include $(BUILD_SHARED_LIBRARY)

# Static library for target
# ========================================================
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := $(libchromeos_cpp_extension)
LOCAL_MODULE := libchromeos
LOCAL_SRC_FILES := $(libchromeos_core_sources) $(libchromeos_linux_sources)
LOCAL_C_INCLUDES := $(libchromeos_includes)
LOCAL_SHARED_LIBRARIES := $(libchromeos_shared_libraries)
LOCAL_STATIC_LIBRARIES := libmodpb64
LOCAL_CFLAGS := $(libchromeos_CFLAGS)
LOCAL_CPPFLAGS := $(libchromeos_CPPFLAGS)
LOCAL_CLANG := true
LOCAL_RTTI_FLAG := -frtti
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
include $(BUILD_STATIC_LIBRARY)

# Static test-helpers library for target
# ========================================================
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := $(libchromeos_cpp_extension)
LOCAL_MODULE := libchromeos-test-helpers
LOCAL_SRC_FILES := $(libchromeos_test_helpers_sources)
LOCAL_C_INCLUDES := $(libchromeos_includes)
LOCAL_STATIC_LIBRARIES := libgtest libgmock
LOCAL_SHARED_LIBRARIES := $(libchromeos_shared_libraries) libchromeos libcurl \
    libchromeos-http libchromeos-stream libcrypto
LOCAL_CFLAGS := $(libchromeos_CFLAGS)
LOCAL_CPPFLAGS := $(libchromeos_CPPFLAGS) -Wno-sign-compare
LOCAL_CLANG := true
LOCAL_RTTI_FLAG := -frtti
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
include $(BUILD_STATIC_LIBRARY)

# Shared library for host
# ========================================================
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := $(libchromeos_cpp_extension)
LOCAL_MODULE := libchromeos-host
LOCAL_SRC_FILES := $(libchromeos_core_sources)
LOCAL_C_INCLUDES := $(libchromeos_includes)
LOCAL_SHARED_LIBRARIES := libchrome-host
LOCAL_STATIC_LIBRARIES := libmodpb64-host
LOCAL_CFLAGS := $(libchromeos_CFLAGS)
LOCAL_CPPFLAGS := $(libchromeos_CPPFLAGS)
LOCAL_RTTI_FLAG := -frtti
LOCAL_CLANG := true
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
include $(BUILD_HOST_SHARED_LIBRARY)

# Unit tests.
# ========================================================
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := $(libchromeos_cpp_extension)
LOCAL_MODULE := libchromeos_test
LOCAL_MODULE_CLASS := EXECUTABLES
ifdef BRILLO
  LOCAL_MODULE_TAGS := debug
endif
generated_sources_dir := $(call local-generated-sources-dir)
LOCAL_SRC_FILES := $(libchromeos_test_sources)
LOCAL_C_INCLUDES := \
    $(libchromeos_includes) \
    $(generated_sources_dir)/proto/external/libchromeos
LOCAL_STATIC_LIBRARIES := libgtest libchrome_test_helpers \
    libchromeos-test-helpers libgmock libBionicGtestMain \
    libchrome_dbus_test_helpers
LOCAL_SHARED_LIBRARIES := $(libchromeos_shared_libraries) libchromeos libcurl \
    libchromeos-dbus libchromeos-http libchromeos-stream libcrypto \
    libchrome-dbus libdbus libprotobuf-cpp-lite-rtti
LOCAL_CFLAGS := $(libchromeos_CFLAGS)
LOCAL_CPPFLAGS := $(libchromeos_CPPFLAGS) -Wno-sign-compare
LOCAL_CLANG := true
LOCAL_RTTI_FLAG := -frtti
include $(BUILD_NATIVE_TEST)

# Run unit tests on target
# ========================================================
# We su shell because process tests try setting "illegal"
# uid/gids and expecting failures, but root can legally
# set those to any value.
runtargettests: libchromeos_test
	adb sync
	adb shell su shell /data/nativetest/libchromeos_test/libchromeos_test
