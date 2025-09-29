namespace Temabit.Rbe.DataTypes.DateTime.Formats;

/// <summary>
/// Contains standard DateTime format strings for UTC formatting and parsing.
/// </summary>
public static class DateTimeFormats
{
    /// <summary>
    /// Standard UTC format with milliseconds: yyyy-MM-ddTHH:mm:ss.fffZ
    /// </summary>
    public const string DefaultUtc = "yyyy-MM-ddTHH:mm:ss.fffZ";
    
    /// <summary>
    /// UTC format without fractional seconds: yyyy-MM-ddTHH:mm:ssZ
    /// </summary>
    private const string UtcWithoutMilliseconds = "yyyy-MM-ddTHH:mm:ssZ";
    
    /// <summary>
    /// UTC format with one decimal place: yyyy-MM-ddTHH:mm:ss.fZ
    /// </summary>
    private const string UtcWithOneDecimal = "yyyy-MM-ddTHH:mm:ss.fZ";
    
    /// <summary>
    /// UTC format with two decimal places: yyyy-MM-ddTHH:mm:ss.ffZ
    /// </summary>
    private const string UtcWithTwoDecimals = "yyyy-MM-ddTHH:mm:ss.ffZ";
    
    /// <summary>
    /// All supported UTC formats for parsing operations.
    /// </summary>
    public static readonly string[] SupportedUtcFormats =
    [
        DefaultUtc,
        UtcWithoutMilliseconds,
        UtcWithOneDecimal,
        UtcWithTwoDecimals
    ];
}