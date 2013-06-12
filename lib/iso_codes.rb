require 'zlib'
require 'iso_codes/version'

module ISOCodes
  # Version of the ISO 639-3 code set supported (see
  # http://www.sil.org/iso639-3/download.asp).
  ISO_639_3_VERSION = '20110525'

  # Version of the ISO 639-3 macrolanguage mappings supported (see
  # http://www.sil.org/iso639-3/download.asp).
  ISO_639_3_MACROLANGUAGE_MAPPINGS_VERSION = '20100128'

  class Language
    # ISO 639-3 identifier for the language, or +nil+ if none is defined.
    attr_reader :identifier

    # ISO 639-2 identifier of the bibliographic applications code set for
    # the language, or +nil+ if none is defined.
    attr_reader :alpha3_bibliographic

    # ISO 639-2 identifier of the terminology applications code set for the
    # language, or +nil+ if none is defined.
    attr_reader :alpha3_terminology

    # ISO 639-1 identifier for the language, or +nil+ if none is defined.
    attr_reader :alpha2

    # Language type for the language. Language type is either
    # <tt>:living</tt>, <tt>:extinct</tt>, <tt>:ancient</tt>,
    # <tt>:historic</tt>, <tt>:constructed</tt>, or <tt>:special</tt>. See
    # http://www.sil.org/iso639-3/types.asp for a description.
    attr_reader :language_type

    # Reference name for the language.
    attr_reader :reference_name

    def initialize(identifier, part2b, part2t, part1, language_type, ref_name)
      @identifier = identifier
      @alpha3_bibliographic = part2b
      @alpha3_terminology = part2t
      @alpha2 = part1
      @language_type = language_type
      @reference_name = ref_name
    end
  end

  class SpecialSituationLanguage < Language
    def initialize(individual_languages, macrolanguage, *rest)
      super(*rest)

      raise ArgumentError, "macrolanguage given for special situation language" if macrolanguage
      raise ArgumentError, "individual languages given for special situation language" if individual_languages
    end
  end

  class IndividualLanguage < Language
    def initialize(individual_languages, macrolanguage, *rest)
      super(*rest)

      raise ArgumentError, "individual languages given for individual language" if individual_languages

      @macrolanguage = macrolanguage
    end

    # Returns the macrolanguage the language belongs to or +nil+ if not
    # part of any macrolanguage.
    def macrolanguage
      ISOCodes::find_iso_639_3_language(@macrolanguage)
    end
  end

  class Macrolanguage < Language
    def initialize(individual_languages, macrolanguage, *rest)
      super(*rest)

      raise ArgumentError, "macrolanguage given for macrolanguage" if macrolanguage

      @individual_languages = individual_languages
    end

    # Returns an array of individual languages or an empty array if no
    # individual languages are defined.
    def individual_languages
      @individual_languages.map { |c| ISOCodes::find_iso_639_3_language(c) }
    end
  end

  class << self
    # Returns an array containing all ISO 639-3 language codes.
    def all_iso_639_3_codes
      @@iso_639_3.keys
    end

    # Returns an object describing the language identified by the language
    # code +code+.
    def find_language(code)
      find_iso_639_3_language(code)
    end

    # Returns an object describing the language identified by the ISO 639-3
    # identifier +code+.
    def find_iso_639_3_language(code)
      if @@iso_639_3.has_key?(code)
        klass, *rest = @@iso_639_3[code]
        klass.new(*rest)
      else
        nil
      end
    end
  end

  private

  DATA_PATH = File.expand_path(File.dirname(__FILE__))

  class << self
    def get_data_filename(filename)
      File.join(DATA_PATH, filename)
    end

    def read_data_file(filename, field_count, delimiter, skip_first)
      Zlib::GzipReader.open(get_data_filename(filename)).each_line do |l|
        if skip_first
          skip_first = false
          next
        end

        yield l.chomp.split(delimiter, field_count)
      end
    end

    def load_iso_639_3
      data = {}

      read_data_file("iso-639-3_#{ISO_639_3_VERSION}.tab.gz", 8, "\t", true) do |args|
        identifier, part2b, part2t, part1, scope, language_type, ref_name, _ = args

        # Sanity checks
        raise ArgumentError, "missing identifier" if identifier.nil?
        raise ArgumentError, "missing reference name" if ref_name.nil?

        klass =
          case scope
          when 'I'
            IndividualLanguage
          when 'M'
            Macrolanguage
          when 'S'
            SpecialSituationLanguage
          else
            raise ArgumentError, "invalid scope"
          end

        language_type =
          case language_type
          when 'L'
            :living
          when 'E'
            :extinct
          when 'A'
            :ancient
          when 'H'
            :historic
          when 'C'
            :constructed
          when 'S'
            :special
          else
            raise ArgumentError, "invalid language type"
          end

        data[identifier] = [klass, nil, nil, identifier, part2b, part2t, part1, language_type, ref_name]
      end

      read_data_file("iso-639-3-macrolanguages_#{ISO_639_3_MACROLANGUAGE_MAPPINGS_VERSION}.tab.gz", 3, "\t", true) do |args|
        macrolanguage_identifier, individual_language_identifier, status = args

        case status
        when 'R'
          next #FIXME
        when 'A'
        else
          raise ArgumentError, "invalid status"
        end

        # Add macrolanguage to the individual language
        raise "individual language already has a macrolanguage " if data[individual_language_identifier][2]
        data[individual_language_identifier][2] = macrolanguage_identifier

        # Add individual language to macrolanguage
        data[macrolanguage_identifier][1] ||= []
        data[macrolanguage_identifier][1] << individual_language_identifier
      end

      data.each_pair { |k, v| v.freeze }

      data
    end
  end

  @@iso_639_3 = load_iso_639_3
end
