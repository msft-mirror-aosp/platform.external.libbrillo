// Copyright 2018 The Chromium OS Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <brillo/blkdev_utils/device_mapper_task.h>

#include <libdevmapper.h>
#include <string>
#include <utility>

#include <brillo/blkdev_utils/device_mapper.h>

namespace brillo {

DevmapperTaskImpl::DevmapperTaskImpl(int type)
    : task_(DmTaskPtr(dm_task_create(type), &dm_task_destroy)) {}

bool DevmapperTaskImpl::SetName(const std::string& name) {
  if (!task_ || !dm_task_set_name(task_.get(), name.c_str())) {
    LOG(ERROR) << "SetName failed";
    return false;
  }
  return true;
}

bool DevmapperTaskImpl::AddTarget(uint64_t start,
                                  uint64_t length,
                                  const std::string& type,
                                  const SecureBlob& parameters) {
  if (!task_ ||
      !dm_task_add_target(task_.get(), start, length, type.c_str(),
                          reinterpret_cast<const char*>(parameters.data()))) {
    LOG(ERROR) << "AddTarget failed";
    return false;
  }
  return true;
}

bool DevmapperTaskImpl::GetNextTarget(uint64_t* start,
                                      uint64_t* length,
                                      std::string* type,
                                      SecureBlob* parameters) {
  if (!task_) {
    LOG(ERROR) << "GetNextTarget: invalid task.";
    return false;
  }

  char *type_cstr, *parameters_cstr;
  next_target_ = dm_get_next_target(task_.get(), next_target_, start, length,
                                    &type_cstr, &parameters_cstr);

  if (type_cstr)
    *type = std::string(type_cstr);
  if (parameters_cstr) {
    SecureBlob parameters_blob(parameters_cstr);
    memset(parameters_cstr, 0, parameters_blob.size());
    *parameters = std::move(parameters_blob);
  }

  return (next_target_ != nullptr);
}

bool DevmapperTaskImpl::Run(bool udev_sync) {
  uint32_t cookie = 0;

  if (!task_) {
    LOG(ERROR) << "Invalid task.";
    return false;
  }

  if (udev_sync && !dm_task_set_cookie(task_.get(), &cookie, 0)) {
    LOG(ERROR) << "dm_task_set_cookie failed";
    return false;
  }

  if (!dm_task_run(task_.get())) {
    LOG(ERROR) << "dm_task_run failed";
    return false;
  }

  // Make sure the node exists before continuing.
  // TODO(sarthakkukreti): move to dm_udev_wait_immediate() on uprevving lvm2.
  return udev_sync ? (dm_udev_wait(cookie) != 0) : true;
}

}  // namespace brillo