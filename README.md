# Temabit.Rbe.DataTypes.DateTime

[![CI/CD Pipeline](https://github.com/temabit/rbe-shared-tools-datetime/actions/workflows/ci-cd.yml/badge.svg)](https://github.com/temabit/rbe-shared-tools-datetime/actions/workflows/ci-cd.yml)
[![NuGet Version](https://img.shields.io/nuget/v/Temabit.Rbe.DataTypes.DateTime.svg)](https://www.nuget.org/packages/Temabit.Rbe.DataTypes.DateTime/)
[![NuGet Downloads](https://img.shields.io/nuget/dt/Temabit.Rbe.DataTypes.DateTime.svg)](https://www.nuget.org/packages/Temabit.Rbe.DataTypes.DateTime/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

DateTime data types and utilities for RBE (Rapid Business Engineering) shared components.

## Features

- **UTC DateTime Parsing**: Parse DateTime strings from multiple UTC formats
- **UTC DateTime Formatting**: Format DateTime objects to standardized UTC strings
- **Format Validation**: Validate if a string matches supported UTC DateTime formats
- **Multiple Format Support**: Support for various precision levels (milliseconds, single/double decimals)

## Installation

### Package Manager Console
```powershell
Install-Package Temabit.Rbe.DataTypes.DateTime
```

### .NET CLI
```bash
dotnet add package Temabit.Rbe.DataTypes.DateTime
```

### PackageReference
```xml
<PackageReference Include="Temabit.Rbe.DataTypes.DateTime" Version="0.1.0" />
```

## Usage

### Basic Usage

```csharp
using Temabit.Rbe.DataTypes.DateTime;

// Parse UTC DateTime string
string utcString = "2025-09-29T14:30:45.123Z";
DateTime? parsedDate = utcString.ParseUtcString();

// Format DateTime to UTC string
DateTime now = DateTime.UtcNow;
string formattedUtc = now.FormatAsUtcString();

// Validate UTC format
bool isValidFormat = utcString.HasValidUtcFormat();
```

### Supported Formats

The library supports the following UTC DateTime formats:

- `yyyy-MM-ddTHH:mm:ss.fffZ` (Standard UTC with milliseconds)
- `yyyy-MM-ddTHH:mm:ssZ` (UTC without fractional seconds)
- `yyyy-MM-ddTHH:mm:ss.fZ` (UTC with one decimal place)
- `yyyy-MM-ddTHH:mm:ss.ffZ` (UTC with two decimal places)

### Format Constants

```csharp
// Access predefined format constants
string standardFormat = DateTimeFormats.StandardUtc;
string[] allFormats = DateTimeFormats.AllSupportedUtcFormats;
```

## API Reference

### Extension Methods

#### `ParseUtcString(this string? input)`
Parses a UTC DateTime string and returns a `DateTime?` object.

**Parameters:**
- `input`: The UTC DateTime string to parse

**Returns:**
- `DateTime?`: Parsed DateTime object, or `null` if parsing fails

#### `HasValidUtcFormat(this string? input)`
Validates if a string matches supported UTC DateTime formats.

**Parameters:**
- `input`: The string to validate

**Returns:**
- `bool`: `true` if the format is valid, `false` otherwise

#### `FormatAsUtcString(this DateTime timestamp)`
Formats a DateTime object to the standard UTC string format.

**Parameters:**
- `timestamp`: The DateTime object to format

**Returns:**
- `string`: Formatted UTC DateTime string

### Format Constants

#### `DateTimeFormats` Class
Contains predefined DateTime format constants:

- `StandardUtc`: Standard UTC format with milliseconds
- `UtcWithoutMilliseconds`: UTC format without fractional seconds
- `UtcWithOneDecimal`: UTC format with one decimal place
- `UtcWithTwoDecimals`: UTC format with two decimal places
- `AllSupportedUtcFormats`: Array containing all supported formats

## Requirements

- .NET 8.0 or later
- C# 10.0 or later

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Commit Convention

This project uses [Conventional Commits](https://www.conventionalcommits.org/). Please format your commit messages as:

- `feat:` for new features
- `fix:` for bug fixes
- `docs:` for documentation changes
- `refactor:` for refactoring
- `test:` for adding tests
- `chore:` for maintenance tasks

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes and releases.

## Support

For questions, issues, or contributions, please visit our [GitHub repository](https://github.com/temabit/rbe-shared-tools-datetime).