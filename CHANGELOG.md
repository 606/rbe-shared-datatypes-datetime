# [2.0.0](https://github.com/606/rbe-shared-datatypes-datetime/compare/v1.0.2...v2.0.0) (2025-09-29)


### Bug Fixes

* modernize GitHub Actions and switch to cloud runners ([ce93ece](https://github.com/606/rbe-shared-datatypes-datetime/commit/ce93ecefe604546320b4c515e19316cafcf503ba))


### BREAKING CHANGES

* Self-hosted runner is no longer required

## [1.0.2](https://github.com/606/rbe-shared-datatypes-datetime/compare/v1.0.1...v1.0.2) (2025-09-29)


### Bug Fixes

* resolve workflow conditions causing package publishing to be skipped ([826f452](https://github.com/606/rbe-shared-datatypes-datetime/commit/826f452ec9dc2d31a8f3a4710b905f0157b4451c))

## [1.0.1](https://github.com/606/rbe-shared-datatypes-datetime/compare/v1.0.0...v1.0.1) (2025-09-29)


### Bug Fixes

* update CodeQL Action to v3 and add global.json for SDK version management ([6042c6b](https://github.com/606/rbe-shared-datatypes-datetime/commit/6042c6bf1b6d0c59a960b0fa9b2beac71c422e8f))

# 1.0.0 (2025-09-29)


### Bug Fixes

* clean up GitHub Actions artifacts and complete semantic-release setup ([df0443b](https://github.com/606/rbe-shared-datatypes-datetime/commit/df0443b7e6fe35726a502e825fe92d979954629b))
* resolve semantic release permission issues and update CI/CD configuration ([d635070](https://github.com/606/rbe-shared-datatypes-datetime/commit/d6350703a37f338b288d5ad141e5aa8928e8f38e))
* resolve semantic-release dependency issues and refresh gitignore ([45fbcad](https://github.com/606/rbe-shared-datatypes-datetime/commit/45fbcaddd59087b30947661194eb4069b8679cbe))


### Features

* add CI/CD pipeline with self-hosted runner support ([2aeddd2](https://github.com/606/rbe-shared-datatypes-datetime/commit/2aeddd2784a8bae32cbce1c06d87a8f6a3b4bdc6))
* add comprehensive CI/CD pipeline with self-hosted runner support ([07ac04b](https://github.com/606/rbe-shared-datatypes-datetime/commit/07ac04bf1cbe93f42fab5d8a9e25efc08f1cb116))

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial project setup with clean architecture
- DateTime extension methods for UTC parsing and formatting
- Support for multiple UTC DateTime formats
- Format validation utilities
- Comprehensive CI/CD pipeline with GitHub Actions
- Automated semantic versioning
- NuGet package publishing
- Security scanning and code analysis

### Changed
- Nothing yet

### Deprecated
- Nothing yet

### Removed
- Nothing yet

### Fixed
- Nothing yet

### Security
- Nothing yet

## [0.1.0] - 2025-09-29

### Added
- Initial release of Temabit.Rbe.DataTypes.DateTime
- Basic DateTime utilities and extension methods
- UTC format support and validation
