# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).
This changelog is generated automatically based on [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

## [0.5.0](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/compare/v0.4.0...v0.5.0) (2025-08-22)


### Features

* Q2'25 image update ([#79](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/79)) ([4efc5ce](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/4efc5ce192d503ff33980e4621f7c09dc9efb86c))

## [0.4.0](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/compare/v0.3.0...v0.4.0) (2025-05-28)


### ⚠ BREAKING CHANGES

* q4 image update ([#65](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/65))
* **TF>=1.3:** restore TPG version range ([#61](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/61))

### Features

* Q1'25 image update ([#74](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/74)) ([8154ae9](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/8154ae9c829d1783495bf094a55a995f37771fe0))
* q4 image update ([#65](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/65)) ([acd9172](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/acd91722488494dbe5ec9e9791e8465ad87ed0e1))
* Update CODEOWNERS ([#53](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/53)) ([4fd49fb](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/4fd49fb46732a3cbce028762921104a905d28a51))
* Update CODEOWNERS ([#53](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/53)) ([dba4762](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/dba4762c0a4a84041ccb180fc95d04e73ea2d637))
* Update script to have unique service account name generated ([#56](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/56)) ([f791d95](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/f791d9522ca9950b54c7a19613f005a4719a258b))


### Bug Fixes

* **TF>=1.3:** restore TPG version range ([#61](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/61)) ([f84b9f8](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/f84b9f8cf299bf1e51522224533526801bab42b1))

## [0.3.0](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/compare/v0.2.0...v0.3.0) (2024-11-06)


### Features

* **deps:** Update Terraform google to v6 ([#45](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/45)) ([80844d3](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/80844d37a86ae243ab50ba2d5fd74109e66f1849))


### Bug Fixes

* update versions.tf to allow latest MS version ([#52](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/52)) ([b41b37c](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/b41b37c5b4528a5bc6c3f98fbd2677ef2fb59438))

## [0.2.0](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/compare/v0.1.1...v0.2.0) (2024-10-25)


### Features

* **deps:** Update Terraform google to v5 ([#25](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/25)) ([9688db8](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/9688db879a1f58edd792f87e221df1e6f00d3060))
* update ba image for q3 rollout ([#48](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/48)) ([1b81a39](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/1b81a393e97df7c21ee1013a59d93a57ae58cae4))
* Update BA Image version ([#43](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/43)) ([e0d45d8](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/e0d45d88c221814ccb53f6529ba625d8c4abcd26))
* Update README.md to 0.2.0 tag pre-release ([#50](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/50)) ([dd988dd](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/dd988dd2f33dd29a820b01a1f92256e18bf759e8))
* update the script to deploy BA without PSA ([#49](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/49)) ([5847c6d](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/5847c6db0660e5832cc47e5b09c39b5a4ab51b69))


### Bug Fixes

* **deps:** Update Terraform http ([#20](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/20)) ([1a92934](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/1a9293460a01daa67f029ce12b70ccf2229a9c1f))
* **deps:** Update Terraform random ([#23](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/23)) ([592bd6b](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/592bd6b6012b041197d86cb48839ac14455e6e3c))
* **deps:** Update Terraform time ([#24](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/24)) ([cd10f86](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/cd10f866948858e5501cf0aece92c5306f08f230))
* fix terraform fmt issues ([#36](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/36)) ([cf87fc5](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/cf87fc5b8e76a0fe4ad54ef396cad890138c49c7))
* Update CODEOWNERS ([#39](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/39)) ([c47b476](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/c47b4768a3c336fa65fdcfb88ad9a9d24b4185cf))

## [0.1.1](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/compare/v0.1.0...v0.1.1) (2023-09-22)


### Bug Fixes

* update readme usage ([#6](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/6)) ([60aadd1](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/60aadd1e10d3dc30d14ce604ad875c3680aa96be))

## 0.1.0 (2023-09-20)


### Features

* update integration tests and examples ([#4](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/issues/4)) ([e766adf](https://github.com/GoogleCloudPlatform/terraform-google-backup-dr/commit/e766adfcec573fc5910e8fd9f8907f1d2042b0fe))

## [0.1.0](https://github.com/terraform-google-modules/terraform-google-backup-dr/releases/tag/v0.1.0) - 20XX-YY-ZZ

### Features

- Initial release

[0.1.0]: https://github.com/terraform-google-modules/terraform-google-backup-dr/releases/tag/v0.1.0
