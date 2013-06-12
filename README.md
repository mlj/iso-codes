# iso-codes

A comprehensive database of ISO language codes and ISO script codes for Ruby.

## Installation

   gem install iso-codes

## Usage

Language codes can be looked up using `find_language`:

    require 'iso_codes'

    language = ISOCodes.find_language('lav')
    # ISO 639-3 reference name
    language.reference_name
    # ISO 639-3 identifier
    language.identifier
    # ISO 639-1 (alpha-2) identifier
    language.alpha2
    # ISO 639-2 (alpha-3) identifiers
    language.alpha3_bibliographic
    language.alpha3_terminology

### Macrolanguages

ISO 639-3 defines language identifiers that covers a set of other language
identifiers. For example, the identifier `lav` for Latvian corresponds to `lvs`
for Standard Latvian and `ltg` for Latgalian. These identifiers are called
[macrolanguages] [1] and can be looked up in the same way as other language
codes:

    language = ISOCodes.find_language('lav')
    language.reference_name
    # => "Latvian"
    language.class
    # => ISOCodes::Macrolanguage
    language.alpha3_bibliographic
    # => "lav"
    language.alpha2
    # => "lv"

The individual languages covered by the identifier can be listed:

    language.individual_languages.map { |l| l.identifier }
    # => ["ltg", "lvs"]

For an individual language the macrolanguage, if any, can be found.

    language = ISOCodes.find_language('ltg')
    language.class
    # => ISOCodes::IndividualLanguage
    language.macrolanguage.identifier
    # => "lav"

## License

MIT

## Copyright

Copyright (c) 2010, 2011, 2012, 2013 Marius L. Jøhndal.

[1]: http://www.sil.org/iso639-3/scope.asp#M "Explanation of macrolanguages"
