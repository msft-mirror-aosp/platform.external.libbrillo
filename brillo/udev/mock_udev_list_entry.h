// Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef LIBBRILLO_BRILLO_UDEV_MOCK_UDEV_LIST_ENTRY_H_
#define LIBBRILLO_BRILLO_UDEV_MOCK_UDEV_LIST_ENTRY_H_

#include <memory>

#include <brillo/brillo_export.h>
#include <brillo/udev/udev_list_entry.h>
#include <gmock/gmock.h>

namespace brillo {

class BRILLO_EXPORT MockUdevListEntry : public UdevListEntry {
 public:
  MockUdevListEntry() = default;
  ~MockUdevListEntry() override = default;

  MOCK_CONST_METHOD0(GetNext, std::unique_ptr<UdevListEntry>());
  MOCK_CONST_METHOD1(GetByName,
                     std::unique_ptr<UdevListEntry>(const char* name));
  MOCK_CONST_METHOD0(GetName, const char*());
  MOCK_CONST_METHOD0(GetValue, const char*());

 private:
  DISALLOW_COPY_AND_ASSIGN(MockUdevListEntry);
};

}  // namespace brillo

#endif  // LIBBRILLO_BRILLO_UDEV_MOCK_UDEV_LIST_ENTRY_H_
