// Copyright 2022 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package single_project_example

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestBackupSingleProjectExample(t *testing.T) {
	testBackupSingleProjectExample := tft.NewTFBlueprintTest(t)

	const (
		instanceNamePrefix = "backup-recovery-appliance"
		zone               = "us-central1-a"
	)
	testBackupSingleProjectExample.DefineVerify(func(assert *assert.Assertions) {
		testBackupSingleProjectExample.DefaultVerify(assert)

		projectID := testBackupSingleProjectExample.GetStringOutput("project_id")

		instances := gcloud.Run(t, fmt.Sprintf("compute instances list --project %s --filter name~%s", projectID, instanceNamePrefix))

		// check if two appliances gce instance is available
		assert.Equal(2, len(instances.Array()), "found 2 appliance gce instance")

		for _, instance := range instances.Array() {
			instanceStatus := instance.Get("status").String()
			assert.Equal("RUNNING", instanceStatus, "found status as RUNNING of appliance gce instance")
		}

	})
	testBackupSingleProjectExample.Test()
}
