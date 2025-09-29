using System.Globalization;
using Temabit.Rbe.DataTypes.DateTime.Formats;

namespace Temabit.Rbe.DataTypes.DateTime.Extensions;

public static class DateTimeExtensions
{
    private static System.DateTime? ParseUtcString(this string? input)
    {
        if (string.IsNullOrEmpty(input?.Trim()))
            return null;

        var success = System.DateTime.TryParseExact(
            input, 
            DateTimeFormats.SupportedUtcFormats,
            CultureInfo.InvariantCulture, 
            DateTimeStyles.AdjustToUniversal, 
            out var result);

        return success ? result : null;
    }

    public static bool HasValidUtcFormat(this string? input)
    {
        if (string.IsNullOrEmpty(input?.Trim()))
            return false;

        var endsWithUtcMarker = input.EndsWith('Z');
        var canBeParsed = input.ParseUtcString().HasValue;
        
        return endsWithUtcMarker && canBeParsed;
    }
    
    public static string FormatAsUtcString(this System.DateTime timestamp)
    {
        return timestamp.ToString(DateTimeFormats.DefaultUtc, CultureInfo.InvariantCulture);
    }
}