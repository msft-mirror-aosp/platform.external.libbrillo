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
    chromeos/asynchronous_signal_handler.cc \
    chromeos/backoff_entry.cc \
    chromeos/daemons/daemon.cc \
    chromeos/data_encoding.cc \
    chromeos/errors/error.cc \
    chromeos/errors/error_codes.cc \
    chromeos/file_utils.cc \
    chromeos/flag_helper.cc \
    chromeos/key_value_store.cc \
    chromeos/message_loops/base_message_loop.cc \
    chromeos/message_loops/message_loop.cc \
    chromeos/mime_utils.cc \
    chromeos/process.cc \
    chromeos/process_information.cc \
    chromeos/secure_blob.cc \
    chromeos/strings/string_utils.cc \
    chromeos/syslog_logging.cc \
    chromeos/type_name_undecorate.cc \
    chromeos/url_utils.cc

libchromeos_dbus_sources := \
    chromeos/any.cc \
    chromeos/daemons/dbus_daemon.cc \
    chromeos/dbus/async_event_sequencer.cc \
    chromeos/dbus/data_serialization.cc \
    chromeos/dbus/dbus_method_invoker.cc \
    chromeos/dbus/dbus_method_response.cc \
    chromeos/dbus/dbus_object.cc \
    chromeos/dbus/dbus_service_watcher.cc \
    chromeos/dbus/dbus_signal.cc \
    chromeos/dbus/exported_object_manager.cc \
    chromeos/dbus/exported_property_set.cc \
    chromeos/dbus/utils.cc

libchromeos_http_sources := \
    chromeos/http/curl_api.cc \
    chromeos/http/http_connection_curl.cc \
    chromeos/http/http_form_data.cc \
    chromeos/http/http_request.cc \
    chromeos/http/http_transport.cc \
    chromeos/http/http_transport_curl.cc \
    chromeos/http/http_utils.cc

libchromeos_stream_sources := \
    chromeos/streams/file_stream.cc \
    chromeos/streams/input_stream_set.cc \
    chromeos/streams/memory_containers.cc \
    chromeos/streams/memory_stream.cc \
    chromeos/streams/openssl_stream_bio.cc \
    chromeos/streams/stream.cc \
    chromeos/streams/stream_errors.cc \
    chromeos/streams/stream_utils.cc \
    chromeos/streams/tls_stream.cc

libchromeos_test_helpers_sources := \
    chromeos/http/http_connection_fake.cc \
    chromeos/http/http_transport_fake.cc \
    chromeos/message_loops/fake_message_loop.cc \
    chromeos/streams/fake_stream.cc \

libchromeos_test_sources := \
    chromeos/asynchronous_signal_handler_unittest.cc \
    chromeos/backoff_entry_unittest.cc \
    chromeos/data_encoding_unittest.cc \
    chromeos/errors/error_codes_unittest.cc \
    chromeos/errors/error_unittest.cc \
    chromeos/file_utils_unittest.cc \
    chromeos/flag_helper_unittest.cc \
    chromeos/http/http_connection_curl_unittest.cc \
    chromeos/http/http_form_data_unittest.cc \
    chromeos/http/http_request_unittest.cc \
    chromeos/http/http_transport_curl_unittest.cc \
    chromeos/http/http_utils_unittest.cc \
    chromeos/key_value_store_unittest.cc \
    chromeos/map_utils_unittest.cc \
    chromeos/message_loops/fake_message_loop_unittest.cc \
    chromeos/mime_utils_unittest.cc \
    chromeos/process_unittest.cc \
    chromeos/secure_blob_unittest.cc \
    chromeos/streams/fake_stream_unittest.cc \
    chromeos/streams/file_stream_unittest.cc \
    chromeos/streams/input_stream_set_unittest.cc \
    chromeos/streams/memory_containers_unittest.cc \
    chromeos/streams/memory_stream_unittest.cc \
    chromeos/streams/openssl_stream_bio_unittests.cc \
    chromeos/streams/stream_unittest.cc \
    chromeos/streams/stream_utils_unittest.cc \
    chromeos/strings/string_utils_unittest.cc \
    chromeos/url_utils_unittest.cc \
    testrunner_android.cc

libchromeos_CFLAGS := -Wall -D__BRILLO__ \
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
LOCAL_SRC_FILES := $(libchromeos_core_sources)
LOCAL_C_INCLUDES := $(libchromeos_includes)
LOCAL_SHARED_LIBRARIES := $(libchromeos_shared_libraries)
LOCAL_STATIC_LIBRARIES := libmodpb64
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
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
include $(BUILD_SHARED_LIBRARY)

# Shared minijail library for target
# ========================================================
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := $(libchromeos_cpp_extension)
LOCAL_MODULE := libchromeos-minijail
LOCAL_SRC_FILES := chromeos/minijail/minijail.cc \

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
LOCAL_CPPFLAGS := $(libchromeos_CFLAGS)
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
LOCAL_CPPFLAGS := $(libchromeos_CFLAGS)
LOCAL_RTTI_FLAG := -frtti
LOCAL_CLANG := true
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
include $(BUILD_SHARED_LIBRARY)

# Static library for target
# ========================================================
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := $(libchromeos_cpp_extension)
LOCAL_MODULE := libchromeos
LOCAL_SRC_FILES := $(libchromeos_core_sources)
LOCAL_C_INCLUDES := $(libchromeos_includes)
LOCAL_SHARED_LIBRARIES := $(libchromeos_shared_libraries)
LOCAL_STATIC_LIBRARIES := libmodpb64
LOCAL_CFLAGS := $(libchromeos_CFLAGS)
LOCAL_CPPFLAGS := $(libchromeos_CFLAGS)
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
LOCAL_CPPFLAGS := $(libchromeos_CFLAGS) -Wno-sign-compare
LOCAL_CLANG := true
LOCAL_RTTI_FLAG := -frtti
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
include $(BUILD_STATIC_LIBRARY)

# Shared library for host
# ========================================================
ifeq ($(HOST_OS),linux)
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
endif

# Unit tests.
# ========================================================
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := $(libchromeos_cpp_extension)
LOCAL_MODULE := libchromeos_test
LOCAL_SRC_FILES := $(libchromeos_test_sources)
LOCAL_C_INCLUDES := $(libchromeos_includes)
LOCAL_STATIC_LIBRARIES := libgtest libchrome_test_helpers \
    libchromeos-test-helpers libgmock
LOCAL_SHARED_LIBRARIES := $(libchromeos_shared_libraries) libchromeos libcurl \
    libchromeos-http libchromeos-stream libcrypto
LOCAL_CFLAGS := $(libchromeos_CFLAGS)
LOCAL_CPPFLAGS := $(libchromeos_CFLAGS) -Wno-sign-compare
LOCAL_CLANG := true
include $(BUILD_NATIVE_TEST)
